import UIKit

final class PAYCardNumberField: PAYTextField {
    
    // MARK: - Subtypes
    
    private enum Constant {
        static let minCardSuggestionCount = 6
        static let minCardValidationCount = 14
        static let separator: Character = " "
    }
    
    // MARK: - Properties
    
    internal var cardTypeHandler: ((PAYCardType) -> ())?
    internal override var maxLength: Int {
        return 19  //  16 digits + 3 spaces -> 1111 2222 3333 4444 555
    }

    internal override var unformattedText: String? {
        return self.text?
            .split(separator: Constant.separator)
            .joined()
    }
    
    private let cardTypeDetector = PAYCardTypeDetector()
    
    private var detectedType: PAYCardType = .unknown
    
    // MARK: - Public
    
    override internal func commonConfigure() {
        super.commonConfigure()
        
        self.keyboardType = .numberPad
    }
    
    override internal func validate() -> Bool {
        let unformatted = self.unformattedText ?? ""
        
        guard unformatted.count >= Constant.minCardValidationCount else { return false }
                
        let isValidNumber = NSPredicate(format: "SELF MATCHES %@", self.detectedType.validationRegex).evaluate(with: unformatted)
        let isValid = isValidNumber && self.luhnCheck(unformatted)
        
        return isValid
    }
    
    override internal func onEditingChanged(_ sender: PAYTextField) {
        self.updateCardType()

        if let inputText = self.text {
            let trimmed = String(inputText.trimmingCharacters(in: .whitespacesAndNewlines))
            self.text = trimmed
        }
        
        self.formatText()
        
        super.onEditingChanged(self)
    }
    
    // MARK: - Private
    
    private func luhnCheck(_ string: String) -> Bool {
        var sum = 0
        
        let reversedCharacters = string.reversed().map { String($0) }
        
        for (idx, element) in reversedCharacters.enumerated() {
            
            guard let digit = Int(element) else { return false }
            
            switch ((idx % 2 == 1), digit) {
            case (true, 9):
                sum += 9
            case (true, 0...8):
                sum += (digit * 2) % 9
            default: sum += digit
            }
        }
        
        return sum % 10 == 0
    }
    
    private func updateCardType(forced: Bool = false) {
        let textCount = self.unformattedText?.count ?? 0
        
        if textCount <= Constant.minCardSuggestionCount || forced {
            let detectedType = self.cardTypeDetector.detect(self.unformattedText)
            self.detectedType = detectedType
            self.cardTypeHandler?(detectedType)
        }
    }
    
    private func formatText() {
        let unformattedText = self.unformattedText
        
        guard let unformattedCount = unformattedText?.count, unformattedCount > 0, unformattedCount <= self.maxLength else { return }
        
        var result = ""

        //  12345678 -> 1234 5678
        unformattedText?
            .enumerated()
            .forEach { index, substring in
                
                if index > 0 && index % 4 == 0 {
                    result.append(Constant.separator)
                }
                
                result.append(substring)
            }
        
        self.text = result
    }
    
    // MARK: - UITextFieldDelegate

    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //   for copy-paste case
        if string.count > 1 {
            let currentText = self.unformattedText ?? ""
            textField.text = currentText + string.prefix(self.maxLength - currentText.count)
            formatText()
            updateCardType(forced: true)
            DispatchQueue.main.async { textField.pay_moveCoursoreToEnd() }

            return false
        }
        
        let isFilled = self.unformattedText?.count == self.maxLength
        let isDigit = trimmed.first.map { CharacterSet.decimalDigits.pay_contains(character: $0) } ?? false
        
        let isBackspace = trimmed.isEmpty
        let isNewDigitEnabled = isDigit && !isFilled
        
        return isNewDigitEnabled || isBackspace
    }
}

extension UITextField {
    
    func pay_moveCoursoreToEnd(){
        self.selectedTextRange = self.textRange(from: self.endOfDocument, to: self.endOfDocument)
    }
}
