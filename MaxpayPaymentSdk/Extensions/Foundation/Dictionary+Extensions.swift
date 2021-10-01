import Foundation

extension Dictionary {
    
    internal func pay_merged(with dict: [Key: Value]) -> Dictionary {
        var newDictionary = self
        
        for (key, value) in dict {
            newDictionary[key] = value
        }
        
        return newDictionary
    }
}
