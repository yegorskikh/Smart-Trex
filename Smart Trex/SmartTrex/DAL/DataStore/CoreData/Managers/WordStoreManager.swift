//
//  WordStoreManager.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 30.01.2022.
//

import Foundation
import CoreData

class WordStoreManager {
    
    private var coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func saveData(word: String, translation: String) {
        let translationWord = TranslationWord(context: coreDataStack.managedContext)
        translationWord.original = word
        translationWord.translation = translation
        coreDataStack.saveContext()
    }
    
    func fetchArrayData(completion: @escaping ([TranslationWord]) -> () ) {
        let fetchRequest = NSFetchRequest<TranslationWord>(entityName: coreDataStack.modelName)
        
        do {
            let words = try coreDataStack.storeContainer.viewContext.fetch(fetchRequest)
            completion(words)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func delete(word: TranslationWord) {
        coreDataStack.managedContext.delete(word)
        coreDataStack.saveContext()
    }
    
}
