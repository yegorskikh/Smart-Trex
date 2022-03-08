//
//  TestCoreDataStack.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 30.01.2022.
//

import Foundation
import CoreData
@testable import SmartTrex

class coreDataStackMock: CoreDataStack {
    
    override init() {
        super.init()
        setupTestStoreContainer()
    }
    
    private func setupTestStoreContainer() {
        let container = NSPersistentContainer(name: CoreDataStack.modelName,
                                              managedObjectModel: CoreDataStack.model)
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        self.storeContainer = container
    }
    
}
