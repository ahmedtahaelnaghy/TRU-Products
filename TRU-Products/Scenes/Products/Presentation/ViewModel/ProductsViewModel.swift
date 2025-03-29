//
//  ProductsViewModel.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import Foundation

@MainActor
final class ProductsViewModel {
    
    @Published var isLoading = false
    @Published var reloadViews = false
    @Published var showError: String?
    
    var lastPage = 1
    var currentPage = 1
    var isCollectionLoading = false
    var collectionType = CollectionViewTypes.grid
    
    private var products = [ProductsEntity]()
    private let useCase: ProductsUseCaseProtocol
    
    init(useCase: ProductsUseCaseProtocol = ProductsUseCase()) {
        self.useCase = useCase
    }
}

// MARK: - Collection Data
extension ProductsViewModel {
    var numberOfRows: Int {
        products.count
    }
    
    func cellData(at index: Int) -> ProductsEntity {
        products[index]
    }
}

// MARK: - APIs Request
extension ProductsViewModel {
    func getProducts(page: Int) async {
        isLoading = true
        let result = await useCase.getProducts()
        isLoading = false
        
        switch result {
        case .success(let data):
            products = data
            reloadViews = true
            useCase.saveProducts(products)
        case .failure(let error):
            showError = error.localizedDescription
        }
    }
}
