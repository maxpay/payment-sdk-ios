import UIKit
import WebKit

/**
View controller contains a credit card and billing address entry form that the user can fill out.
 
Will send user date with payment request to Maxpay processing center.

 - important:
    Should create programmaticaly with init(configuration: theme: completion:) method.
 */
final public class PAYPaymentViewController: UIViewController {
    
    // MARK: - Properties
    
    private let theme: PAYTheme
    private let updateSignatureBlock: (PAYSignatureInfo, @escaping (String) -> ()) -> ()
    private let completion: (Result<PAYTransactionResponse, Error>) -> ()
    private let transactionType: PAYTransactionType
    private let networkService = PAYNetworkService.shared
    private let lockView = PAYLockView(frame: UIScreen.main.bounds)
    
    private var paymentConfiguration: PAYPaymentConfiguration
    private var rootView: PAYPaymentRootView? { return self.viewIfLoaded as? PAYPaymentRootView }
    private var payButton: UIButton? { return self.rootView?.payButton }
    private var keyboardService: PAYKeyboardNotificationService?
    private var fieldStateProvider: PAYFieldStateObserver?

    // MARK: - Init and Deinit
    
/**
 Single designited init to create PAYPayementViewController.
     
 - returns:
     An initialized view controller object.
     
 - parameters:
    - initInfo: Object contains information about api version, public key, input fields configuration e.t.c., see **PAYInitInfo**.
    - paymentInfo: Object contains informatino about customer, payment currency and amount e.t.c, see **PAYPaymentInfo**.
    - callbacks: A object wrapper, combined callbacks for calculate signature and handling result of payment procedure, , see **PAYCallback**.
 */
    
    public init(initInfo: PAYInitInfo, paymentInfo: PAYPaymentInfo, callbacks: PAYCallback) {
        //  transform from common with Android version models to iOS specific models
        let configuration = PAYPaymentConfiguration(initInfo: initInfo, paymentInfo: paymentInfo)
        
        self.paymentConfiguration = configuration
        self.updateSignatureBlock = callbacks.onNeedCalculateSignature
        self.theme = initInfo.theme
        self.completion = callbacks.onResponse
        self.transactionType = configuration.order.transactionType
        self.networkService.api.isProduction = configuration.isProduction
        
        debugPrint(configuration.order)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required internal init?(coder: NSCoder) {
        fatalError("Should not use in .storyboard file")
    }

    // MARK: - View Lifecycle
    
    public override func loadView() {
        self.view = PAYPaymentRootView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.configureServices()
        self.configureUI()
        self.bindFields()
        self.bindActions()
    }
    
    // MARK: - Configure
    
    private func configureServices() {
        //  keyboard appearance handling
        self.keyboardService = PAYKeyboardNotificationService() { [weak self] newFrame in
            if self?.viewIfLoaded?.window != nil {
                self?.rootView?.mainScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: newFrame.height, right: 0)
            }
        }
    }
    
