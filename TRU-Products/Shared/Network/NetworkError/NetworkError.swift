//
//  NetworkError.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case httpError(Int)
    case networkError(URLError)
    case decodingError(DecodingError)
    case other(Error)
}

extension NetworkError {
    var errorDescription: String {
        switch self {
        case .invalidRequest:
            return "Unfortunately Server Error!, try again later"
        case .httpError(let statusCode):
            return "HTTP error with status code: \(statusCode)"
        case .networkError(let urlError):
            return "Network error: \(urlError.localizedDescription)"
        case .decodingError(let decodingError):
            return "Decoding error: \(decodingError.localizedDescription)"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
