import UIKit

public struct PAYTheme {
    public let backgroundColor: UIColor
    public let errorColor: UIColor
    public let hyperlinkColor: UIColor  //  font size same as main text, weight semibold

    public let headerTitleColor: UIColor
    public let headerAmountColor: UIColor
    public let headerSeparatorColor: UIColor
    
    public let headerStandardTitleFont: UIFont
    public let headerLargeTitleFont: UIFont
    public let headerAmountFont: UIFont
    
    public let fieldBackgroundColor: UIColor
    public let fieldTitleColor: UIColor
    public let fieldTextColor: UIColor
    public let fieldPlaceholderColor: UIColor
    
    public let fieldTitleFont: UIFont
    public let fieldTextFont: UIFont
    
    public let fieldBackgroundCornerRadius: CGFloat
    
    //  checkbox selected color = enabledButtonBackgroundColor
    //  checkbox deselected color = fieldBackgroundColor
    //  checkbox border color = headerSeparatorColor
    public let checkmarkColor: UIColor
    public let conditionsTextColor: UIColor
    
    public let checkboxCornerRadius: CGFloat
    
    public let conditionsFont: UIFont

    public let enabledButtonBackgroundColor: UIColor
    public let enabledButtonTitleColor: UIColor
    public let disabledButtonBackgroundColor: UIColor
    public let disabledButtonTitleColor: UIColor
    
    public let buttonTitleFont: UIFont
    
    public let buttonCornerRadius: CGFloat
    
    public init(backgroundColor: UIColor,
                errorColor: UIColor,
                hyperlinkColor: UIColor,
                headerTitleColor: UIColor,
                headerAmountColor: UIColor,
                headerSeparatorColor: UIColor,
                headerStandardTitleFont: UIFont,
                headerLargeTitleFont: UIFont,
                headerAmountFont: UIFont,
                fieldBackgroundColor: UIColor,
                fieldTitleColor: UIColor,
                fieldTextColor: UIColor,
                fieldPlaceholderColor: UIColor,
                fieldTitleFont: UIFont,
                fieldTextFont: UIFont,
                fieldBackgroundCornerRadius: CGFloat,
                checkmarkColor: UIColor,
                conditionsTextColor: UIColor,
                checkboxCornerRadius: CGFloat,
                conditionsFont: UIFont,
                enabledButtonBackgroundColor: UIColor,
                enabledButtonTitleColor: UIColor,
                disabledButtonBackgroundColor: UIColor,
                disabledButtonTitleColor: UIColor,
                buttonTitleFont: UIFont,
                buttonCornerRadius: CGFloat)
    {
        self.backgroundColor = backgroundColor
        self.errorColor = errorColor
        self.hyperlinkColor = hyperlinkColor
        
        self.headerTitleColor = headerTitleColor
        self.headerAmountColor = headerAmountColor
        self.headerSeparatorColor = headerSeparatorColor
        self.headerStandardTitleFont = headerStandardTitleFont
        self.headerLargeTitleFont = headerLargeTitleFont
        self.headerAmountFont = headerAmountFont
        
        self.fieldBackgroundColor = fieldBackgroundColor
        self.fieldTitleColor = fieldTitleColor
        self.fieldTextColor = fieldTextColor
        self.fieldPlaceholderColor = fieldPlaceholderColor
        self.fieldTitleFont = fieldTitleFont
        self.fieldTextFont = fieldTextFont
        self.fieldBackgroundCornerRadius = fieldBackgroundCornerRadius
        
        self.checkmarkColor = checkmarkColor
        self.conditionsTextColor = conditionsTextColor
        self.checkboxCornerRadius = checkboxCornerRadius
        self.conditionsFont = conditionsFont
        
        self.enabledButtonBackgroundColor = enabledButtonBackgroundColor
        self.enabledButtonTitleColor = enabledButtonTitleColor
        self.disabledButtonBackgroundColor = disabledButtonBackgroundColor
        self.disabledButtonTitleColor = disabledButtonTitleColor
        self.buttonTitleFont = buttonTitleFont
        self.buttonCornerRadius = buttonCornerRadius
    }
}

extension PAYTheme {
    
    public static var `default`: PAYTheme {
        let darkGreen = UIColor(red: 0.427, green: 0.69, blue: 0.149, alpha: 1)
        
        return PAYTheme(backgroundColor: .white,
                        errorColor: UIColor(red: 1, green: 0.392, blue: 0.486, alpha: 1),
                        hyperlinkColor: darkGreen,
                        headerTitleColor: .black,
                        headerAmountColor: darkGreen,
                        headerSeparatorColor: UIColor(red: 0.894, green: 0.894, blue: 0.894, alpha: 1),
                        headerStandardTitleFont: .systemFont(ofSize: 15, weight: .medium),
                        headerLargeTitleFont: .systemFont(ofSize: 20, weight: .semibold),
                        headerAmountFont: .systemFont(ofSize: 22, weight: .bold),
                        fieldBackgroundColor: UIColor(red: 0.975, green: 0.975, blue: 0.985, alpha: 1),
                        fieldTitleColor: .black,
                        fieldTextColor: .black,
                        fieldPlaceholderColor: UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1),
                        fieldTitleFont: .systemFont(ofSize: 13, weight: .semibold),
                        fieldTextFont: .systemFont(ofSize: 15, weight: .light),
                        fieldBackgroundCornerRadius: 12,
                        checkmarkColor: .white,
                        conditionsTextColor: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1),
                        checkboxCornerRadius: 6,
                        conditionsFont: .systemFont(ofSize: 12, weight: .regular),
                        enabledButtonBackgroundColor: darkGreen,
                        enabledButtonTitleColor: .white,
                        disabledButtonBackgroundColor: UIColor(red: 0.894, green: 0.894, blue: 0.894, alpha: 1),
                        disabledButtonTitleColor: UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1),
                        buttonTitleFont: .systemFont(ofSize: 17, weight: .regular),
                        buttonCornerRadius: 14)
    }
}
