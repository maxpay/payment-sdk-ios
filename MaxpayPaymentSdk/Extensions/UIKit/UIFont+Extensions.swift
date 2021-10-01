import UIKit

extension UIFont {
    
    // change weight of font to semibold or return source font
    internal func pay_semibold() -> UIFont {
        var newFont = self
        let fontSize = self.pointSize
        let familyName = self.familyName
        
        if familyName.range(of: "AppleSystemUI", options: .caseInsensitive)?.isEmpty != true {
            newFont = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        } else {
            let fontNames = UIFont.fontNames(forFamilyName: familyName)

            for fontName in fontNames {
                if fontName.range(of: "semibold", options: .caseInsensitive)?.isEmpty != true {
                    UIFont(name: fontName, size: fontSize).map { newFont = $0 }
                    
                    break
                }
            }
        }
        
        return newFont
    }
}
