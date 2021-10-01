import UIKit

final class PAYBillingView: PAYNibLoadableView {
    
    // MARK: - Properties
    
    @IBOutlet internal var firstnameContainer: UIStackView!
    @IBOutlet internal var firstnameTitleLabel: UILabel!
    @IBOutlet internal var firstnameTextFieldContainer: UIView!
    @IBOutlet internal var firstnameTextField: PAYNameField!
    
    @IBOutlet internal var lastnameContainer: UIStackView!
    @IBOutlet internal var lastnameTitleLabel: UILabel!
    @IBOutlet internal var lastnameTextFieldContainer: UIView!
    @IBOutlet internal var lastnameTextField: PAYNameField!
    
    @IBOutlet internal var phoneContainer: UIStackView!
    @IBOutlet internal var phoneTitleLabel: UILabel!
    @IBOutlet internal var phoneTextFieldContainer: UIView!
    @IBOutlet internal var phoneTextField: PAYPhoneField!
    
    @IBOutlet internal var addressContainer: UIStackView!
    @IBOutlet internal var addressTitleLabel: UILabel!
    @IBOutlet internal var addressTextFieldContainer: UIView!
    @IBOutlet internal var addressTextField: PAYAddressField!
    
    @IBOutlet internal var cityContainer: UIStackView!
    @IBOutlet internal var cityTitleLabel: UILabel!
    @IBOutlet internal var cityTextFieldContainer: UIView!
    @IBOutlet internal var cityTextField: PAYCityField!
    
    @IBOutlet internal var zipContainer: UIStackView!
    @IBOutlet internal var zipTitleLabel: UILabel!
    @IBOutlet internal var zipTextFieldContainer: UIView!
    @IBOutlet internal var zipTextField: PAYZipField!
    
    @IBOutlet internal var stateContainer: UIStackView!
    @IBOutlet internal var stateTitleLabel: UILabel!
    @IBOutlet internal var stateTextFieldContainer: UIView!
    @IBOutlet internal var stateTextField: UITextField!
    
    @IBOutlet internal var countryContainer: UIStackView!
    @IBOutlet internal var countryTitleLabel: UILabel!
    @IBOutlet internal var countryTextFieldContainer: UIView!
    @IBOutlet internal var countryTextField: PAYCountryField!
    
    internal lazy var textFields = [
        self.firstnameTextField,
        self.lastnameTextField,
        self.phoneTextField,
        self.countryTextField
    ]
    
    // MARK: - Configure UI
    
    override func configureUI() {
        super.configureUI()
        
        let l10n = self.l10nService
                
        self.firstnameTitleLabel.text = l10n.localized(key: .paymentBillingFirstnameTitle)
        self.firstnameTextField.placeholder = l10n.localized(key: .paymentBillingFirstnamePlaceholder)
        
        self.lastnameTitleLabel.text = l10n.localized(key: .paymentBillingLastnameTitle)
        self.lastnameTextField.placeholder = l10n.localized(key: .paymentBillingLastnamePlaceholder)
        
        self.phoneTitleLabel.text = l10n.localized(key: .paymentBillingPhoneTitle)
        self.phoneTextField.placeholder = l10n.localized(key: .paymentBillingPhonePlaceholder)
        
        self.addressTitleLabel.text = l10n.localized(key: .paymentBillingAddressTitle)
        self.addressTextField.placeholder = l10n.localized(key: .paymentBillingAddressPlaceholder)
        
        self.cityTitleLabel.text = l10n.localized(key: .paymentBillingCityTitle)
        self.cityTextField.placeholder = l10n.localized(key: .paymentBillingCityPlaceholder)
        
        self.zipTitleLabel.text = l10n.localized(key: .paymentBillingZipTitle)
        self.zipTextField.placeholder = l10n.localized(key: .paymentBillingZipPlaceholder)
        
        self.stateTitleLabel.text = l10n.localized(key: .paymentBillingStateTitle)
        self.stateTextField.placeholder = l10n.localized(key: .paymentBillingStatePlaceholder)
        
        self.countryTitleLabel.text = l10n.localized(key: .paymentBillingCountryTitle)
        self.countryTextField.placeholder = l10n.localized(key: .paymentBillingCountryPlaceholder)
    }
    
    override internal func updateUI() {
        super.updateUI()
        
        let theme = self.theme
                
        [self.firstnameTitleLabel, self.lastnameTitleLabel, self.phoneTitleLabel, self.addressTitleLabel, self.cityTitleLabel, self.zipTitleLabel, self.stateTitleLabel, self.countryTitleLabel].forEach {
            $0?.textColor = theme.fieldTitleColor
            $0?.font = theme.fieldTitleFont
        }
        
        [self.firstnameTextFieldContainer, self.lastnameTextFieldContainer, self.phoneTextFieldContainer, self.addressTextFieldContainer, self.cityTextFieldContainer, self.zipTextFieldContainer, self.stateTextFieldContainer, self.countryTextFieldContainer].forEach {
            $0?.backgroundColor = theme.fieldBackgroundColor
            $0?.pay_cornerRadius = theme.fieldBackgroundCornerRadius
        }
        
        [self.firstnameTextField, self.lastnameTextField, self.phoneTextField, self.addressTextField, self.cityTextField, self.zipTextField, self.stateTextField, self.countryTextField].forEach {
            $0?.textColor = theme.fieldTextColor
            $0?.font = theme.fieldTextFont
            $0?.attributedPlaceholder = $0?.placeholder?.pay_attributed(textColor: theme.fieldPlaceholderColor, font: theme.fieldTextFont)
            ($0 as? PAYTextField).map {
                $0.theme = theme
                $0.containerView = $0.superview
            }
        }
                
        self.paymentConfiguration.map {
            let billingConfig = $0.formFieldsConfiguration
            if billingConfig.showBillingAddressLayout {
                self.firstnameContainer.isHidden = !billingConfig.showNameField
                self.lastnameContainer.isHidden = !billingConfig.showNameField
                self.phoneContainer.isHidden = !billingConfig.showPhoneField
                self.addressContainer.isHidden = !billingConfig.showAddressField
                self.cityContainer.isHidden = !billingConfig.showCityField
                self.zipContainer.isHidden = !billingConfig.showZipField
                self.stateContainer.isHidden = true
                self.countryContainer.isHidden = !billingConfig.showCountryField
            }

            self.updateUI(for: $0.customer)
        }
    }
    
    private func updateUI(for customer: PAYCustomer ) {
        let address = customer.address
        let nameLength = PAYNameField().maxLength
        
        self.firstnameTextField.text = customer.firstName.prefix(nameLength).pay_string
        self.lastnameTextField.text = customer.lastName.prefix(nameLength).pay_string
        self.phoneTextField.text = customer.phone
        self.addressTextField.text = address.address
        self.cityTextField.text = address.city
        self.zipTextField.text = address.zip
        self.stateTextField.text = address.state
        self.countryTextField.text = address.country.uppercased()
        self.countryTextField.onEditingChanged(self.countryTextField)
    }
}
