import UIKit

final class PAYConditionsView: PAYNibLoadableView {
    
    // MARK: - Properties
    
    @IBOutlet internal var topCheckboxView: PAYCheckboxView!
    @IBOutlet internal var middleCheckboxView: PAYCheckboxView!
    @IBOutlet internal var bottomCheckboxView: PAYCheckboxView!
    
    internal lazy var checkboxes: [PAYCheckboxView] = [self.topCheckboxView, self.middleCheckboxView, self.bottomCheckboxView]
    
    private lazy var checkboxViews = [self.topCheckboxView, self.middleCheckboxView, self.bottomCheckboxView]
    private var checkboxConfigurations = [PAYCheckboxConfiguration]() {
        didSet {
            self.updateUI()
        }
    }
    
    // MARK: - Update UI
    
    override internal func updateUI() {
        super.updateUI()
        
        self.checkboxViews.forEach {
            $0?.theme = theme
            $0?.descriptionTextView.textColor = theme.conditionsTextColor
            $0?.checkmarkView.layer.cornerRadius = theme.checkboxCornerRadius
            $0?.descriptionTextView.font = theme.conditionsFont
            $0?.descriptionTextView?.linkTextAttributes = [.foregroundColor: theme.hyperlinkColor]
        }
        
        self.updateCheckboxes()
    }
    
    @discardableResult
    internal func add(_ config: PAYCheckboxConfiguration) -> PAYConditionsView {
        let checkboxViews = self.checkboxViews
        
        guard self.checkboxConfigurations.count < checkboxViews.count else { return self }
        
        self.checkboxConfigurations.append(config)
        
        return self
    }
    
    // MARK: - Private
    
    private func updateCheckboxes() {
        self.checkboxViews.forEach {
            $0?.isHidden = true
        }
        
        self.checkboxConfigurations.enumerated().forEach { index, configuration in
            if let view = self.checkboxViews.pay_object(at: index) {
                view?.isHidden = false
                view?.attributedText = self.attributedString(from: configuration)
            }
        }
    }
    
    private func attributedString(from config: PAYCheckboxConfiguration?) -> NSAttributedString? {
        guard let config = config else { return nil }
        
        let font = self.theme.conditionsFont
        let fullText = config.text
        
        // default style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineHeightMultiple = 1.12
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: theme.conditionsTextColor,
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        
        // link style
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .font: font.pay_semibold()
        ]
        
        // full attributed string with default style
        let attributedString = NSMutableAttributedString(string: fullText, attributes: textAttributes)
        
        config.highlightedTexts.map { (key: $0.key, link: $0.value)}
            .forEach {
                // key with hyperlink style and URL
                let hyperlinkAttributes = linkAttributes.pay_merged(with: [.link: $0.link as Any])
                let hyperlink = NSAttributedString(string: $0.key, attributes: hyperlinkAttributes)
            
                // find key range
                let keyRange = attributedString.mutableString.range(of: $0.key)
            
                // replace key
                if keyRange.length > 0 {
                    attributedString.replaceCharacters(in: keyRange, with: hyperlink)
                }
            }
        
        return NSAttributedString(attributedString: attributedString)
    }
    
}
