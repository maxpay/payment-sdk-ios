import Foundation

/**
Object is just a wrapper around two closures. First is payment process completion handler, second calculate signature for network request.
 
# Signature calculation
On mobile application you must:
 1) Send **dataForSignature** from **onNeedCalculateSignature** to backend
 2) Receive calculated signature
 3) Invoke **signatureCallback** and pass signature as the argument
 
 On your backend you must:
 1) Add a private key for this data using "|" as a separator
 2) Convert into the lowercase
 3) Take sha256 hash
 4) Return the resulting value to the mobile application

 - Important:
 Don't use a private key on mobile application
 
*/
public class PAYCallback {
    
    /// Payment completion handler. Take **PAYTransactionResponse** or standard Error.
    internal let completion: (Result<PAYTransactionResponse, Error>) -> ()
    
    /// Signature calculation block.
    internal let signagureCalculation: (String, @escaping (String) -> ()) -> ()
    
    internal func onResponse(result: Result<PAYTransactionResponse, Error>) {
        completion(result)
    }
    
    internal func onNeedCalculateSignature(signatureInfo: String, signatureCallback: @escaping (String) -> ()) {
        signagureCalculation(signatureInfo, signatureCallback)
    }
    
    /**
        - Parameters:
            - onResponse: Payment completion handler. Take **PAYTransactionResponse** or standard Error.
            - onNeedCalculateSignature: Signature calculation block
            - dataForSignature: Transaction data for signature
            - signatureCallback: Closure for return the signature to SDK
            - signature: The calculated signature
     */
    public init(
        onResponse: @escaping (Result<PAYTransactionResponse, Error>) -> (),
        onNeedCalculateSignature: @escaping (_ dataForSignature: String, _ signatureCallback: @escaping (_ signature: String) -> ()) -> ())
    {
        self.completion = onResponse
        self.signagureCalculation = onNeedCalculateSignature
    }
}
