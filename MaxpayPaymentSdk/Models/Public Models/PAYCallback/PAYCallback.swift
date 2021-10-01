import Foundation

/**
Object is just a wrapper around two closures. First is payment process completion handler, second calculate signature for network request.
*/
public class PAYCallback {
    
    /// Payment completion handler. Take **PAYTransactionResponse** or standard Error.
    internal let completion: (Result<PAYTransactionResponse, Error>) -> ()
    
    /// Signature calculation block. Take all needed information incapsulatied in **PAYSignatureInfo** and return signature as a String.
    internal let signagureCalculation: (PAYSignatureInfo, @escaping (String) -> ()) -> ()
    
    internal func onResponse(result: Result<PAYTransactionResponse, Error>) {
        completion(result)
    }
    
    internal func onNeedCalculateSignature(signatureInfo: PAYSignatureInfo, signatureCallback: @escaping (String) -> ()) {
        signagureCalculation(signatureInfo, signatureCallback)
    }
    
    public init(
        onResponse: @escaping (Result<PAYTransactionResponse, Error>) -> (),
        onNeedCalculateSignature: @escaping (PAYSignatureInfo, @escaping (String) -> ()) -> ())
    {
        self.completion = onResponse
        self.signagureCalculation = onNeedCalculateSignature
    }
}
