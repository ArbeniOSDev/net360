//
//  APIServiceProtocol.swift
//  net360
//
//  Created by Arben on 5.8.24.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint,
                               method: HTTPMethod,
                               parameters: [String: Any]?,
                               headers: [String: String]?) ->
    AnyPublisher<T, Error>
}

enum Endpoint {
    case detailsEvent
    case login
    
    var url: URL? {
        switch self {
        case .detailsEvent:
            let urlString = "\(APIConstants.detailsEventUrl)"
            return URL(string: urlString)
        case .login:
            let urlString = "\(APIConstants.login)"
            return URL(string: urlString)
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct APIService: APIServiceProtocol {
    
    func request<T: Decodable>(_ endpoint: Endpoint, method: HTTPMethod, parameters: [String: Any]?, headers: [String: String]?) -> AnyPublisher<T, Error> {
        
        guard let url = endpoint.url else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Set headers
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Set parameters for POST or PUT requests
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                return Fail(error: error).eraseToAnyPublisher()
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
