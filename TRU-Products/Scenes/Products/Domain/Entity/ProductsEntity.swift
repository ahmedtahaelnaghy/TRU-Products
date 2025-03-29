//
//  ProductsEntity.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import Foundation

struct ProductsEntity: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let description, category: String?
    let image: String?
    let rating: RatingEntity?
}

struct RatingEntity: Codable {
    let rate: Double?
    let count: Int?
}
