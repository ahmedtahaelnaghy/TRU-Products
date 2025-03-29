//
//  ProductsCashing.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import Foundation
import Combine
import CoreData

protocol ProductsCashingProtocol: AnyObject {
    var getProducts: ResponsePublisher<[ProductsEntity]> { get }
    
    func saveProducts(_ product: [ProductsEntity])
}

final class ProductsCashing: ProductsCashingProtocol {
    
    private let managedObjectContext: NSManagedObjectContext
    private var productsModel: LocalProductsEntity!
    
    init(managedObjectContext: NSManagedObjectContext = CoreDataManager().persistentContainer.viewContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    var getProducts: ResponsePublisher<[ProductsEntity]> {
        Future { [weak self] promise in
            guard let self else { return }
            let products = getProductsFromDataBase.compactMap { self.decodeProducts($0.product) }.last ?? []
            products.isEmpty ? promise(.failure(.somethingWentWrong)) : promise(.success(products))
        }
        .eraseToAnyPublisher()
    }
    
    func saveProducts(_ product: [ProductsEntity]) {
        productsModel = LocalProductsEntity(context: managedObjectContext)
        productsModel.product = changeEntityToData(product)
        saveInDataBase()
    }
}

private extension ProductsCashing {
    var getProductsFromDataBase: [LocalProductsEntity] {
        do {
            return try managedObjectContext.fetch(LocalProductsEntity.fetchRequest())
        } catch {
            return []
        }
    }
    
    func saveInDataBase() {
        do {
            try managedObjectContext.save()
        } catch {
            debugPrint("Can't save data in the DataBase")
        }
    }
    
    func decodeProducts(_ product: Data?) -> [ProductsEntity] {
        guard let product else { return [] }
        do {
            return try JSONDecoder().decode([ProductsEntity].self, from: product)
        } catch {
            return []
        }
    }
    
    func changeEntityToData(_ product: [ProductsEntity]) -> Data? {
        do {
            return try JSONEncoder().encode(product)
        } catch {
            return nil
        }
    }
}
