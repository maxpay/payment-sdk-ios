import Foundation

/**
 The credentials on file(COF) is used to identify authorization requests that use stored credentials for a consumer, in order to improve authorization rates and reduce fraud. 'CIT-initial' - First transactions initiated by customer on your service (e.g. trial product, first subscription, one-time purchase etc.) 'CIT-subsequent' - Subsequent transactions initiated by customer (e.g. one-clicks, cross-sales). 'MIT' - Transactions initiated by merchant (e. g. rebill).
 */

public enum PAYCOFType: String {
    
    case CITInitial = "CIT-initial"
    case CITSubsequent = "CIT-subsequent"
    case MIT = "MIT"
}
