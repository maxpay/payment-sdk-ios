import Foundation

/**
 Object is used to send request with full payment data.
 
    - important:
        Supporting of this transaction type depends on acquirer side. Please, clarify the information before implementation of this transaction type. In most cases optional parameters are required for acquirers.
 */
internal struct PAYTransactionRequest: Codable {
    
    /// API version
    internal let apiVersion: Int
    
    /// Type of authorization
    internal let authType: String
    
    /// Merchant public key
    internal let publicKey: String

    /// Request signature
    internal var signature: String
    
    /// User Id on merchant's side
    internal let merchantUserID: String?
    
    /// Merchant's domain name
    internal let merchantDomainName: String?
    
    /// Affiliate identifier
    internal let merchantAffiliateID: String?
    
    /// Name of the product
    internal let merchantProductName: String?
    
    /// Descriptor of the merchant
    internal let merchantDescriptor: String?
    
    /// Descriptor phone of the merchant
    internal let merchantPhone: String?
    
    /// Reference of the MID in Pay system
    internal let midReference: String?
    
    /// The credentials on file
    internal let cofType: String?
    
    /// Once the order has been processed merchant will receive a final response (callback) regarding the transaction status to this URL
    internal let callbackURL: String
    
    /// Once the verification process has been done a customer will be redirected to this URL
    internal let redirectURL: String
    
    /// Unique transaction Id
    internal let transactionUniqueID: String
    
    /// Type of the transaction
    internal let transactionType: String
    
    /// Amount of the transaction
    internal let amount: String
    
    /// Currency of the transaction
    internal let currency: String
    
    /// Number of the card
    internal let cardNumber: String
    
    /// Card expiration month. Month number from '01' to '12'
    internal let cardExpMonth: String
    
    /// Card expiration year
    internal let cardExpYear: String
    
    /// Card Verification Value
    internal let cvv: String?
    
    /// Cardholder name
    internal let cardHolder: String
    
    /// Hashed value of card number, expiry date and cardholder name
    internal let token: String?

    /// The first name of the customer
    internal let firstName: String
    
    /// The last name of the customer
    internal let lastName: String
    
    /// Customer's phone number. For testmode the value should be passed with + symbol
    internal let phone: String?
    
    /// Customer's email address
    internal let email: String
    
    /// Customer's IP address. Not all acquirers support IPv6 format
    internal let ip: String
    
    /// Date of birth of the customer
    internal let birthday: String?
    
    /// Customer's address
    internal let address: String?
    
    /// Customer's city
    internal let city: String?
    
    /// Customer's state
    internal let state: String?
    
    /// Customer's zip
    internal let zip: String?
    
    /// Customer's country
    internal let country: String

    enum CodingKeys: String, CodingKey {
        
        case apiVersion = "api_version"
        case authType = "auth_type"
        case publicKey = "public_key"
        case signature
        case transactionUniqueID = "transaction_unique_id"
        case transactionType = "transaction_type"
        case amount
        case currency
        case cardNumber = "card_number"
        case cardExpMonth = "card_exp_month"
        case cardExpYear = "card_exp_year"
        case cvv
        case cardHolder = "card_holder"
        case token

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
        case birthday = "date_of_birth"

        case callbackURL = "callback_url"
        case redirectURL = "redirect_url"

        case merchantUserID = "merchant_user_id"
        case merchantDomainName = "merchant_domain_name"
        case merchantAffiliateID = "merchant_affiliate_id"
        case merchantProductName = "merchant_product_name"
        case merchantDescriptor = "descriptor_merchant"
        case merchantPhone = "descriptor_phone"
        case midReference = "mid_reference"
        case cofType = "cof_type"
    }
}

private let excludedFieldsForSignature: Set = ["signature", "card_number", "card_exp_month", "card_exp_year", "cvv", "card_holder", "public_key"]

extension PAYTransactionRequest {
    
    
    
    /**
    Creates a new PAYTransactionRequest
        
    - returns:
        An initialized transaction request object.
        
    - parameters:
       - merchant: information about merchant, see **PAYMerchant**
       - customer: information about customer, see **PAYCustomer**
       - order: information about order, see **PAYOrder**
       - paymentCard: information about payment card, see **PAYCard**
       - signature: hashed info for transaction
    */
    init(merchant: PAYMerchant, customer: PAYCustomer, order: PAYOrder, paymentCard: PAYCard) {
        let sale3DRedirect = merchant.sale3DRedirect
        let geo = customer.address
        
        self.apiVersion = merchant.apiVersion
        self.authType = merchant.authType.rawValue
        self.publicKey = merchant.publicKey
        self.signature = ""
        self.merchantUserID = merchant.merchantUserID
        self.merchantDomainName = merchant.merchantDomainName
        self.merchantAffiliateID = merchant.merchantAffiliateID
        self.merchantProductName = merchant.merchantProductName
        self.merchantDescriptor = merchant.merchantDescriptor
        self.merchantPhone = merchant.merchantPhone
        self.midReference = merchant.midReference
        self.cofType = merchant.cofType?.rawValue
        
        self.redirectURL = sale3DRedirect?.redirectURL ?? ""
        self.callbackURL = sale3DRedirect?.callbackURL ?? ""
        
        self.transactionUniqueID = order.transactionUniqueID
        self.transactionType = order.transactionType.rawValue
        self.amount = order.amountString
        self.currency = order.currency
        
        self.cardNumber = paymentCard.cardNumber
        self.cardExpMonth = paymentCard.cardExpMonth
        self.cardExpYear = paymentCard.cardExpYear
        self.cvv = paymentCard.cvv
        self.cardHolder = paymentCard.cardHolder
        self.token = paymentCard.token
        
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

    func generateDataForSignature() -> String {
        return self
            .pay_dictionary?
            .compactMapValues { $0 }
            .mapValues { String(describing: $0) }
            .filter { !$1.isEmpty && !excludedFieldsForSignature.contains($0) }
            .map { $0 + "=" + $1 }
            .sorted()
            .joined(separator: "|")
            ?? ""
    }

}
