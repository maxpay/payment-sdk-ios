import Foundation

/// `PAYPaymentControllerError` is the error type returned by PAYFramework. It contains a few different types of errors, each with their own associated reasons.
internal enum PAYPaymentControllerError: Error {
    
    case missingConfiguration
}

extension PAYPaymentControllerError: LocalizedError {
    
    internal var errorDescription: String? {
        switch self {
        case .missingConfiguration:
            return NSLocalizedString("Configuration missing or nil", comment: "missingConfiguration")
        }
    }
}
