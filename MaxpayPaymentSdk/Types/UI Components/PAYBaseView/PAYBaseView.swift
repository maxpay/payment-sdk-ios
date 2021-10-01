import UIKit

internal class PAYBaseView: UIView {
    
    // MARK: - Properties
    
    internal var paymentConfiguration: PAYPaymentConfiguration?
    internal var theme = PAYTheme.default 
    internal var l10nService = PAYL10nService.shared

    // MARK: - Init and Deinit
    
    override internal init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override internal func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureUI()
        self.updateUI()
    }
    
    // MARK: - Common Init
    
    open func commonInit() {
        
    }
    
    // MARK: - Configure UI
    
    open func configureUI() {
        //  setup localized titles
    }
    
    open func updateUI() {
        //setup fonts, colors and dynamic texts
    }
    
    internal func set(paymentConfiguration: PAYPaymentConfiguration?, theme: PAYTheme) {
        self.paymentConfiguration = paymentConfiguration
        self.theme = theme
        
        self.updateUI()
    }
}
