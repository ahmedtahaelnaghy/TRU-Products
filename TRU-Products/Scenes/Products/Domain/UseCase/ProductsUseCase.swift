//
//  ProductsUseCase.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import Foundation

protocol ProductsUseCaseProtocol: AnyObject {
    func getProducts() async -> ModelResult<[ProductsEntity]>
    func saveProducts(_ products: [ProductsEntity])
}

final class ProductsUseCase: ProductsUseCaseProtocol {
    
    private let repository: ProductsRepositoryProtocol
    private var cancellable = Cancellable()
    
    init(repository: ProductsRepositoryProtocol = ProductsRepository()) {
        self.repository = repository
    }
    
    func getProducts() async -> ModelResult<[ProductsEntity]> {
        await repository.getProducts()
            .singleOutput(with: &cancellable)
    }
    
    func saveProducts(_ products: [ProductsEntity]) {
        repository.saveProducts(products)
    }
}
