import Foundation

final fileprivate class PAYMarker {
    
}

final internal class PAYBundleLocator {
    /**
     Places to check:
     1. Maxpay.bundle (for manual static installations and framework-less Cocoapods)
     2. Maxpay.framework/Maxpay.bundle (for framework-based Cocoapods)
     3. Maxpay.framework (for Carthage, manual dynamic installations)
     4. main bundle (for people dragging all our files into their project)
     **/
    internal static var bundle: Bundle = {
        var bundle: Bundle? = nil
        
        bundle = Bundle(path: "Maxpay.bundle")
        
        if bundle == nil {
            // This might be the same as the previous check if not using a dynamic framework
            let path = Bundle.init(for: PAYMarker.self).path(forResource: "Maxpay", ofType: "bundle") ?? ""
            bundle = Bundle(path: path)
        }
        
        if bundle == nil {
            // This will be the same as mainBundle if not using a dynamic framework
            bundle = Bundle.init(for: PAYMarker.self)
        }
        
        return bundle ?? Bundle.main
    }()
    
    // MARK: - Private Init
    
    private init() { }
}
