//
//  ProductsNetwork.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import Foundation

protocol ProductsNetworkProtocol: AnyObject {
    func getProducts() -> ResponsePublisher<[ProductsEntity]>
}

final class ProductsNetwork: ProductsNetworkProtocol {
    
    private let network: NetworkManagerProtocol
    
    init(network: NetworkManagerProtocol = NetworkManager()) {
        self.network = network
    }
    
    func getProducts() -> ResponsePublisher<[ProductsEntity]> {
        network.fetchData(endPoint: ProductsEndPoints.getProducts)
    }
}
