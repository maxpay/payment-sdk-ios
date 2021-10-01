import Foundation

/// Object helps in detection of credit card types like Visa, MasterCard or another.
internal struct PAYCardTypeDetector {
    
    // MARK: - Public
    
    /**
     Detect card type.
     
        - parameters:
            - cardNumber: string with card number (full or part).
     
        - returns: detected card type, see **PAYCardType**
     */
    internal func detect(_ cardNumber: String?) -> PAYCardType {
        guard let cardNumber = cardNumber else { return .unknown }
        
        let unformatted = self.unformatted(string: cardNumber)
        let result = PAYCardType
            .allCases
            .last { NSPredicate(format: "SELF MATCHES %@", $0.suggestionRegex).evaluate(with: unformatted) }
            ?? .unknown
        
        return result
    }
    
    // MARK: - Private
    
    private func unformatted(string: String) -> String {
        return string
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .filter { CharacterSet.decimalDigits.pay_contains(character: $0) }
    }
}
