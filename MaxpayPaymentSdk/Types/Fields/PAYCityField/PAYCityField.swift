import UIKit

final internal class PAYCityField: PAYTextField {

    // MARK: - Subtypes
    
    private enum Constant {
        static let cityRegex = "^[a-zA-ZÄÖÜäöü]+(?:.| |-){2,32}$"
        static let cityPredicate = NSPredicate(format:"SELF MATCHES %@", cityRegex)
        static let letters = CharacterSet.pay_latinLetters.union(.pay_umlauts)
        static let cityMaxLength = 32
        static let cityMinLength = 2
    }
    
    // MARK: - Properties
    
    override var maxLength: Int {
        return Constant.cityMaxLength
    }
    
    // MARK: - Public
    
    override internal func commonConfigure() {
        self.keyboardType = .default
    }
    
    override internal func validate() -> Bool {
//        let string = self.text ?? ""
//        let isValid = Constant.cityPredicate.evaluate(with: string)
//
//        return isValid
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textCount = textField.text?.count ?? 0
        let character = string.first ?? " "
        
        if textCount == self.maxLength && !string.isEmpty { return false }
        
        let isValid = CharacterSet.pay_city.pay_contains(character: character)
        let isBackspace = string.isEmpty
        
        return isValid || isBackspace
    }
}
