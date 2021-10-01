import Foundation

/// A client for making connections to the Pay processing center API.
final internal class PAYNetworkService {
    
    // MARK: - Properties
    
    internal let api: PAYNetworkAPI
    private let acceptableStatusCodes = 200..<300

    // MARK: - Init and Deinit
    
    private init(api: PAYNetworkAPI) {
        self.api = api
    }
    
    static let shared = PAYNetworkService(api: PAYNetworkAPI())
    
    // MARK: - Public
    /**
        Send deautl POST request with standard **PAYTransactionRequest** model in body.
     
        - parameters:
        - 
     */
    internal func send(transactionRequest: PAYTransactionRequest, completion: @escaping (Result<PAYTransactionResponse, Error>) -> ()) {
        guard let url = URL(string: self.api.mainURL) else {
            completion(.failure(PAYNetworkError.invalidURL))
            
            return
        }
        
        let request = self.createDefaultPostRequest(url: url, body: transactionRequest)
        
        self.send(request: request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                debugPrint(String(decoding: data, as: UTF8.self))
                let decoder = JSONDecoder()

                if let json = try? decoder.decode(PAYTransactionResponse.self, from: data) {
                    completion(.success(json))
                } else {
                    completion(.failure(PAYParserError.invalidData))
                }
            }
        }
    }
    
    internal func loadHTML(request: URLRequest, completion: @escaping (Result<String, Error>) -> ()) {
        self.send(request: request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let htmlString = String(data: data, encoding: .utf8) {
                    completion(.success(htmlString))
                } else {
                    completion(.failure(PAYParserError.invalidData))
                }
            }
        }
    }
    
    // MARK: - Private
    
    private func createDefaultPostRequest<Body: Encodable>(url: URL, body: Body) -> URLRequest {
        let json = try? body.pay_encoded()
    
        var request = URLRequest(url: url)
        request.httpMethod = PAYHTTPMethodType.post.rawValue
        request.httpBody = json
        
        self.api.defaultHTTPHeader().forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    private func send(request: URLRequest, completion: @escaping (Result<Data, Error>) -> ()) {
        let acceptableStatusCodes = self.acceptableStatusCodes
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                
                if let statusCode = statusCode, !acceptableStatusCodes.contains(statusCode) {
                    completion(.failure(PAYNetworkError.invalidStatusCode(statusCode)))
                    
                    return
                }
                
                if let error = error {
                    completion(.failure(error))
                    
                    return
                }

                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(PAYParserError.missingData))
                }
            }
        
            task.resume()
    }
}
