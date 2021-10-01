import Foundation

///  localization keys
internal struct PAYL10nKey {
    let name: String
    
    internal var keyValue: String {
        return self.name.pay_snakeCased() ?? ""
    }
}

internal extension PAYL10nKey {
    static let paymentScreenTitle = PAYL10nKey(name: "paymentScreenTitle")
    static let paymentAmount = PAYL10nKey(name: "paymentAmount")
    
    static let paymentEmailTitle = PAYL10nKey(name: "paymentEmailTitle")
    static let paymentEmailPlaceholder = PAYL10nKey(name: "paymentEmailPlaceholder")
    static let paymentCardnumberTitle = PAYL10nKey(name: "paymentCardnumberTitle")
    static let paymentCardnumberPlaceholder = PAYL10nKey(name: "paymentCardnumberPlaceholder")
    static let paymentExpiredTitle = PAYL10nKey(name: "paymentExpiredTitle")
    static let paymentExpiredPlaceholder = PAYL10nKey(name: "paymentExpiredPlaceholder")
    static let paymentCvvTitle = PAYL10nKey(name: "paymentCvvTitle")
    static let paymentCvvPlaceholder = PAYL10nKey(name: "paymentCvvPlaceholder")
    static let paymentCardholderTitle = PAYL10nKey(name: "paymentCardholderTitle")
    static let paymentCardholderPlaceholder = PAYL10nKey(name: "paymentCardholderPlaceholder")
    
    static let paymentBirthdayTitle = PAYL10nKey(name: "paymentBirthdayTitle")
    
    static let paymentBillingFirstnameTitle = PAYL10nKey(name: "paymentBillingFirstnameTitle")
    static let paymentBillingFirstnamePlaceholder = PAYL10nKey(name: "paymentBillingFirstnamePlaceholder")
    static let paymentBillingLastnameTitle = PAYL10nKey(name: "paymentBillingLastnameTitle")
    static let paymentBillingLastnamePlaceholder = PAYL10nKey(name: "paymentBillingLastnamePlaceholder")
    static let paymentBillingPhoneTitle = PAYL10nKey(name: "paymentBillingPhoneTitle")
    static let paymentBillingPhonePlaceholder = PAYL10nKey(name: "paymentBillingPhonePlaceholder")
    static let paymentBillingAddressTitle = PAYL10nKey(name: "paymentBillingAddressTitle")
    static let paymentBillingAddressPlaceholder = PAYL10nKey(name: "paymentBillingAddressPlaceholder")
    static let paymentBillingCityTitle = PAYL10nKey(name: "paymentBillingCityTitle")
    static let paymentBillingCityPlaceholder = PAYL10nKey(name: "paymentBillingCityPlaceholder")
    static let paymentBillingZipTitle = PAYL10nKey(name: "paymentBillingZipTitle")
    static let paymentBillingZipPlaceholder = PAYL10nKey(name: "paymentBillingZipPlaceholder")
    static let paymentBillingStateTitle = PAYL10nKey(name: "paymentBillingStateTitle")
    static let paymentBillingStatePlaceholder = PAYL10nKey(name: "paymentBillingStatePlaceholder")
    static let paymentBillingCountryTitle = PAYL10nKey(name: "paymentBillingCountryTitle")
    static let paymentBillingCountryPlaceholder = PAYL10nKey(name: "paymentBillingCountryPlaceholder")
    
    static let paymentPayButtonTitle = PAYL10nKey(name: "paymentPayButtonTitle")
}

/// Maxpay additional localized keys
extension PAYL10nKey {
    static let paymentAutodebitConfirmation = PAYL10nKey(name: "paymentAutodebitConfirmation")
    static let paymentTermsAndPrivacyConfirmation = PAYL10nKey(name: "paymentTermsAndPrivacyConfirmation")
    static let termsKey = PAYL10nKey(name: "termsKey")
    static let privacyKey = PAYL10nKey(name: "privacyKey")
    static let maxpayKey = PAYL10nKey(name: "maxpayKey")
}

/// Maxpay additional localized keys for alerts
extension PAYL10nKey {
    static let messageOK = PAYL10nKey(name: "paymentMessageOk")
    static let messageCancel = PAYL10nKey(name: "paymentMessageCancel")
}
