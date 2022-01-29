//
//  CoreDataStack.swift
//  Smart Trex
//
//  Created by Yegor Gorskikh on 30.01.2022.
//

import Foundation
import CoreData

class CoreDataStack {
  
  private let modelName: String
  
  lazy var managedContext: NSManagedObjectContext = {
    self.storeContainer.viewContext
  }()
    private lazy var storeContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: self.modelName)
      container.loadPersistentStores { (storeDescription, error) in
        if let error = error as NSError? {
          print("Unresolved error \(error), \(error.userInfo)")
        }
      }
      return container
    }()
    
  init(modelName: String) {
    self.modelName = modelName
  }
  
  func saveContext() {
    guard managedContext.hasChanges else { return }
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Unresolved error \(error), \(error.userInfo)")
    }
  }
  
}
