import UIKit

final internal class PAYPhoneField: PAYTextField {

    // MARK: - Subtypes
    
    private enum Constant {
        static let phoneRegex = "^[+]+?\\d{\(Constant.phoneMinLength),\(Constant.phoneMaxLength)}$"
        static let phonePredicate = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
        static let onlyDigitsRegex = "^[0-9]{0,}$"
        static let onlyDigitsPredicate = NSPredicate(format:"SELF MATCHES %@", onlyDigitsRegex)
        
        static let phoneMaxLength = 14  //  without plus
        static let phoneMinLength = 6
        static let plus = "+"
    }
    
    // MARK: - Properties
    
    override var maxLength: Int {
        return Constant.phoneMaxLength
    }
    
    // MARK: - Public
    
    override internal func commonConfigure() {
        self.keyboardType = .phonePad
    }
    
    override internal func validate() -> Bool {
        let string = self.text ?? ""
        let isValid = Constant.phonePredicate.evaluate(with: string)

        return isValid
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //  copy-paste
        if string.count > 1 {
            let hasPlusPrefix = string.hasPrefix(Constant.plus)//(string.first?.pay_string ?? " ") == Constant.plus

            var formatted = string
            
            if hasPlusPrefix {
                formatted.removeFirst()
            }
            
            let isValid = Constant.onlyDigitsPredicate.evaluate(with: formatted)

            if isValid {
                formatted = Constant.plus + formatted
                textField.text = formatted.prefix(Constant.phoneMaxLength + 1).pay_string
                DispatchQueue.main.async { textField.pay_moveCoursoreToEnd() }
            }
            
            return false
        }
        
        let textCount = textField.text?.count ?? 0
        let character = string.first ?? " "
        
        let isDigit = CharacterSet.decimalDigits.pay_contains(character: character)
        let isPlus = string == Constant.plus
        let isBackspace = string.isEmpty
        
        //  only 15 symbols (14 digits + plus)
        //  plus can be only first
        if textCount == (self.maxLength + 1) && !string.isEmpty { return false }
        if isPlus && textCount > 0 { return false }

        //  append plus if needed
        if textCount == 0 {
            if isDigit {
                textField.text = Constant.plus
            }
        }
        
        return isDigit || isPlus || isBackspace
    }
}
