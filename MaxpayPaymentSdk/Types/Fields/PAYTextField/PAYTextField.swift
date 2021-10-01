import UIKit

/**
PAYTextField is a text field with same properties to UITextField, but specialized for collecting credit/debit card information.

- important:
    It denied any delegate or target objects except 'self' and contains methods to restrict and validate input string.
*/
internal class PAYTextField: UITextField, UITextFieldDelegate {
    
    // MARK: - Properties
    
    //  only 'self' can be delegate
    override var delegate: UITextFieldDelegate? {
        get { super.delegate }
        set {
            if self.delegate == nil && newValue === self {
                super.delegate = newValue
            }
        }
    }
    
    /// current color theme, see **PAYTheme**
    internal var theme = PAYTheme.default

    /// view which contain text field and should be changed on validation
    internal var containerView: UIView?
    
    /// proxy block for 'onEditingChanged' event, will be called in default 'onEditingChanged' implementation
    internal var onTextChanged: (() -> ())?
    
    /// This property call method to checks to see if field is valid and return result.
    internal var isValid: Bool {
        get {
            return self.validate()
        }
    }

    internal var maxLength: Int {
        return 0
    }
    
    internal var unformattedText: String? {
        return self.text
    }
    
    // MARK: - Init and Deinit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.privateConfigure()
        self.commonConfigure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.privateConfigure()
        self.commonConfigure()
    }
    
    // MARK: - Public
    
    open func commonConfigure() {
        
    }
    
    @discardableResult
    open func validate() -> Bool {
        fatalError("\(#function) should be overriden")
    }
    
    @objc
    internal func onEditingChanged(_ sender: PAYTextField) {
        self.onTextChanged?()
                
        if self.unformattedText?.count == self.maxLength {
            self.updateFieldAppearance()
        } else {
            self.resetFieldAppearance()
        }
    }
    
    // MARK: - Override
    
    // only 'self' can be target for PAYTextField
    override internal func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        if target as AnyObject === self {
            super.addTarget(target, action: action, for: controlEvents)
        }
    }
    
    // MARK: - Configure UI
    
    private func privateConfigure() {
        self.addTarget(self, action: #selector(self.onEditingChanged), for: .editingChanged)

        self.delegate = self
        
        self.autocorrectionType = .no
        self.textContentType = .none
        self.smartDashesType = .no
        self.smartQuotesType = .no
        self.smartInsertDeleteType = .no
        self.spellCheckingType = .no
    }
    
    // MARK: - Update UI
    
    internal func updateFieldAppearance() {
        let theme = self.theme
        let errorColor = theme.errorColor
        let isValid = self.validate()
        
        self.set(textColor: isValid ? theme.fieldTextColor : errorColor,
                 borderColor: isValid ? theme.fieldBackgroundColor : errorColor)
    }
    
    internal func resetFieldAppearance() {
        let theme = self.theme
        
        self.set(textColor: theme.fieldTextColor, borderColor: theme.fieldBackgroundColor)
    }
    
    // MARK: - UITextFieldDelegate
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        self.updateFieldAppearance()
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.updateFieldAppearance()
        
        return true
    }
    
    // MARK: - Utils
    
    private func set(textColor: UIColor, borderColor: UIColor) {
        self.textColor = textColor
        self.containerView?.pay_borderWidth = 1
        self.containerView?.pay_borderColor = borderColor.cgColor
    }
}
