import Foundation

extension Data {
    
    /// convenient init
    init(_ pay_auth3DConfirm: PAYAuth3DConfirm) {
        let params = "PaReq=\(pay_auth3DConfirm.pareq)&TermUrl=\(pay_auth3DConfirm.redirect)&MD=\(pay_auth3DConfirm.reference)"
        
        self.init(params.utf8)
    }
    
    /// debug purpose only
    internal var pay_prettyJSON: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyJSON = String(data: data, encoding:.utf8)
        else { return nil }

        return prettyJSON
    }
}
