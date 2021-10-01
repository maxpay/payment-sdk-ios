import UIKit

final class PAYDatePickerView: PAYNibLoadableView {

    // MARK: - Properties
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var okButton: UIButton!
    
    private let l10n = PAYL10nService.shared

    internal var cancelAction: (() -> ())?
    internal var okAction: (() -> ())?
    
    // MARK: - Init and Deinit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
        self.updateUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureUI()
        self.updateUI()
    }
    
    // MARK: - Configure UI
    
    internal override func configureUI() {
        super.configureUI()
        
        cancelButton.setTitle(l10n.localized(key: .messageCancel), for: .normal)
        okButton.setTitle(l10n.localized(key: .messageOK), for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction func onCancel(_ sender: UIButton) {
        self.cancelAction?()
    }
    
    @IBAction func onOK(_ sender: UIButton) {
        self.okAction?()
    }
}
