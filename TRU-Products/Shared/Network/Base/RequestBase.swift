//
//  RequestBase.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import Foundation

enum ParameterEncoding {
    case url
    case json
}

enum TaskMethods {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var task: TaskMethods { get }
}

extension Endpoint {
    var baseURL: String {
        Constants.baseURL
    }
    
    var headers: [String: String] {
        [:]
    }
}
