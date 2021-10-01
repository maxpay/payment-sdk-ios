import UIKit

/**
 UITextView in 'Label' mode. Disabled insets, scrolling. Enabled trancating words

 Use it when you need top alignment for text (UILabel has only center alignment). Also you can detect links, phones, emails e.t.c.
*/
class PAYCustomTextView: UITextView {

    // MARK: - Init and Deinit

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        self.configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.configure()
    }
    
    // MARK: - Configure UI

    private func configure() {
        self.isSelectable = false
        self.isEditable = false
        self.isUserInteractionEnabled = false
        
        self.isScrollEnabled = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        
        self.textContainerInset = UIEdgeInsets.zero
        self.textContainer.lineFragmentPadding = 0
        self.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    // MARK: - Disable Interaction, Enable Links Detection
    
    /// this method will be helpfull when we should selt 'isSelectable' as **true**, for data detction,
    /// but still don't want enable any user manipulation with content
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let pos = self.closestPosition(to: point) else { return false }
        guard let range = self.tokenizer.rangeEnclosingPosition(pos, with: .character, inDirection: .layout(.left)) else { return false }

        let startIndex = offset(from: beginningOfDocument, to: range.start)

        return attributedText.attribute(.link, at: startIndex, effectiveRange: nil) != nil
    }
}

