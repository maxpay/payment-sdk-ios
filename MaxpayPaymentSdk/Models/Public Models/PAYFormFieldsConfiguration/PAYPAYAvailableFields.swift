import Foundation

/**
Represents all options to setup Billing Address section
*/

public struct PAYAvailableFields {
    
    /// If **true**, the payment view controller will show Biling Address form.
    public let showBillingAddressLayout: Bool
    
    /// If **true**, the payment view controller will show Name field.
    public let showNameField: Bool
    
    /// If **true**, the payment view controller will show Phone field.
    public let showPhoneField: Bool
    
    /// If **true**, the payment view controller will show Address field.
    public let showAddressField: Bool
    
    /// If **true**, the payment view controller will show City field.
    public let showCityField: Bool
    
    /// If **true**, the payment view controller will show ZIP field.
    public let showZipField: Bool
    
    /// If **true**, the payment view controller will show Country form.
    public let showCountryField: Bool

    /// If **true**, the payment view controller will show Birthday field.
    public let showBirthdayField: Bool
    
    /**
     init to create configuration object
     
    - returns:
        An initialized configuration for Billing Address.
        
    - parameters:
        - isBillingAddressNeeded: information about Billing address appearance
        - isNameFieldNeeded: information about Name field appearance
        - isPhoneFieldNeeded: information about Name field appearance
        - isAddressFieldNeeded: information about Address field appearance
        - isCityFieldNeeded: information about City field appearance
        - isZIPFieldNeeded: information about ZIP field appearance
        - isCountryFieldNeeded: information about Country field appearance
        - isBirthdayFieldNeeded: information about Birthday field appearance
    */
    public init(isBillingAddressNeeded: Bool,
                isNameFieldNeeded: Bool,
                isPhoneFieldNeeded: Bool,
                isAddressFieldNeeded: Bool,
                isCityFieldNeeded: Bool,
                isZIPFieldNeeded: Bool,
                isCountryFieldNeeded: Bool,
                isBirthdayFieldNeeded: Bool)
    {
        self.showBillingAddressLayout = isBillingAddressNeeded
        self.showNameField = isNameFieldNeeded
        self.showPhoneField = isPhoneFieldNeeded
        self.showAddressField = isAddressFieldNeeded
        self.showCityField = isCityFieldNeeded
        self.showZipField = isZIPFieldNeeded
        self.showCountryField = isCountryFieldNeeded
        self.showBirthdayField = isBirthdayFieldNeeded
    }
}
