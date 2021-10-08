import Foundation

/**
Represents all data and options you can set for a payment

You provide an `PAYPaymentInfo` object to your `PAYPaymentViewController` on initialization.
*/

public struct PAYPaymentInfo {
    
    /// Type of authorization
    public let transactionType: PAYTransactionType
    
    /// Unique transaction Id
    public let transactionID: String
    
    /// Amount of the transaction
    public let amount: Float
     
    /// The first name of the customer
    public let firstName: String
    
    /// The last name of the customer
    public let lastName: String
    
    /// Customer's address
    public let address: String
    
    /// Customer's city
    public let city: String
    
    /// Customer's state
    public let state: String
    
    /// Customer's zip
    public let zip: String
    
    /// Customer's country
    ///  ISO 3166-1, alpha-3
    public let country: String
    
    /// Customer's phone number. For testmode the value should be passed with + symbol
    public let userPhone: String
    
    /// Customer's email address
    public let userEmail: String
    
    ///  Redirection for AUTH3D transaction type
    public let auth3dRedirectUrl: String
    
    ///  Callback for SALE3D transaction type
    public let sale3dCallBackUrl: String
    
    ///  Redirections for SALE3D transaction type
    public let sale3dRedirectUrl: String
    
    /// Currency of the transaction
    public let currency: String
    
    /// Date of birth of the customer in format YYYY-MM-DD
    public let birthday: String
    
    public let merchantInfo: PAYMerchantInfo?
    
    public init(
        transactionType: PAYTransactionType,
        transactionID: String,
        amount: Float,
        firstName: String,
        lastName: String,
        address: String,
        city: String,
        state: String,
        zip: String,
        country: String,
        userPhone: String,
        userEmail: String,
        auth3dRedirectUrl: String,
        sale3dCallBackUrl: String,
        sale3dRedirectUrl: String,
        currency: String,
        birthday: String,
        merchantInfo: PAYMerchantInfo? = nil
    ) {
        self.transactionType = transactionType
        self.transactionID = transactionID
        self.amount = amount
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.city = city
        self.state = state
        self.zip = zip
        self.country = country
        self.userPhone = userPhone
        self.userEmail = userEmail
        self.auth3dRedirectUrl = auth3dRedirectUrl
        self.sale3dCallBackUrl = sale3dCallBackUrl
        self.sale3dRedirectUrl = sale3dRedirectUrl
        self.currency = currency
        self.birthday = birthday
        self.merchantInfo = merchantInfo
    }
}
