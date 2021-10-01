import Foundation

/// Object represent user input for card fields (number, expired dates e.t.c.)
internal struct PAYCardInfo {
    internal let cardNumber: String?
    internal let expiredMonth: String?
    internal let expiredYear: String?
    internal let cvv: String?
    internal let cardholderName: String?
}

extension PAYCardInfo {
    
    internal var paymentCard: PAYCard? {
        guard
            let cardNumber = self.cardNumber,
            let expiredMonth = self.expiredMonth,
            let expiredYear = self.expiredYear,
            let cvv = self.cvv,
            let cardHolder = self.cardholderName
        else { return nil }

        let paymentCard = PAYCard(cardNumber: cardNumber,
                                           cardExpMonth: expiredMonth,
                                           cardExpYear: "20" + expiredYear,
                                           cvv: cvv,
                                           cardHolder: cardHolder,
                                           token: nil)

        return paymentCard
    }
}
