import Foundation

/// Object contains all data about merchant.
internal struct PAYMerchant {
    
    /// API version
    internal let apiVersion: Int
    
    /// Type of authorization
    internal let authType: PAYAuthorizationType
    
    /// Merchant public key
    internal let publicKey: String

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
    internal let cofType: PAYCOFType?
    
    ///  Redirections for SALE3D transaction type
    internal let sale3DRedirect: PAYSale3DRedirect?
    
    ///  Redirection for AUTH3D transaction type
    internal let auth3DRedirect: String?
    
    internal init(apiVersion: Int,
                publicKey: String,
                merchantUserID: String?,
                merchantDomainName: String?,
                merchantAffiliateID: String?,
                merchantProductName: String?,
                merchantDescriptor: String?,
                merchantPhone: String?,
                midReference: String?,
                cofType: PAYCOFType?,
                sale3DRedirect: PAYSale3DRedirect?,
                auth3DRedirect: String?)
    {
        self.apiVersion = apiVersion
        self.authType = .signature
        self.publicKey = publicKey
        self.merchantUserID = merchantUserID
        self.merchantDomainName = merchantDomainName
        self.merchantAffiliateID = merchantAffiliateID
        self.merchantProductName = merchantProductName
        self.merchantDescriptor = merchantDescriptor
        self.merchantPhone = merchantPhone
        self.midReference = midReference
        self.cofType = cofType
        self.sale3DRedirect = sale3DRedirect
        self.auth3DRedirect = auth3DRedirect
    }
}

internal struct PAYSale3DRedirect {
    /// Once the order has been processed merchant will receive a final response (callback) regarding the transaction status to this URL
    internal let callbackURL: String
    
    /// Once the verification process has been done a customer will be redirected to this URL
    internal let redirectURL: String
    
    internal init(callbackURL: String, redirectURL: String) {
        self.callbackURL = callbackURL
        self.redirectURL = redirectURL
    }
}

extension PAYMerchant {
    
    internal init(initInfo: PAYInitInfo, paymentInfo: PAYPaymentInfo) {
        self.init(apiVersion: initInfo.apiVersion,
                  publicKey: initInfo.publicKey,
                  merchantUserID: nil,
                  merchantDomainName: nil,
                  merchantAffiliateID: nil,
                  merchantProductName: nil,
                  merchantDescriptor: nil,
                  merchantPhone: nil,
                  midReference: nil,
                  cofType: nil,
                  sale3DRedirect: PAYSale3DRedirect(callbackURL: paymentInfo.sale3dCallBackUrl, redirectURL: paymentInfo.sale3dRedirectUrl),
                  auth3DRedirect: paymentInfo.auth3dRedirectUrl)
    }
}
