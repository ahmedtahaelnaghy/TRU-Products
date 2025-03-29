//
//  ProductsRepository.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import Foundation

protocol ProductsRepositoryProtocol: AnyObject {
    func getProducts() -> ResponsePublisher<[ProductsEntity]>
    func saveProducts(_ products: [ProductsEntity])
}

final class ProductsRepository: ProductsRepositoryProtocol {
    
    private let internetConnected = InternetConnectionManager()
    private let remote: ProductsNetworkProtocol
    private let cache: ProductsCashingProtocol
    
    init(
        remote: ProductsNetworkProtocol = ProductsNetwork(),
        cache: ProductsCashingProtocol = ProductsCashing()
    ) {
        self.remote = remote
        self.cache = cache
    }
    
    func getProducts() -> ResponsePublisher<[ProductsEntity]> {
        internetConnected.isConnected ? remote.getProducts() : cache.getProducts
    }
    
    func saveProducts(_ products: [ProductsEntity]) {
        cache.saveProducts(products)
    }
}
