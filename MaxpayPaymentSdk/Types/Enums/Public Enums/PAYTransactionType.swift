import Foundation

/// Type representing available authorization types.
public enum PAYAuthorizationType: String {
    
    case signature = "bySignature"
}

/// Type representing available transaction types.
public enum PAYTransactionType: String {
    
    case auth = "AUTH"
    case auth3d = "AUTH3D"
    case sale = "SALE"
    case sale3d = "SALE3D"
    
    /// corresponding integer value to connect currency type with UISegmentedIndicator
    public var intValue: Int {
        switch self {
        case .auth:
            return 0
        case .auth3d:
            return 1
        case .sale:
            return 2
        case .sale3d:
            return 3
        }
    }
    
    /// Boolean flag to detect transaction with 3DS
    public var is3DSecure: Bool { self == .auth3d || self == .sale3d }
    
    public init?(number: Int) {
        switch number {
        case 0:
            self = .auth
        case 1:
            self = .auth3d
        case 2:
            self = .sale
        case 3:
            self = .sale3d
        default:
            return nil
        }
    }
}
