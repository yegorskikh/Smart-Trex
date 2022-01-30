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
    
    enum ModelName: String {
        case translationWord = "TranslationWord"
    }
    
    private let modelName: String
    
    private lazy var managedContext: NSManagedObjectContext = {
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
    
    // MARK: Life cycle
    
    init(modelName: ModelName) {
        self.modelName = modelName.rawValue
    }
    
    // MARK: - Internal

    func saveData(word: String, translation: String) {
        let translationWord = TranslationWord(context: managedContext)
        translationWord.original = word
        translationWord.translation = translation
        saveContext()
    }
    
    func fetchData(completion: @escaping ([TranslationWord]) -> () ) {
        let fetchRequest = NSFetchRequest<TranslationWord>(entityName: modelName)
        
        do {
            let words = try storeContainer.viewContext.fetch(fetchRequest)
            completion(words)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func delete(word: TranslationWord) {
        managedContext.delete(word)
        saveContext()
    }
    
    // MARK: - Private
    
    private func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
}
