import Foundation

/**
Checkbox configuration contains text, strings that should be highlighted with URL links.
 
For example:
 PAYCheckboxConfiguration(
     text: l10n.localized(key: .paymentTermsAndPrivacyConfirmation),
     highlightedTexts: [
         l10n.localized(key: .brandKey): brandLink,
         l10n.localized(key: .termsKey): termsLink,
         l10n.localized(key: .privacyKey): privacyLink,
     ]
 )
 */

internal struct PAYCheckboxConfiguration {
    let text: String
    let highlightedTexts: [String: String]
    
    init(text: String, highlightedTexts: [String: String] = [:]) {
        self.text = text
        self.highlightedTexts = highlightedTexts
    }
}

/// Maxpay checkboxes
extension PAYCheckboxConfiguration {
    
    private static let l10n = PAYL10nService.shared
    private static let privacyLink = "https://maxpay.com/privacy/"
    private static let termsLink = "https://maxpay.com/terms/"
    private static let maxpayLink = "https://maxpay.com/contact.html"
    
    static let autoDebitConfirmation = PAYCheckboxConfiguration(text: l10n.localized(key: .paymentAutodebitConfirmation))
    
    static let termsAndPrivacy = PAYCheckboxConfiguration(text: l10n.localized(key: .paymentTermsAndPrivacyConfirmation),
                                                          highlightedTexts: [
                                                            l10n.localized(key: .maxpayKey): maxpayLink,
                                                            l10n.localized(key: .termsKey): termsLink,
                                                            l10n.localized(key: .privacyKey): privacyLink,
                                                          ])
}
