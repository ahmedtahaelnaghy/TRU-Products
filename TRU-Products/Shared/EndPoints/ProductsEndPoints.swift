//
//  ProductsEndPoints.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import Foundation

enum ProductsEndPoints {
    case getProducts
}

extension ProductsEndPoints: Endpoint {
    var path: String {
        "products"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var task: TaskMethods {
        .requestParameters(parameters: ["limit": 7], encoding: .url)
    }
}
