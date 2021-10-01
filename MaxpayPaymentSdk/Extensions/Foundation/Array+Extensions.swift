import Foundation

extension Array {
    
    internal func pay_object(at index: Int) -> Element? {
        return index < self.count && index >= 0 ? self[index] : nil
    }
}
