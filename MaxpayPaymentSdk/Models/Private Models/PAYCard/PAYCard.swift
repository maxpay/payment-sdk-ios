import Foundation

/// Represents credit card data
internal struct PAYCard {
    /// Number of the card
    internal let cardNumber: String
    
    /// Card expiration month. Month number from '01' to '12'
    internal let cardExpMonth: String
    
    /// Card expiration year
    internal let cardExpYear: String
    
    /// Card Verification Value
    internal let cvv: String?
    
    /// Cardholder name
    internal let cardHolder: String
    
    /// Hashed value of card number, expiry date and cardholder name
    internal let token: String?
}
