//
//  CoreDataStack.swift
//  Smart Trex
//
//  Created by Yegor Gorskikh on 30.01.2022.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // MARK: - Property
        
    let modelName: String
    
    lazy var managedContext: NSManagedObjectContext = {
        self.storeContainer.viewContext
    }()
    
    lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: Life cycle
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Private
    
     func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
}