    private func configureUI() {
        let rootView = self.rootView
        let configuration = self.paymentConfiguration
        let lockView = self.lockView
        
        //  will call cascade update configuration and theme in subview
        rootView?.set(paymentConfiguration: configuration, theme: self.theme)
        
        //  fill checkboxes block
        rootView?.conditionsView
            .add(.autoDebitConfirmation)
            .add(.termsAndPrivacy)
        
        rootView?.inputCardView.birthdayContentContainer.isHidden = !configuration.formFieldsConfiguration.showBirthdayField
        rootView?.billingView.isHidden = !configuration.formFieldsConfiguration.showBillingAddressLayout
        
        self.title = PAYL10nService.shared.localized(key: .paymentScreenTitle)
        self.pay_addHideKeyboardTap()
        
        //  lock view should hide navigation bar
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(lockView)
            lockView.hide()
        }
    }
    
    // MARK: - Bind Objects
    
    private func bindFields() {
        guard
            let cardFields = self.rootView?.inputCardView.textFields,
            let addressFields = self.rootView?.billingView.textFields,
            let checkboxes = self.rootView?.conditionsView.checkboxes
        else { return }
        
        let textFields = cardFields + addressFields
        
        self.fieldStateProvider = PAYFieldStateObserver(textFields: textFields, checkboxes: checkboxes) { isAllValid in
            self.payButton?.isEnabled = isAllValid
        }
    }
    
    private func bindActions() {
        self.payButton?.addTarget(self, action: #selector(self.onPay), for: .touchUpInside)
    }
    
    @objc
    private func onPay(_ sender: UIButton) {
        let rootView = self.rootView
        
        //  or conditions not needed or they all selected
        self.view.endEditing(true)
        self.lockView.show()
        self.payButton?.isEnabled = false
        
        guard let paymentCard = rootView?.getCardInfo().paymentCard else { return }
        
        let currentConfig = self.paymentConfiguration
        let completion = self.process(result:)
        let newCustomer = currentConfig.customer
            .replace(email: rootView?.getEmailInfo())
            .replace(birthday: rootView?.getBirthday())
            .replace(address: rootView?.getBillingAddress())
            .replace(firstname: rootView?.getFirstname(), lastname: rootView?.getLastname())
            .replace(phone: rootView?.getPhone())
        let newSignatureInfo = PAYSignatureInfo(merchant: currentConfig.merchant, customer: newCustomer, order: currentConfig.order)
        
        //  update signature and send request
        self.updateSignatureBlock(newSignatureInfo) { [weak self] newSignature in
            self?.paymentConfiguration = PAYPaymentConfiguration(merchant: currentConfig.merchant,
                                                                 customer: newCustomer,
                                                                 order: currentConfig.order,
                                                                 formFieldsConfiguration: currentConfig.formFieldsConfiguration,
                                                                 isProduction: currentConfig.isProduction)
            
            guard let configuration = self?.paymentConfiguration else {
                self?.process(result: .failure(PAYPaymentControllerError.missingConfiguration))
                
                return
            }
            
            let transactionRequest = PAYTransactionRequest(merchant: configuration.merchant,
                                                           customer: configuration.customer,
                                                           order: configuration.order,
                                                           paymentCard: paymentCard,
                                                           signature: newSignature)
            self?.networkService.send(transactionRequest: transactionRequest, completion: completion)
            self?.view.endEditing(true)
        }
    }
}

//  MARK: - Transaction Error/Response Processing

extension PAYPaymentViewController {
    
    private func process(result: Result<PAYTransactionResponse, Error>) {
        DispatchQueue.main.async {
            self.payButton?.isEnabled = true
            self.lockView.hide()
        }
        
        switch result {
        case .success(let response):
            self.process(response: response)
        case .failure(let error):
            self.process(error: error)
        }
    }
    
    private func process(error: Error) {
        self.completion(.failure(error))
    }
    
    private func process(response: PAYTransactionResponse) {
        if let error = response.error {
            self.completion(.failure(error))

            return
        }
                
        switch self.transactionType {
        case .auth:
            self.process(authResponse: response)
        case .sale:
            self.process(saleResponse: response)
        case .auth3d,.sale3d:
            self.showWebConfirmation(response: response)
        }
    }
    
    private func process(authResponse: PAYTransactionResponse) {
        self.completion(.success(authResponse))
    }
    
    private func process(saleResponse: PAYTransactionResponse) {
        self.completion(.success(saleResponse))
    }
    
    private func showWebConfirmation(response: PAYTransactionResponse) {
        DispatchQueue.main.async {
            let merchant = self.paymentConfiguration.merchant
            let webController = PAYWebViewController.init(transactionType: self.transactionType,
                                                          auth3DRedirect: merchant.auth3DRedirect,
                                                          sale3DRedirect: merchant.sale3DRedirect?.redirectURL,
                                                          response: response,
                                                          completion: self.completion)
            webController.modalPresentationStyle = .fullScreen
            self.present(webController, animated: true)
        }
    }
}
