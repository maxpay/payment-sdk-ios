import UIKit

extension UIImage {
    
    internal static var pay_checkmarkImage: UIImage? {
        return extractImage(named: "white_checkmark_icon")
    }
    
    internal static var pay_visaImage: UIImage? {
        return extractImage(named: "visa_card_icon")
    }
    
    internal static var pay_mastercardImage: UIImage? {
        return extractImage(named: "mastercard_card_icon")
    }
    
    internal static var pay_maestroCardImage: UIImage? {
        return extractImage(named: "maestro_card_icon")
    }
    
    internal static var pay_discoverCardImage: UIImage? {
        return extractImage(named: "discover_card_icon")
    }
    
    internal static var pay_dinersClubCardImage: UIImage? {
        return extractImage(named: "diners_club_card_icon")
    }
    
    internal static var pay_amexCardImage: UIImage? {        
        return extractImage(named: "amex_card_icon")
    }
    
    internal static var pay_jcbCardImage: UIImage? {
        return extractImage(named: "jcb_card_icon")
    }
    
    internal static var pay_dankortCardImage: UIImage? {
        return extractImage(named: "dankort_card_icon")
    }
    
    internal static var pay_nonameCardImage: UIImage? {
        return extractImage(named: "noname_card_icon")
    }
    
    private static func extractImage(named: String) -> UIImage? {
        let image = UIImage.init(named: named, in: PAYBundleLocator.bundle, compatibleWith: nil)
        
        return image
    }
}
