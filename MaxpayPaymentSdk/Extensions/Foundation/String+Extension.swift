import UIKit
import CommonCrypto

extension String {
    
    internal var pay_encoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
    }
    
    internal var pay_int: Int? {
        return Int(self)
    }
}

extension String.Element {
    
    internal var pay_string: String {
        return String(self)
    }
}

extension String.SubSequence {
    
    internal var pay_string: String {
        return String(self)
    }
}

extension String {
    
    /// camelCaseName to camel_case_name
    internal func pay_snakeCased() -> String? {
        let pattern = "([a-z0-9])([A-Z])"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.count)
        
        let result = regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased()
        
        return result
    }
}

extension String {
    
    ///  generate string hashed with sha256
    public func pay_sha256() -> String {
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
                
        return ""
    }

    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }

    private func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)

        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }

        return hexString
    }
}

extension String {
    
    internal func pay_attributed(textColor: UIColor, font: UIFont) -> NSAttributedString {
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: textColor,
            .font: font,
        ]

        return NSAttributedString(string: self, attributes: textAttributes)
    }
}

extension String {
    
    internal func pay_removingCharacters(in set: CharacterSet) -> String {
        let filteredScalar = unicodeScalars.filter { !set.contains($0) }
        let filteredString = String(String.UnicodeScalarView(filteredScalar))
        
        return filteredString
    }
}
