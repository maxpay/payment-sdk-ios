import Foundation

extension Encodable {
    
    /// convert encodable object to Data and removed empty key-value pairs
    public func pay_encoded() throws -> Data {
        let dic = self.pay_dictionary?
            .filter { $1 != nil }
            .filter({ (element) -> Bool in
                if let string = element.value as? String {
                    return !string.isEmpty
                }
                
                return true                
            })
            .mapValues{ $0! }
            ?? [:]
        
        return try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
    }
    
    /// convert encodable object to JSON aka dictionary [String:  Any?]
    public var pay_dictionary: [String: Any?]? {
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(self) else { return nil }
        
        let json = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
        let dictionary = json.flatMap { $0 as? [String: Any] }
        
        return dictionary
    }
}
