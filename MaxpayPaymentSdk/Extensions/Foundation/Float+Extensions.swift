import Foundation

extension Float {
    
    public func pay_roundedTo(places: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Float {
        let divisor = pow(10.0, Double(places))
        let rounded = (Double(self) * divisor).rounded(rule) / divisor
        
        return Float(rounded)
    }
}
