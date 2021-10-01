import Foundation

/// Type representing HTTP methods. Raw `String` value is stored and compared case-sensitively, so `HTTPMethod.get != HTTPMethod(rawValue: "get")`.
internal enum PAYHTTPMethodType: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
