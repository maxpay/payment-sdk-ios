import Foundation

/// Singleton object, create localized strings by keys, tables and language.
final internal class PAYL10nService {
    
    // MARK: - Properties
    
    internal static let shared = PAYL10nService()
    
    private lazy var bundle = PAYBundleLocator.bundle
    
    // MARK: - Init and Deinit
    
    private init() { }
    
    // MARK: - Localization
    
    internal func localized(key: PAYL10nKey, tableName: String? = nil) -> String {
        let localizedString = NSLocalizedString(key.keyValue, tableName: tableName, bundle: self.bundle, comment: "")
        
        return localizedString
    }
}
