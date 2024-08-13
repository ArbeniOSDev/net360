//
//  APIClient.swift
//  net360
//
//  Created by Arben on 13.8.24.
//

import Foundation

struct APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    func sendRequest<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: "\(APIConstants.baseUrl)\(endpoint)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // Add the authorization token to the request headers
        if let token = KeychainHelper.shared.read(key: "accessToken") {
            request.setValue("Bearer: \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Add parameters to the request body for POST, PUT, etc.
        if let parameters = parameters, method != "GET" {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }.resume()
    }
}
