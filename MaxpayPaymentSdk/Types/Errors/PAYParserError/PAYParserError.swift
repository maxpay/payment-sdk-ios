import Foundation

/// `PAYParserError` is the error type returned by PAYFramework. It contains a few different types of errors, each with their own associated reasons.
internal enum PAYParserError: Error {
    
    case missingData
    case invalidData
}

extension PAYParserError: LocalizedError {
    
    internal var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Data missing or nil", comment: "missingData")
        case .invalidData:
            return NSLocalizedString("Invalid data", comment: "invalidData")
        }
    }
}
