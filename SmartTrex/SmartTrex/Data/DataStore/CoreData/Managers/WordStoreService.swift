//
//  WordStoreManager.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 30.01.2022.
//

import Foundation
import CoreData

protocol TranslateStoragable {
    func saveToStorage(original: String, translation: String) -> TranslationWord?
    func getDataFromStorage(completion: @escaping ([TranslationWord]) -> ())
    func removeFromStorage(translation: TranslationWord)
}

class WordStoreService: TranslateStoragable {
    
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    // MARK: - Lifecycle
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
    // MARK: - Internal
    
    func saveToStorage(original: String, translation: String) -> TranslationWord? {
        let translationWord = TranslationWord(context: managedObjectContext)
        translationWord.original = original
        translationWord.translation = translation
        translationWord.uuid = UUID()
        coreDataStack.saveContext(managedObjectContext)
        return translationWord
    }
    
    func getDataFromStorage(completion: @escaping ([TranslationWord]) -> ()) {
        let fetchRequest = NSFetchRequest<TranslationWord>(entityName: CoreDataStack.modelName)
        
        do {
            let words = try coreDataStack.storeContainer.viewContext.fetch(fetchRequest)
            completion(words)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    // DEL
    func removeFromStorage(translation: TranslationWord) {
        coreDataStack.mainContext.delete(translation)
        coreDataStack.saveContext(managedObjectContext)
    }
    
    func removeFromStorage(by uuid: UUID) {
        getDataFromStorage { [weak self] objects  in
            guard
                let self = self,
                let object = self.findBy(uuid: uuid)
            else {
                return
            }
            
            self.coreDataStack.mainContext.delete(object)
            self.coreDataStack.saveContext(self.managedObjectContext)
        }
    }
    
    // MARK: - Private
    
    private func findBy(uuid: UUID) -> TranslationWord? {
        var object: TranslationWord? = nil
        
        getDataFromStorage { objects in
            object = objects.first(where: { $0.uuid == uuid })
        }
        
        return object
    }
    
}
