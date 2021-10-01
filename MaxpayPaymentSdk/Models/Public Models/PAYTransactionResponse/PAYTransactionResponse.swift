import Foundation

/**
Object is used to represent response from Pay processijng center.

   - important:
        If response status is 'declined' or 'error', property error will contain NSError with appropriate code and message
*/
public struct PAYTransactionResponse: Codable {
    
    /// API version
    public let apiVersion: Int
    
    /// Merchant account
    public let merchantAcc: String?
    
    /// Id of the session
    public let sessionID: String
    
    /// Unique transaction Id
    public let transactionUniqueID: String?
    
    /// Hashed value of card number, expiry date and cardholder name
    public let token: String?
    
    /// Reference of the transaction in Pay system
    public let reference: String?
    
    /// Timestamp of the transaction
    public let timestamp: Int
    
    /// Authorization code
    public let authCode: String?
    
    /// Payment Authentication Request (PaReq). Parameter may not be received
    public let paymentAuthRequest: String?
    
    /// Access Control Server (ACS). Parameter may not be received
    public let accessControlServer: String?
    
    /// Electronic Commerce Indicators (ECI). Parameter may not be received
    /// Possible values 1, 2, 5, 6, 7
    public let eci: Int?

    /// Status of the transaction
    /// Possible values: success, decline, error
    public let status: String
    
    /// Response code regarding the transaction result
    public let responseCode: Int
    
    /// Response message regarding the transaction result
    public let message: String
    
    /// Standard iOS error if status != "success'
    public var error: NSError? {
        let responseStatus = self.status.lowercased()
        
        return responseStatus == "success"
        ? nil
        : NSError(domain: "mxp.transaction.response",
                  code: self.responseCode,
                  userInfo: [NSLocalizedDescriptionKey: message, NSLocalizedFailureReasonErrorKey: message])
    }
    
    /// URL from accessControlServer
    var acsURL: URL? {
        return URL(string: self.accessControlServer ?? "")
    }
    
    public enum CodingKeys: String, CodingKey {
    
        case apiVersion = "api_version"
        case merchantAcc = "merchant_account"
        case sessionID = "sessionid"
        case transactionUniqueID = "transaction_unique_id"
        case token
        case reference
        case timestamp
        case authCode = "authcode"

        case paymentAuthRequest = "pareq"
        case accessControlServer = "acs_url"
        case eci
        
        case status
        case responseCode = "code"
        case message
    }
    
    public init(apiVersion: Int,
                merchantAcc: String?,
                sessionID: String,
                transactionUniqueID: String?,
                token: String?,
                reference: String?,
                timestamp: Int,
                authCode: String?,
                paymentAuthRequest: String?,
                accessControlServer: String?,
                eci: Int?,
                status: String,
                responseCode: Int,
                message: String)
    {
        self.apiVersion = apiVersion
        self.merchantAcc = merchantAcc
        self.sessionID = sessionID
        self.transactionUniqueID = transactionUniqueID
        self.token = token
        self.reference = reference
        self.timestamp = timestamp
        self.authCode = authCode
        self.paymentAuthRequest = paymentAuthRequest
        self.accessControlServer = accessControlServer
        self.eci = eci
        self.status = status
        self.responseCode = responseCode
        self.message = message
    }
}
