import UIKit

extension UIView {
    
    @IBInspectable
    internal var pay_cornerRadius: CGFloat {
        get { self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    internal var pay_borderWidth: CGFloat {
        get { self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    internal var pay_borderColor: CGColor? {
        get { self.layer.borderColor }
        set { self.layer.borderColor = newValue }
    }
}
