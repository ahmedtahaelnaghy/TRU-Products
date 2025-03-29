//
//  NetworkManager.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func fetchData<T: Endpoint, M: Decodable>(endPoint: T) -> ResponsePublisher<M>
}

final class NetworkManager: NetworkManagerProtocol {
    private let urlSession: URLSession
    
    init(session: URLSession = .shared) {
        self.urlSession = session
    }
    
    func fetchData<T: Endpoint, M: Decodable>(endPoint: T) -> ResponsePublisher<M> {
        guard let request = buildRequest(endPoint: endPoint) else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode) else {
                    throw NetworkError.httpError((response as? HTTPURLResponse)?.statusCode ?? -1)
                }
                return data
            }
            .decode(type: M.self, decoder: JSONDecoder())
            .mapError { error in
                if let urlError = error as? URLError {
                    return NetworkError.networkError(urlError)
                } else if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                } else {
                    return NetworkError.other(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func buildRequest<T: Endpoint>(endPoint: T) -> URLRequest? {
        guard let url = URL(string: endPoint.baseURL + endPoint.path) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        
        for (key, value) in endPoint.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        switch endPoint.task {
        case .requestPlain:
            break
        case .requestParameters(let parameters, let encoding):
            switch encoding {
            case .url:
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                request.url = components?.url
            case .json:
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }
        
        return request
    }
}
