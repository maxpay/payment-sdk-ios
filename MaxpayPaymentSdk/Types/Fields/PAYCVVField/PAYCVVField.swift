import UIKit

final internal class PAYCVVField: PAYTextField {

    // MARK: - Subtypes
    
    private enum Constant {
        static let commonCardLength = 3
        static let amexCardLength = 4
    }
    
    // MARK: - Properties
    
    override var maxLength: Int {
        return 4  //  only AmericanExpress has 4 numbers
    }
    
    // MARK: - Public
    
    override internal func commonConfigure() {
        self.keyboardType = .numberPad
        self.textContentType = .oneTimeCode
        self.isSecureTextEntry = true
    }
    
    override internal func validate() -> Bool {
        let count = self.text?.count
        let isValid = count == Constant.commonCardLength || count == Constant.amexCardLength
        
        return isValid
    }
    
    override internal func onEditingChanged(_ sender: PAYTextField) {
        if let cutted = self.text?.trimmingCharacters(in: .whitespacesAndNewlines).prefix(self.maxLength) {
            self.text = String(cutted)
        }
        
        super.onEditingChanged(self)
    }
    
    // MARK: - UITextFieldDelegate
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        let text = textField.text ?? ""
        let textCount = text.count
        
        let isFilled = textCount == self.maxLength
        let isDigit = trimmed.first.map { CharacterSet.decimalDigits.pay_contains(character: $0) } ?? false
        let isBackspace = trimmed.isEmpty
        
        let shouldChange = (isDigit && !isFilled) || isBackspace
        
        return shouldChange
    }
}
