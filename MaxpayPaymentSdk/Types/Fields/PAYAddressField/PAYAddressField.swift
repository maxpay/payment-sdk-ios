import UIKit

final internal class PAYAddressField: PAYTextField {

    // MARK: - Subtypes
    
    private enum Constant {
        static let addressRegex = "^[a-zA-Z0-9ÄÖÜäöü]+(?:.| |-){2,32}$"
        static let addressPredicate = NSPredicate(format:"SELF MATCHES %@", addressRegex)
        static let lettersAndSymbols = CharacterSet.pay_address
        static let addressMaxLength = 32
        static let addressMinLength = 2
    }
    
    // MARK: - Properties
    
    override var maxLength: Int {
        return Constant.addressMaxLength
    }
    
    // MARK: - Public
    
    override internal func commonConfigure() {
        self.keyboardType = .default
    }
    
    override internal func validate() -> Bool {
//        let string = self.text ?? ""
//        let isValid = Constant.addressPredicate.evaluate(with: string)
//
//        return isValid
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textCount = textField.text?.count ?? 0
        let character = string.first ?? " "
        
        if textCount == self.maxLength && !string.isEmpty { return false }
        
        let isValid = CharacterSet.pay_address.pay_contains(character: character)
        let isBackspace = string.isEmpty
        
        return isValid || isBackspace
    }
}
