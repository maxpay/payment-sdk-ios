
import UIKit

final internal class PAYEmailField: PAYTextField {

    // MARK: - Subtypes
    
    private enum Constant {
//        static let emailRegEx = #"^([^\s@]{1,64})+@[^\s@]+\.[^\s@]+$"#
//        static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let emailRegEx = "^[a-zA-Z0-9ÄÖÜäöü.!#$%&'*+/=?^_`{|}~-]{1,64}+@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-ZÄÖÜäöü\\-0-9]+\\.)+[a-zA-Z]{2,}))$"

        static let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        static let emailMaxLength = 254
    }

    // MARK: - Properties
    
    override var maxLength: Int  {
        return Constant.emailMaxLength
    }

    // MARK: - Public
    
    override internal func commonConfigure() {
        self.keyboardType = .emailAddress
    }
    
    override internal func validate() -> Bool {
        let string = self.text ?? ""
        let isValid = Constant.emailPredicate.evaluate(with: string)
            && !string.isEmpty
            && !string.hasPrefix(".")
            && !string.hasSuffix(".")

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
        let textCount = textField.text?.count ?? 0
        
        let isFilled = textCount == self.maxLength
        let isBackspace = string.isEmpty
        let shouldChange = !isFilled || isBackspace
        
        return shouldChange
    }
}
