import Foundation

/**
Represents all data and options you can set for a payment

You provide an `PAYPaymentConfiguration` object to your `PAYPaymentViewController` on initialization. The configuration has settings that will not change later.
*/

internal struct PAYPaymentConfiguration {

/// Object contains merhant identifier, password, redirection callbacks e.t.c.
    internal let merchant: PAYMerchant
    
/// Object contains order number, amount, currency e.t.c.
    internal let order: PAYOrder
    
/// Object contains customer name, phone, email e.t.c.
    internal let customer: PAYCustomer

/// Object contains inormation about form fields
    internal let formFieldsConfiguration: PAYAvailableFields
    
/// Flag to switch between sandbox and production environment
    internal let isProduction: Bool
/**
 init to create configuration object
 
- returns:
    An initialized configuration object.
    
- parameters:
     - merchant: information about merchant, see **PAYMerchant**
     - customer: information about customer, see **PAYCustomer**
     - order: information about order, see **PAYOrder**
     - formFieldsConfiguration: A Boolean values indicating which input fields should be presented.
*/
    internal init(merchant: PAYMerchant,
                  customer: PAYCustomer,
                  order: PAYOrder,
                  formFieldsConfiguration: PAYAvailableFields,
                  isProduction: Bool
    ) {
        self.merchant = merchant
        self.order = order
        self.customer = customer
        self.formFieldsConfiguration = formFieldsConfiguration
        self.isProduction = isProduction
    }
    
/**
 init to create configuration object
 
- returns:
    An initialized configuration object.
    
- parameters:
     - initInfo: information about merchant, see **PAYMerchant**
     - paymentInfo: information about customer, see **PAYCustomer**
*/
    
    internal init(initInfo: PAYInitInfo, paymentInfo: PAYPaymentInfo) {
        let merchant = PAYMerchant(initInfo: initInfo, paymentInfo: paymentInfo)
        let order = PAYOrder(transactionUniqueID: paymentInfo.transactionID,
                             transactionType: paymentInfo.transactionType,
                             amount: paymentInfo.amount,
                             currency: paymentInfo.currency)
        
        let billingAddress = PAYBillingAddress(country: paymentInfo.country,
                                               state: paymentInfo.state,
                                               city: paymentInfo.city,
                                               address: paymentInfo.address,
                                               zip: paymentInfo.zip)
        let customer = PAYCustomer(firstName: paymentInfo.firstName,
                                   lastName: paymentInfo.lastName,
                                   phone: paymentInfo.userPhone,
                                   email: paymentInfo.userEmail,
                                   ip: PAYIPAddressProvider.getIPAddress(),
                                   birthday: paymentInfo.birthday,
                                   address: billingAddress)
        
        self.merchant = merchant
        self.order = order
        self.customer = customer
        self.formFieldsConfiguration = initInfo.fieldsToShow
        self.isProduction = initInfo.isProduction
    }
}
