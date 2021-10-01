import Foundation

/**
 Object is used to create signature for payment request, contain all needed data in open format.
 
    - important:
        Supporting of this transaction type depends on acquirer side. Please, clarify the information before implementation of this transaction type. In most cases optional parameters are required for acquirers.
 */
public struct PAYSignatureInfo: Codable {
    
    /// API version
    public let apiVersion: Int
    
    /// Type of authorization
    public let authType: String
    
    /// Unique transaction Id
    public let transactionUniqueID: String
    
    /// Type of the transaction
    public let transactionType: String
    
    /// Amount of the transaction
    public let amount: String
    
    /// Currency of the transaction
    public let currency: String
    
    /// The first name of the customer
    public let firstName: String
    
    /// The last name of the customer
    public let lastName: String
    
    /// Customer's address
    public let address: String?
    
    /// Customer's city
    public let city: String?
    
    /// Customer's state
    public let state: String?
    
    /// Customer's zip
    public let zip: String?
    
    /// Customer's country
    public let country: String
    
    /// Customer's phone number. For testmode the value should be passed with + symbol
    public let phone: String?
    
    /// Customer's email address
    public let email: String
    
    /// Customer's IP address. Not all acquirers support IPv6 format
    public let ip: String
    
    /// Once the order has been processed merchant will receive a final response (callback) regarding the transaction status to this URL
    public let callbackURL: String
    
    /// Once the verification process has been done a customer will be redirected to this URL
    public let redirectURL: String
    
    /// Date of birth of the customer
    public let birthday: String?

    enum CodingKeys: String, CodingKey {
        
        case apiVersion = "api_version"
        case authType = "auth_type"
        case transactionUniqueID = "transaction_unique_id"
        case transactionType = "transaction_type"
        case amount
        case currency

        case firstName = "first_name"
        case lastName = "last_name"
        case address
        case city
        case state
        case zip
        case country
        case phone = "user_phone"
        case email = "user_email"
        case ip = "user_ip"

        case callbackURL = "callback_url"
        case redirectURL = "redirect_url"
        
        case birthday = "date_of_birth"
    }
}

extension PAYSignatureInfo {
    
    /**
    Creates a new PAYTransactionRequest
        
    - returns:
        An initialized transaction request object.
        
    - parameters:
       - initInfo: base information about payment request, see **PAYInitInfo**
       - paymentInfo: base information about customer and transaction, see **PAYPaymentInfo**
    */
    
    public init(initInfo: PAYInitInfo, paymentInfo: PAYPaymentInfo) {
        
        self.apiVersion = initInfo.apiVersion
        self.authType = PAYAuthorizationType.signature.rawValue
        
        self.redirectURL = paymentInfo.sale3dRedirectUrl
        self.callbackURL = paymentInfo.sale3dCallBackUrl
        
        self.transactionUniqueID = paymentInfo.transactionID.description
        self.transactionType = paymentInfo.transactionType.rawValue
        self.amount = paymentInfo.amount.description
        self.currency = paymentInfo.currency
                
        self.firstName = paymentInfo.firstName
        self.lastName = paymentInfo.lastName
        self.phone = paymentInfo.userPhone
        self.email = paymentInfo.userEmail
        self.ip = PAYIPAddressProvider.getIPAddress()
        self.birthday = paymentInfo.birthday
        
        self.address = paymentInfo.address
        self.city = paymentInfo.city
        self.state = paymentInfo.state
        self.zip = paymentInfo.zip
        self.country = paymentInfo.country
    }
    
    /**
    Creates a new PAYTransactionRequest
        
    - returns:
        An initialized transaction request object.
        
    - parameters:
       - merchant: information about merchant, see **PAYMerchant**
       - customer: information about customer, see **PAYCustomer**
       - order: information about order, see **PAYOrder**
    */
    internal init(merchant: PAYMerchant, customer: PAYCustomer, order: PAYOrder) {
        let sale3DRedirect = merchant.sale3DRedirect
        let geo = customer.address
        
        self.apiVersion = merchant.apiVersion
        self.authType = merchant.authType.rawValue
        
        self.redirectURL = sale3DRedirect?.redirectURL ?? ""
        self.callbackURL = sale3DRedirect?.callbackURL ?? ""
        
        self.transactionUniqueID = order.transactionUniqueID
        self.transactionType = order.transactionType.rawValue
        self.amount = order.amountString
        self.currency = order.currency
        
        self.firstName = customer.firstName
        self.lastName = customer.lastName
        self.phone = customer.phone
        self.email = customer.email
        self.ip = customer.ip
        self.birthday = customer.formattedBirthday
        
        self.address = geo.address
        self.city = geo.city
        self.state = geo.state
        self.zip = geo.zip
        self.country = geo.country
    }
}
