import UIKit

internal class PAYNibLoadableView: PAYBaseView {
    
    // MARK: - Init and Deinit
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureNib()
    }
    
    // MARK: - Nib loading

    /// Called from inits to load the nib and add it as a subview.
    private func configureNib() {
        let view = self.loadNib()
        
        self.backgroundColor = .clear
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let bindings = ["view": view]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:[], metrics:nil, views: bindings))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:[], metrics:nil, views: bindings))
    }
    
    /**
     Try to load view from nib with same name as view class.
     
     - returns: UIView instance loaded from a nib file.
     */
    public func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        
        let nib = UINib(nibName: nibName, bundle: bundle)
        let firstObject = nib.instantiate(withOwner: self, options: nil).first
        
        guard let view = firstObject as? UIView else {
            fatalError("Couldn't load view \(Self.Type.self) from nib")
        }
        
        return view
    }
}

