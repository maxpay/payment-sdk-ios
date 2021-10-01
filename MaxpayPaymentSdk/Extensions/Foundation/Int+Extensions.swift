import Foundation

extension Int {
    
    internal static var pay_rand: Int {
        return Int.random(in: (Int.min...Int.max))
    }
}
