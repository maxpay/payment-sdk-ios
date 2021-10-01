import Foundation

/// `PAYCardType` is interna type of PAYFramework. It represents most popular card types like Visa, MasterCard, Amex etc or Unknown for anything else.
internal enum PAYCardType: CaseIterable {
    
    case visa
    case mastercard
    case amex
    case dinersClub
    case discover
    case maestro
    case jcb
    case dankort
    case unknown
    
    internal var suggestionRegex: String {
        switch self {
        case .visa:
            return "^4\\d*$"
        case .mastercard:
            return "^((5[1-5]|677189)\\d*)|((222[1-9]|22[3-9]\\d|2[3-6]\\d{2}|27[0-1]\\d|2720)\\d*)$"
        case .amex:
            return "^3[47][0-9]*$"
        case .maestro:
            return "^(5018|5020|5038|5893|6304|670[38]|6759|676[1-3]|676770|676774)\\d*$"
        case .discover:
            return "^6(?:011|4[4-9]|5|22)\\d*$"
        case .dinersClub:
            return "^3(?:0[0-5]|[68])\\d*$"
        case .jcb:
            return "^(3(?:088|096|112|158|337|5(?:2[89]|[3-8][0-9]))\\d*)$"
        case .dankort:
            return "^(5019|4571)\\d*$"
        case .unknown:
            return ""
        }
    }
    
    internal var validationRegex: String {
        switch self {
        case .visa:
            // 13 or 16-19 digits. starts with 4
            return "^4\\d{12}(?:\\d{3,6})?$"
        case .mastercard:
            // 16 digits starts with 51-55|2221-2720
            return "^((5[1-5]\\d{4}|677189)\\d{10})|((222[1-9]|22[3-9]\\d|2[3-6]\\d{2}|27[0-1]\\d|2720)\\d{12})$"
        case .amex:
            // 15 digits starts with 34|37
            return "^3[47]\\d{13}$"
        case .maestro:
            // 16 or 19 digits, starting with 5018|5020|5038|6304|6703|6708|6759|6761-6763
            return "^(5018|5020|5038|5893|6304|670[38]|6759|676[1-3]|676770|676774)\\d{12}(?:\\d{3})?$"
        case .discover:
            // 16 or 19 digits. starts with 6011|644-649|65|622
            return "^6(?:011|4[4-9]\\d|5\\d{2}|22\\d)\\d{12}(?:\\d{3})?$"
        case .dinersClub:
            // 14 digits. Starting with 300-305|36|38
            return "^3(?:0[0-5]|[68]\\d)\\d{11}$"
        case .jcb:
            // JCB cards start with 2131 have 15 digits. Cards start with 1800 have 15 digits. Cards start with 35 have 16 digits.
            // First four digits must be 3088, 3096, 3112, 3158, 3337, or must be in the range 3528 through 3589. Valid length: 16-19 digits.
            return "^(3(?:088|096|112|158|337|5(?:2[89]|[3-8][0-9]))\\d{12,15})$"
        case .dankort:
            // 16 digits, prefix 5019 or 4517(Visa co-branded)
            return "^(5019|4571)[0-9]{12}$"
        case .unknown:
            return "([0-9]{12,19})"
        }
    }
}
