import Foundation

/// `PAYNetworkError` is the error type returned by PAYFramework. It contains a few different types of errors, each with their own associated reasons.
internal enum PAYNetworkError: Error {

    case invalidURLRequest
    case invalidURL
    case invalidStatusCode(Int)
}

extension PAYNetworkError: LocalizedError {
    
    internal var errorDescription: String? {
        switch self {
        case .invalidURLRequest:
            return NSLocalizedString("Invalid URL request", comment: "invalidURLRequest")
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "invalidURL")
        case .invalidStatusCode(let code):
            return NSLocalizedString("Network error. Code \(code)", comment: "invalidStatusCode")
        }
    }
}
