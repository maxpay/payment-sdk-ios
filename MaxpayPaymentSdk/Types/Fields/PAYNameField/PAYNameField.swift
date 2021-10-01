import UIKit

final internal class PAYNameField: PAYTextField {

    // MARK: - Subtypes
    
    private enum Constant {
        static let nameLength = 32
    }
    
    // MARK: - Properties
    
    override var maxLength: Int {
        return Constant.nameLength
    }
    
    // MARK: - Public
    
    override internal func commonConfigure() {
        self.keyboardType = .default
    }
    
    override internal func validate() -> Bool {
        let count = self.text?.count ?? 0
        let isValid = count > 0 && count <= self.maxLength

        return isValid
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textCount = textField.text?.count ?? 0
        
        //   for copy-paste case
        if string.count > 1 {
            let currentText = self.unformattedText ?? ""
            let isInRange = (textCount + string.count) <= self.maxLength
            let isAppropriateString = string.first.map { CharacterSet.pay_latinLetters.pay_contains(character: $0) } ?? false
            
            if isInRange && isAppropriateString {
                textField.text = currentText + string.prefix(self.maxLength - currentText.count)
                DispatchQueue.main.async { textField.pay_moveCoursoreToEnd() }
            }
            return false
        }
        
        let isFilled = textField.text?.count ?? 0 == self.maxLength
        let isAppropriateString = string.first.map { CharacterSet.pay_latinLetters.pay_contains(character: $0) } ?? false
        let isBackspace = string.isEmpty

        return (isAppropriateString && !isFilled) || isBackspace
    }
}
