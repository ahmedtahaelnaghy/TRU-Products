//
//  CoreDataManager.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import CoreData

final class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let bundle = Bundle(for: type(of: self))
        let modelURL = bundle.url(forResource: "CoreDataModel", withExtension: "momd")
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL!)
        let container = NSPersistentContainer(name: "CoreDataModel", managedObjectModel: managedObjectModel!)
        
        container.loadPersistentStores { [weak self] storeDescription, error in
            guard let self else { return }
            if let error {
                print(error.localizedDescription)
            }
        }
        return container
    }()
}
