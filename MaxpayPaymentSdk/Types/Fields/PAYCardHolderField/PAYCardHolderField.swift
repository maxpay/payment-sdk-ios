import UIKit

final class PAYCardHolderField: PAYTextField {
    
    // MARK: - Subtypes
    
    private enum Constant {
        
        static let minLength = 4  // 2 for first name, 2 for last name
        static let separator: Character = " "
    }
    
    // MARK: - Properties
    
    override var maxLength: Int {
        return 48  //  24 for first name, 24 for last name and space
    }
    
    // MARK: - Public
    
    override internal func commonConfigure() {
        super.commonConfigure()
        
        self.keyboardType = .default
        self.autocapitalizationType = .allCharacters
    }
    
    override internal func validate() -> Bool {
        let text = self.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let textCount = text.count
        
        return textCount > Constant.minLength
            && textCount <= self.maxLength
            && text.contains(Constant.separator)
    }
    
    internal override var unformattedText: String? {
        return self.text?.trimmingCharacters(in: .whitespaces).split(separator: Constant.separator).joined(separator: String(Constant.separator))
    }
    
    override func onEditingChanged(_ sender: PAYTextField) {
        if let inputText = self.text {
            var newString = ""
            
            inputText.forEach {
                if CharacterSet.pay_cardHolderSymbols.pay_contains(character: $0) {
                    newString.append($0)
                }
            }
            
            self.text = newString
        }
        
        super.onEditingChanged(self)
    }
    
    // MARK: - UITextFieldDelegate

    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isFilled = textField.text?.count ?? 0 == self.maxLength
        let isAppropriateString = string.first.map { CharacterSet.pay_cardHolderSymbols.pay_contains(character: $0) } ?? false
        let isBackspace = string.isEmpty

        return (isAppropriateString && !isFilled) || isBackspace
    }
}

