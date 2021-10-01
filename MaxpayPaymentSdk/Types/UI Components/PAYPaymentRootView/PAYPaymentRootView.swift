import UIKit

final class PAYPaymentRootView: PAYNibLoadableView {
    
    // MARK: - Properties
    
    @IBOutlet internal var mainContainerView: UIView!
    @IBOutlet internal var mainScrollView: UIScrollView!
    @IBOutlet internal var mainStackView: UIStackView!
    
    @IBOutlet internal var headerTitleLabel: UILabel!
    @IBOutlet internal var headerPriceLabel: UILabel!
    @IBOutlet internal var headerSeparatorView: UIView!
    
    @IBOutlet internal var inputCardView: PAYInputCardView!
    @IBOutlet internal var billingView: PAYBillingView!
    @IBOutlet internal var conditionsView: PAYConditionsView!
    
    @IBOutlet internal var payButtonContainer: UIView!
    @IBOutlet internal var payButton: UIButton!

    @IBOutlet internal var topButtonConstraint: NSLayoutConstraint!
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2  //  only two numbers after coma or point, e.t. $99.99
        formatter.numberStyle = .currency
        self.paymentConfiguration.map { formatter.currencyCode = $0.order.currency }
        
        return formatter
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let viewMaxY = self.mainContainerView.frame.maxY
        let stackMaxY = self.mainStackView.frame.maxY
        let safeBottom = self.safeAreaInsets.bottom
        let offset = viewMaxY - stackMaxY - safeBottom
        
        if offset != 0 {
            self.topButtonConstraint.constant = offset > 0 ? offset : 0
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - Configure UI
    
    // This view creates throw standard init(), so nor 'awakeFromNib' neither 'configureUI' won't be called
    override func loadNib() -> UIView {
        defer {
            let l10n = self.l10nService
            
            self.headerTitleLabel.text = l10n.localized(key: .paymentAmount)
            
            let button = self.payButton
            button?.setTitle(l10n.localized(key: .paymentPayButtonTitle), for: .normal)
            button?.titleLabel?.numberOfLines = 1
            button?.titleLabel?.adjustsFontSizeToFitWidth = true
            button?.titleLabel?.lineBreakMode = .byClipping
        }
        
        return super.loadNib()
    }
    
    // MARK: - Update UI
    
    //  will call after update configuration and theme
    override internal func updateUI() {
        super.updateUI()
        
        let theme = self.theme

        [self.inputCardView, self.conditionsView, self.billingView].forEach {
            $0?.set(paymentConfiguration: self.paymentConfiguration, theme: self.theme)
        }
        
        self.mainContainerView.backgroundColor = theme.backgroundColor
        
        self.headerTitleLabel.textColor = theme.headerTitleColor
        self.headerPriceLabel.textColor = theme.headerAmountColor
        self.headerSeparatorView.backgroundColor = theme.headerSeparatorColor
        self.headerTitleLabel.font = theme.headerStandardTitleFont
        self.headerPriceLabel.font = theme.headerAmountFont
        
        let button = self.payButton
        button?.backgroundColor = theme.enabledButtonBackgroundColor
        button?.setTitleColor(theme.enabledButtonTitleColor, for: .normal)
        button?.setTitleColor(theme.disabledButtonTitleColor, for: .disabled)
        button?.setBackgroundImage(theme.disabledButtonBackgroundColor.pay_image(), for: .disabled)
        button?.titleLabel?.font = theme.buttonTitleFont
        button?.pay_cornerRadius = theme.buttonCornerRadius
        
        self.paymentConfiguration.map {
            let amount = self.numberFormatter.pay_string($0.order.amount) ?? ""
            let title = self.l10nService.localized(key: .paymentPayButtonTitle) + " " + amount

            button?.setTitle(title, for: .normal)
            self.headerPriceLabel.text = amount
        }
    }
    
    // MARK: - Public
    
    internal func getCardInfo() -> PAYCardInfo {
        return self.inputCardView.getCardInfo()
    }
    
    internal func getEmailInfo() -> String? {
        return self.inputCardView.emailTextField.text
    }
    
    internal func getBirthday() -> Date? {
        guard let text = self.inputCardView.birthdayTextField.text else { return nil }
    
        let birthdayDate = DateFormatter.pay_birthdayFormatter.date(from: text)
        
        return birthdayDate
    }
    
    internal func getBillingAddress() -> PAYBillingAddress {
        let billingView = self.billingView
        
        return PAYBillingAddress(country: billingView?.countryTextField.text ?? "",
                                 state: billingView?.stateTextField.text,
                                 city: billingView?.cityTextField.text,
                                 address: billingView?.addressTextField.text,
                                 zip: billingView?.zipTextField.text)
    }
    
    internal func getFirstname() -> String? {
        return self.billingView?.firstnameTextField.text?.trimmingCharacters(in: .whitespaces)
    }
    
    internal func getLastname() -> String? {
        return self.billingView?.lastnameTextField.text?.trimmingCharacters(in: .whitespaces)
    }
    
    internal func getPhone() -> String? {
        return self.billingView?.phoneTextField.text?.trimmingCharacters(in: .whitespaces)
    }
}
