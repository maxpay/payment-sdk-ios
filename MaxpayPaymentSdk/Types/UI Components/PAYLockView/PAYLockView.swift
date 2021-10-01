import UIKit

/// View with activity indicataor, lock screen till some async operation finished.

final class PAYLockView: UIView {
    
    // MARK: - Subtypes
    
    private enum Constant {
        static let backgroundColor = UIColor.black.withAlphaComponent(0.2)
        static let indicatorColor = UIColor.darkGray
    }
    
    // MARK: - Properties
    
    public private(set) var activityIndicator: UIActivityIndicatorView?
    
    // MARK: - Init and Deinit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.configureUI()
    }
    
    // MARK: - Public
    
    public func show() {
        guard let superview = self.superview else { return }
        
        self.activityIndicator?.startAnimating()
        superview.bringSubviewToFront(self)
    }
    
    public func hide() {
        guard let superview = self.superview else { return }
        
        self.activityIndicator?.stopAnimating()
        superview.sendSubviewToBack(self)
    }
    
    // MARK: - Private
    
    private func configureUI() {
        self.backgroundColor = Constant.backgroundColor
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = Constant.indicatorColor
        
        self.addSubview(activityIndicator)
        self.activityIndicator = activityIndicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
