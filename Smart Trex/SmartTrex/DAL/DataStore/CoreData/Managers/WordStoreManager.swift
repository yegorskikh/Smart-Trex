//
//  WordStoreManager.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 30.01.2022.
//

import Foundation
import CoreData

class WordStoreManager {
    
    static let modelName: String = "TranslationWord"
    
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
      self.managedObjectContext = managedObjectContext
      self.coreDataStack = coreDataStack
    }
    
    func saveToStorage(original: String, translation: String) -> TranslationWord? {
        let translationWord = TranslationWord(context: managedObjectContext)
        translationWord.original = original
        translationWord.translation = translation
        coreDataStack.saveContext(managedObjectContext)
        return translationWord
    }
    
    func getDataFromStorage(completion: @escaping ([TranslationWord]) -> ()) {
        let fetchRequest = NSFetchRequest<TranslationWord>(entityName: WordStoreManager.modelName)
        
        do {
            let words = try coreDataStack.storeContainer.viewContext.fetch(fetchRequest)
            completion(words)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func removeFromStorage(_ word: TranslationWord) {
        coreDataStack.mainContext.delete(word)
        coreDataStack.saveContext(managedObjectContext)
    }
    
}
