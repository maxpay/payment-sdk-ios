import UIKit
import WebKit

/**
View controller contains web view with 3DSecure confirmation fields.
 
Will send confirmation info and redirect user back to **PAYPaymentViewController**.

 - important:
    Should create programmaticaly with init(transactionType: auth3DRedirect: response: completion:) method.
 */

final internal class PAYWebViewController: UIViewController {
    
    // MARK: - Properties
    
    private let webView = WKWebView()
    
    private let transactionType: PAYTransactionType
    private let auth3DRedirect: String?
    private let sale3DRedirect: String?
    private let response: PAYTransactionResponse
    private let completion: (Result<PAYTransactionResponse, Error>) -> ()
    
    private let networkService = PAYNetworkService.shared

    // MARK: - Init and Deinit
    
    /**
    Single designited init to create PAYPayementViewController.
        
    - returns:
        An initialized view controller object.
        
    - parameters:
       - transactionType: type of transaction, see **PAYTransactionType**.
       - auth3DRedirect: String with redirection URL for AUTH3D transaction.
       - response: The response from previous stage of authorization, see **PAYTransactionResponse**
       - completion: A block object to be executed when the transaction ends.
    */
    init(transactionType: PAYTransactionType, auth3DRedirect: String?, sale3DRedirect: String?, response: PAYTransactionResponse, completion: @escaping (Result<PAYTransactionResponse, Error>) -> ()) {
        self.transactionType = transactionType
        self.response = response
        self.auth3DRedirect = auth3DRedirect
        self.sale3DRedirect = sale3DRedirect
        self.completion = completion
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Should not use in .storyboard file")
    }
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.configureUI()
        
        switch self.transactionType {
        case .auth3d:
            self.startAuth3D()
        default:
            self.startSale3D()
        }
    }
    
    // MARK: - Private
    
    private func configureUI() {
        guard let rootView = self.view else { return }
        
        let rootMargins = rootView.layoutMarginsGuide
        rootView.backgroundColor = .white

        let webView = self.webView
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.configuration.preferences.javaScriptEnabled = true
        webView.navigationDelegate = self
        rootView.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: rootMargins.topAnchor),
            webView.bottomAnchor.constraint(equalTo: rootMargins.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
        ])
    }
    
    // MARK: - Auth3D Flow
    
    private func startAuth3D() {
        guard let confirmation = self.createAuth3DConfirmation() else { return }
        guard let acsRequest = self.createACSRequest(confirmation: confirmation) else { return }

        self.networkService.loadHTML(request: acsRequest) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.completion(.failure(error))
            case .success(let htmlString):
                DispatchQueue.main.async {
                    self?.webView.loadHTMLString(htmlString, baseURL: nil)
                }
            }
        }
    }
    
    private func createAuth3DConfirmation() -> PAYAuth3DConfirm? {
        let auth3DResponse = self.response
        
        guard
            let pareq = auth3DResponse.paymentAuthRequest,
            let redirect = self.auth3DRedirect,
            let ref = auth3DResponse.reference
        else { return nil }

        return PAYAuth3DConfirm(pareq: pareq, redirect: redirect, reference: ref)
    }
    
    private func createACSRequest(confirmation: PAYAuth3DConfirm) -> URLRequest? {
        guard let acsURL = self.response.acsURL else { return nil }
        
        var request = URLRequest(url: acsURL)
        request.httpMethod = PAYHTTPMethodType.post.rawValue
        request.httpBody = Data(confirmation)
        
        return request
    }
    
    private func finishAuth3D(callback: String) {
        self.dismiss(animated: true, completion: nil)
        self.completion(.success(response))
    }
    
    // MARK: - Sale3D Flow

    private func startSale3D() {
        let sale3DResponse = self.response

        guard let accURL = sale3DResponse.accessControlServer, let url = URL(string: accURL) else { return }

        let request = URLRequest(url: url)

        DispatchQueue.main.async {
            self.webView.load(request)
        }
    }

    private func finishSale3D(callback: String) {
        self.dismiss(animated: true, completion: nil)
        self.completion(.success(response))
    }
}

extension PAYWebViewController: WKNavigationDelegate {
    
    internal func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlString = navigationAction.request.url?.description {
            
            if self.auth3DRedirect != nil, urlString.hasPrefix(self.auth3DRedirect ?? "") {
                self.finishAuth3D(callback: urlString)
                decisionHandler(.cancel)
                
                return
            }
            else if self.sale3DRedirect != nil, urlString.hasPrefix(self.sale3DRedirect ?? "") {
                self.finishSale3D(callback: urlString)
                decisionHandler(.cancel)
                
                return
            }
        }
        
        decisionHandler(.allow)
    }
}
