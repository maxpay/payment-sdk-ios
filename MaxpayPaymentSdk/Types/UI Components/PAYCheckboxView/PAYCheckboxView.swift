import UIKit

final internal class PAYCheckboxView: PAYNibLoadableView {
    
    // MARK: - Subtypes
    
    internal enum State: Int {
        case deselected
        case selected
        case highlighted
    }
    
    // MARK: - Properties
    
    @IBOutlet internal var descriptionTextView: PAYCustomTextView!
    @IBOutlet internal var checkmarkView: UIView!
    @IBOutlet internal var checkmarkImageView: UIImageView!
    
    @IBInspectable
    internal var isLinkDetectionAvailable: Bool = false
    
    internal var onValueChanged: (() -> ()) = { }
    internal var state = State.deselected {
        didSet {
            self.updateCheckmark()
            self.onValueChanged()
        }
    }
    
    internal var text: String? {
        didSet {
            self.descriptionTextView.text = self.text
        }
    }
    
    internal var attributedText: NSAttributedString? {
        didSet {
            self.descriptionTextView.attributedText = self.attributedText
        }
    }
    
    // MARK: - Configure UI
    
    override internal func configureUI() {
        super.configureUI()
        
        let image = UIImage.pay_checkmarkImage?.withRenderingMode(.alwaysTemplate)
        self.checkmarkImageView.image = image
        self.configureTextField()
    }
    
    internal func configureTextField() {
        let isLinksAvailable = self.isLinkDetectionAvailable
        let textView = self.descriptionTextView
        
        textView?.dataDetectorTypes = isLinksAvailable ? .link : UIDataDetectorTypes()
        textView?.isSelectable = isLinksAvailable
        textView?.isUserInteractionEnabled = isLinksAvailable
    }
    
    // MARK: - Setup appearing from current state
    
    override internal func updateUI() {
        super.updateUI()
        
        self.updateCheckmark()
    }
    
    private func updateCheckmark() {
        self.checkmarkImageView.tintColor = theme.checkmarkColor

        switch self.state {
        case .selected:
            self.setup(color: theme.enabledButtonBackgroundColor, borderColor: theme.enabledButtonBackgroundColor, isIconHidden: false)
        case .deselected:
            self.setup(color: theme.fieldBackgroundColor, borderColor: theme.headerSeparatorColor, isIconHidden: true)
        case .highlighted:
            self.setup(color: theme.fieldBackgroundColor, borderColor: theme.errorColor, isIconHidden: true)
        }
    }
    
    private func setup(color: UIColor, borderColor: UIColor, isIconHidden: Bool) {
        self.checkmarkView.backgroundColor = color
        self.checkmarkView.layer.borderColor = borderColor.cgColor
        self.checkmarkImageView.isHidden = isIconHidden
    }
    
    // MARK: - Actions
    
    @IBAction func onCheckbox(_ sender: UIButton) {
        switch self.state {
        case .deselected, .highlighted:
            self.state = .selected
        case .selected:
            self.state = .deselected
        }
    }
}

// MARK: - UITextViewDelegate

extension PAYCheckboxView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        textView.becomeFirstResponder()
        
        return false
    }
}
