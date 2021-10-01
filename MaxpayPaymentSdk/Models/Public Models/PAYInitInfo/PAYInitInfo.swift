import Foundation

/**
Represents some information to setup **PAYPaymentViewController** and network requests
*/

public struct PAYInitInfo {
    
    /// API version
    public let apiVersion: Int
    
    /// Merchant public key
    public let publicKey: String
    
    /// Theme to configure visual appearance, see **MXPTheme**.
    public let theme: PAYTheme
    
    /// Object contains inormation about form fields
    public let fieldsToShow: PAYAvailableFields
    
    /// Flag to switch between production or sandbox URLs
    public let isProduction: Bool
    
    /**
     init to create initialized object
     
    - returns:
        An initialized **PAYInitInfo** for **PAYPaymentViewController** initialization.
        
    - parameters:
        - apiVersion: API version
        - publicKey: merchant public key
        - theme: theme to configure visual appearance
        - fieldsToShow: object contains inormation about form fields
        - isProduction: flag to switch between production or sandbox URLs
    */
    public init(
        apiVersion: Int,
        publicKey: String,
        theme: PAYTheme,
        fieldsToShow: PAYAvailableFields,
        isProduction: Bool
    ) {
        self.apiVersion = apiVersion
        self.publicKey = publicKey
        self.theme = theme
        self.fieldsToShow = fieldsToShow
        self.isProduction = isProduction
    }
}
