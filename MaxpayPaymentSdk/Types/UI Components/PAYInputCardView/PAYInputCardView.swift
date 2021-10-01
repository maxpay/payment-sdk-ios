import UIKit

final class PAYInputCardView: PAYNibLoadableView {
    
    // MARK: - Properties
    
    @IBOutlet internal var emailTitleLabel: UILabel!
    @IBOutlet internal var emailTextFieldContainer: UIView!
    @IBOutlet internal var emailTextField: PAYEmailField!
    
    @IBOutlet internal var cardNumberTitleLabel: UILabel!
    @IBOutlet internal var cardNumberTextFieldContainer: UIView!
    @IBOutlet internal var cardNumberTextField: PAYCardNumberField!
    @IBOutlet internal var cardLogoImageView: UIImageView!
    
    @IBOutlet internal var expiredTitleLabel: UILabel!
    @IBOutlet internal var expiredTextFieldContainer: UIView!
    @IBOutlet internal var expiredTextField: PAYExpiredDateField!

    @IBOutlet internal var cvvTitleLabel: UILabel!
    @IBOutlet internal var cvvTextFieldContainer: UIView!
    @IBOutlet internal var cvvTextField: PAYCVVField!
    
    @IBOutlet internal var cardholderTitleLabel: UILabel!
    @IBOutlet internal var cardholderTextFieldContainer: UIView!
    @IBOutlet internal var cardholderTextField: PAYCardHolderField!
    
    @IBOutlet internal var birthdayContentContainer: UIStackView!
    @IBOutlet internal var birthdayTitleLabel: UILabel!
    @IBOutlet internal var birthdayTextFieldContainer: UIView!
    @IBOutlet internal var birthdayTextField: UITextField!
    @IBOutlet internal var birthdayButton: UIButton!
    @IBOutlet internal var birthdayPicker: UIDatePicker!
    
    internal lazy var textFields = [
        self.emailTextField,
        self.cardNumberTextField,
        self.expiredTextField,
        self.cvvTextField,
        self.cardholderTextField
    ]
    
    // MARK: - Configure UI
    
    override internal func configureUI() {
        super.configureUI()
        
        self.configurePicker()
        self.cardLogoImageView.image = UIImage.pay_nonameCardImage
        self.cardNumberTextField.cardTypeHandler = { [weak self] in self?.set(logo: $0) }
        self.localizeUI()
    }
    
    internal func localizeUI() {
        let l10n = self.l10nService
        
        self.emailTitleLabel.text = l10n.localized(key: .paymentEmailTitle)
        self.emailTextField.placeholder = l10n.localized(key: .paymentEmailPlaceholder)
        
        self.cardNumberTitleLabel.text = l10n.localized(key: .paymentCardnumberTitle)
        self.cardNumberTextField.placeholder = l10n.localized(key: .paymentCardnumberPlaceholder)
        
        self.expiredTitleLabel.text = l10n.localized(key: .paymentExpiredTitle)
        self.expiredTextField.placeholder = l10n.localized(key: .paymentExpiredPlaceholder)
        
        self.cvvTitleLabel.text = l10n.localized(key: .paymentCvvTitle)
        self.cvvTextField.placeholder = l10n.localized(key: .paymentCvvPlaceholder)
        
        self.cardholderTitleLabel.text = l10n.localized(key: .paymentCardholderTitle)
        self.cardholderTextField.placeholder = l10n.localized(key: .paymentCardholderPlaceholder)
        
        self.birthdayTitleLabel.text = l10n.localized(key: .paymentBirthdayTitle)
        self.birthdayTextField.placeholder = l10n.localized(key: .paymentBirthdayTitle)
    }
    
    // MARK: - Update UI
    
