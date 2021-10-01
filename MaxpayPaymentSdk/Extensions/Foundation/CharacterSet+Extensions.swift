import Foundation

extension CharacterSet {

    private static var pay_specialCharacterSet: CharacterSet {
        return CharacterSet(charactersIn: " -.")
    }
    
    internal static var pay_whitespace: CharacterSet {
        return CharacterSet(charactersIn: " ")
    }
    
    internal static var pay_dash: CharacterSet {
        return CharacterSet(charactersIn: "-")
    }
    
    internal static var pay_latinLetters: CharacterSet {
        return CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    }

    internal static var pay_city: CharacterSet {
        return pay_latinLetters
            .union(.pay_umlauts)
            .union(.pay_specialCharacterSet)
    }

    internal static var pay_address: CharacterSet {
        return pay_city
            .union(.decimalDigits)
    }

    internal static var pay_noLetters: CharacterSet {
        return CharacterSet.letters.inverted
    }
    
    internal static var pay_noDecimalDigits: CharacterSet {
        return CharacterSet.decimalDigits.inverted
    }
    
    internal static var pay_email: CharacterSet {
        let punctuationCharacters = CharacterSet(charactersIn: "!#$%&'*+-/=?^_`{|}~.@")
        let emailCharacters = punctuationCharacters.union(.alphanumerics)
        
        return emailCharacters
    }
    
    internal static var pay_umlauts: CharacterSet {
        return CharacterSet(charactersIn: "ÄÖÜäöü")
    }
    
    internal static var pay_cardHolderSymbols: CharacterSet {
        return pay_latinLetters.union(.pay_whitespace).union(.pay_umlauts)
    }
    
    internal func pay_contains(character: Character) -> Bool {
        return character.unicodeScalars.allSatisfy { self.contains($0) }
    }
}
