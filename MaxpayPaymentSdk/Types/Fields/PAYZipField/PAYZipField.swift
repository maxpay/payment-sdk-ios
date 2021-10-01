import UIKit

final internal class PAYZipField: PAYTextField {

    // MARK: - Subtypes
    
    private enum Constant {
        static let zipRegex = "(?i)^[a-z0-9][a-z0-9\\- ]{0,10}[a-z0-9]$"
        static let zipPredicate = NSPredicate(format:"SELF MATCHES %@", zipRegex)
        static let zipMaxLength = 12
        static let zipMinLength = 4
        static let latinLettersAndDecimalDigits = CharacterSet.pay_latinLetters
            .union(.pay_umlauts)
            .union(.decimalDigits)
        static let dash = "-"
    }
    
    // MARK: - Properties
    
    override var maxLength: Int {
        return Constant.zipMaxLength
    }
    
    // MARK: - Public
    
    override internal func commonConfigure() {
        self.keyboardType = .numbersAndPunctuation
    }
    
    override internal func validate() -> Bool {
//        let string = self.text ?? ""
//        let isValid = Constant.zipPredicate.evaluate(with: string)
//
//        return isValid
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textCount = textField.text?.count ?? 0
        let character = string.first ?? " "
        var isValid = false
        
        if textCount == self.maxLength && !string.isEmpty { return false }
        
        let isLetterOrDigit = Constant.latinLettersAndDecimalDigits.pay_contains(character: character)
        let isDash = string == Constant.dash
        let currentText = textField.text ?? ""

        //  first symbol only letter or digit
        //  and only one dash in string
        if textCount == 0 {
            isValid = isLetterOrDigit
        } else {
            isValid = isLetterOrDigit || (isDash && !currentText.contains(Constant.dash))
        }

        let isBackspace = string.isEmpty
        
        return isValid || isBackspace
    }
}