    //  will call after update configuration and theme
    override internal func updateUI() {
        super.updateUI()
        
        let theme = self.theme

        [self.emailTitleLabel, self.cardNumberTitleLabel, self.expiredTitleLabel, self.cvvTitleLabel, self.cardholderTitleLabel].forEach {
            $0?.textColor = theme.fieldTitleColor
            $0?.font = theme.fieldTitleFont
        }
        
        [self.emailTextFieldContainer, self.cardNumberTextFieldContainer, self.expiredTextFieldContainer, self.cvvTextFieldContainer, self.cardholderTextFieldContainer, self.birthdayTextFieldContainer].forEach {
            $0?.backgroundColor = theme.fieldBackgroundColor
            $0?.pay_cornerRadius = theme.fieldBackgroundCornerRadius
        }
        
        [self.emailTextField, self.cardNumberTextField, self.expiredTextField, self.cvvTextField, self.cardholderTextField, self.birthdayTextField].forEach {
            $0?.textColor = theme.fieldTextColor
            $0?.font = theme.fieldTextFont
            $0?.attributedPlaceholder = $0?.placeholder?.pay_attributed(textColor: theme.fieldPlaceholderColor, font: theme.fieldTextFont)
            ($0 as? PAYTextField).map {
                $0.theme = theme
                $0.containerView = $0.superview
            }
        }
        
        self.paymentConfiguration.map {
            self.emailTextField.text = $0.customer.email
            self.birthdayTextField.text = $0.customer.formattedBirthday
        }
    }
    
    internal func set(logo: PAYCardType) {
        var logoIcon: UIImage? = nil
        
        switch logo {
        case .visa:
            logoIcon = UIImage.pay_visaImage
        case .mastercard:
            logoIcon = UIImage.pay_mastercardImage
        case .amex:
            logoIcon = UIImage.pay_amexCardImage
        case .dinersClub:
            logoIcon = UIImage.pay_dinersClubCardImage
        case .discover:
            logoIcon = UIImage.pay_discoverCardImage
        case .maestro:
            logoIcon = UIImage.pay_maestroCardImage
        case .jcb:
            logoIcon = UIImage.pay_jcbCardImage
        case .dankort:
            logoIcon = UIImage.pay_dankortCardImage
        case .unknown:
            logoIcon = UIImage.pay_nonameCardImage
        }
        
        self.cardLogoImageView.image = logoIcon
    }
    
    // MARK: - Public
    
    internal func getCardInfo() -> PAYCardInfo {
        return PAYCardInfo(cardNumber: self.cardNumberTextField.unformattedText,
                           expiredMonth: self.expiredTextField.expiredMonth,
                           expiredYear: self.expiredTextField.expiredYear,
                           cvv: self.cvvTextField.text,
                           cardholderName: self.cardholderTextField.unformattedText)
    }
    
    // MARK: - Private
    
    @objc
    private func onEditBirthday(_ sender: UIButton) {
        self.showBirthdayPicker() { [weak self] date in
            if let date = date {
                self?.birthdayTextField.text = DateFormatter.pay_birthdayFormatter.string(from: date)
            }
        }
    }
    
    @objc
    private func onPickerValueChanged(_ sender: UIDatePicker) {
        self.birthdayTextField.text = DateFormatter.pay_birthdayFormatter.string(from: sender.date)
    }
    
    private func configurePicker() {
        let birthdayButton = self.birthdayButton
        let birthdayPicker = self.birthdayPicker
        
//        if #available(iOS 14.0, *) {
//            birthdayPicker?.maximumDate = Date()
//            birthdayPicker?.addTarget(self, action: #selector(onPickerValueChanged), for: .valueChanged)
//            birthdayButton?.isHidden = true
//        } else {
            birthdayPicker?.isHidden = true
            birthdayButton?.addTarget(self, action: #selector(self.onEditBirthday), for: .touchUpInside)
//        }
    }
    
    private func showBirthdayPicker(completion: @escaping (Date?) -> ()) {
        guard let rootController = UIApplication.shared.windows.first(where: { $0.isKeyWindow == true })?.rootViewController else { return }
        
        let pickerView = PAYDatePickerView()
        pickerView.frame = UIScreen.main.bounds
        pickerView.backgroundColor = UIColor.clear
        pickerView.datePicker.maximumDate = Date()
        
        let hideAction = { [weak pickerView] in
            if let pickerView = pickerView {
                rootController.view.sendSubviewToBack(pickerView)
                pickerView.removeFromSuperview()
            }
        }
        
        pickerView.cancelAction = hideAction
        pickerView.okAction = { [weak pickerView] in
            completion(pickerView?.datePicker.date)
            hideAction()
        }
        
        rootController.view.addSubview(pickerView)
        rootController.view.bringSubviewToFront(pickerView)
    }
}
