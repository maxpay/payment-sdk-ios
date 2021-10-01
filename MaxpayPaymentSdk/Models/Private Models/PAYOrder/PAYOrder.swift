import Foundation

/// Object contains all data about order.
internal struct PAYOrder {
    /// Unique transaction Id
    internal let transactionUniqueID: String
    
    /// Type of the transaction
    internal let transactionType: PAYTransactionType
    
    /// Amount of the transaction
    internal let amount: Float
    
    /// Amount of the transaction
    internal let amountString: String
    
    /// Currency of the transaction
    internal let currency: String
    
    internal init(transactionUniqueID: String, transactionType: PAYTransactionType, amount: Float, currency: String) {
        self.transactionUniqueID = transactionUniqueID
        self.transactionType = transactionType
        self.amount = amount
        self.amountString = String(amount.pay_roundedTo(places: 2))
        self.currency = currency
    }
}
