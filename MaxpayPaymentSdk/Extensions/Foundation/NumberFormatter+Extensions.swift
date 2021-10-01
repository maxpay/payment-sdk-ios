import Foundation


extension NumberFormatter {
    
    internal func pay_string(_ float: Float) -> String? {
        return self.string(from: NSNumber.init(value: float))
    }
}
