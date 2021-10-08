import Foundation

/// Object contains all data about merchant.
public struct PAYMerchantInfo {
    
    /// User Id on merchant's side
    public let merchantUserID: String?
    
    /// Merchant's domain name
    public let merchantDomainName: String?
    
    /// Affiliate identifier
    public let merchantAffiliateID: String?
    
    /// Name of the product
    public let merchantProductName: String?
    
    /// Descriptor of the merchant
    public let merchantDescriptor: String?
    
    /// Descriptor phone of the merchant
    public let merchantPhone: String?
    
    /// Reference of the MID in Pay system
    public let midReference: String?
    
    public init(
                merchantUserID: String?,
                merchantDomainName: String?,
                merchantAffiliateID: String?,
                merchantProductName: String?,
                merchantDescriptor: String?,
                merchantPhone: String?,
                midReference: String?
    ) {
        self.merchantUserID = merchantUserID
        self.merchantDomainName = merchantDomainName
        self.merchantAffiliateID = merchantAffiliateID
        self.merchantProductName = merchantProductName
        self.merchantDescriptor = merchantDescriptor
        self.merchantPhone = merchantPhone
        self.midReference = midReference
    }
}
