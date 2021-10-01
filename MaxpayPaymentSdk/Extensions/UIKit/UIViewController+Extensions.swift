import UIKit

extension UIViewController {
    
    // hide keyboard on tap
    
    internal func pay_addHideKeyboardTap() {
        let dissmissTap = UITapGestureRecognizer(target: self, action: #selector(self.onHideKeyboardTap(sender:)))
            dissmissTap.cancelsTouchesInView = true
        self.view.addGestureRecognizer(dissmissTap)
    }
    
    @objc
    private func onHideKeyboardTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
