import Foundation

/// Object contains all data about customer.
internal struct PAYCustomer {
    /// The first name of the customer
    internal let firstName: String
    
    /// The last name of the customer
    internal let lastName: String
    
    /// Customer's phone number. For testmode the value should be passed with + symbol
    internal let phone: String?
    
    /// Customer's email address
    internal let email: String
    
    /// Customer's IP address. Not all acquirers support IPv6 format
    internal let ip: String
    
    /// Date of birth of the customer in format YYYY-MM-DD
    internal let birthday: String?
    
    /// Customer's address
    internal let address: PAYBillingAddress
    
    /// Formatted date of birth of the customer
    internal let formattedBirthday: String
    
    internal init(firstName: String, lastName: String, phone: String?, email: String, ip: String, birthday: String?, address: PAYBillingAddress) {
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.ip = ip
        self.birthday = birthday
        self.address = address
        self.formattedBirthday = birthday ?? DateFormatter.pay_birthdayFormatter.string(from: Date())
    }
}

extension PAYCustomer {
    
    internal func replace(email: String?) -> PAYCustomer {
        guard let email = email else { return self }
        
        return PAYCustomer(firstName: self.firstName,
                           lastName: self.lastName,
                           phone: self.phone,
                           email: email,
                           ip: self.ip,
                           birthday: self.birthday,
                           address: self.address)
    }
    
    internal func replace(birthday: Date?) -> PAYCustomer {
        guard let birthdayDate = birthday else { return self }
        
        let birthday = DateFormatter.pay_birthdayFormatter.string(from: birthdayDate)
        
        return PAYCustomer(firstName: self.firstName,
                           lastName: self.lastName,
                           phone: self.phone,
                           email: self.email,
                           ip: self.ip,
                           birthday: birthday,
                           address: self.address)
    }
    
    internal func replace(address: PAYBillingAddress?) -> PAYCustomer {
        let currentAddress = self.address
        
        let newAddress = PAYBillingAddress(country: address?.country ?? currentAddress.country,
                                           state:  address?.state ?? currentAddress.state,
                                           city: address?.city ?? currentAddress.city,
                                           address: address?.address ?? currentAddress.address,
                                           zip: address?.zip ?? currentAddress.zip)
        
        return PAYCustomer(firstName: self.firstName,
                           lastName: self.lastName,
                           phone: self.phone,
                           email: self.email,
                           ip: self.ip,
                           birthday: self.birthday,
                           address: newAddress)
    }
    
    internal func replace(firstname: String?, lastname: String?) -> PAYCustomer {
        return PAYCustomer(firstName: firstname ?? self.firstName,
                           lastName: lastname ?? self.lastName,
                           phone: self.phone,
                           email: self.email,
                           ip: self.ip,
                           birthday: self.birthday,
                           address: self.address)
    }
    
    internal func replace(phone: String?) -> PAYCustomer {
        guard let phone = phone else { return self }
        
        return PAYCustomer(firstName: self.firstName,
                           lastName: self.lastName,
                           phone: phone,
                           email: self.email,
                           ip: self.ip,
                           birthday: self.birthday,
                           address: self.address)
    }
}

/// Address associated with customer card’s account
internal struct PAYBillingAddress {
    /// Customer's country
    ///  ISO 3166-1, alpha-3
    internal let country: String
    
    /// Customer's state
    internal let state: String?

    /// Customer's city
    internal let city: String?
    
    /// Customer's address
    internal let address: String?
    
    /// Customer's zip
    internal let zip: String?
    
    internal init(country: String, state: String?, city: String?, address: String?, zip: String?) {
        self.country = country
        self.state = state
        self.city = city
        self.address = address
        self.zip = zip
    }
}

extension PAYBillingAddress {
    
    func replaced(from address: PAYBillingAddress) -> PAYBillingAddress {
        return PAYBillingAddress(country: address.country.isEmpty ?  self.country : address.country,
                                 state: (address.state ?? "").isEmpty ? self.state : address.state,
                                 city: (address.city ?? "").isEmpty ? self.city : address.city,
                                 address: (address.address ?? "").isEmpty ? self.address : address.address,
                                 zip: (address.zip ?? "").isEmpty ? self.zip : address.zip)
    }
}
