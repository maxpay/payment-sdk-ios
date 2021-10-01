import Foundation


/// Object helps to create network requests to Pay processing center
final internal class PAYNetworkAPI {
    
    // MARK: - Properties

    /// The current mode of API, if 'isProduction' set to 'true, API will work with production environment. If 'isProduction' equal to false, all requests will be send with sandbox environment.
    internal var isProduction: Bool = false
    
    /// Current payment service main URL. This is computed property, depends on current value 'isProduction', it will return URL for live or sandbox server.
    internal var mainURL: String { self.isProduction ? "https://gateway.maxpay.com/api/cc" : "https://gateway-sandbox.maxpay.com/api/cc" }
    
    // MARK: - Public
    
    /**
     Create dictionary representation of default HTTP header.
     
        - returns: Dictionary with default HTTP header fields requred by Maxpay processing center.
     */
    internal func defaultHTTPHeader() -> [String: String] {
        let userAgent = self.userAgent()
        
        return [
            "Content-Type": "Content-Type: application/x-www-form-urlencoded",
            "Accept": "application/json",
            "User-Agent": userAgent
        ]
    }
    
    // MARK: - Private
    
    private func userAgent() -> String {
        let unknown = "Unknown"
        
        guard let info = Bundle.main.infoDictionary else { return unknown }
        
        let executable = info[kCFBundleExecutableKey as String] as? String ?? unknown
        let appVersion = info["CFBundleShortVersionString"] as? String ?? unknown
        
        var osNameVersion: String {
            let version = ProcessInfo.processInfo.operatingSystemVersion
            let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
            
            return "iOS \(versionString)"
        }
        
        return "\(executable)/\(appVersion) (\(osNameVersion))"
    }
}
