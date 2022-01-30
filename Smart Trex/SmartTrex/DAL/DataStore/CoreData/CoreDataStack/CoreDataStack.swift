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
    
    // TODO: change the initialization of this property
    static let modelName: String = "TranslationWord"
    
    static var model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        self.storeContainer.viewContext
    }()
    
    lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: Life cycle
    
 //   init(modelName: String) { CoreDataStack.modelName = modelName }
    
    // MARK: - Internal
    
    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    public func saveContext(_ context: NSManagedObjectContext) {
      if context != mainContext {
        saveDerivedContext(context)
        return
      }

      context.perform {
        do {
          try context.save()
        } catch let error as NSError {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
    }
    
    public func saveDerivedContext(_ context: NSManagedObjectContext) {
      context.perform {
        do {
          try context.save()
        } catch let error as NSError {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }

        self.saveContext(self.mainContext)
      }
    }
    
    func newDerivedContext() -> NSManagedObjectContext {
      let context = storeContainer.newBackgroundContext()
      return context
    }
    
}
