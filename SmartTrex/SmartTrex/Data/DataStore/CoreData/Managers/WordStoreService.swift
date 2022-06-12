//
//  WordStoreManager.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 30.01.2022.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa

protocol TranslateStoragable {
    @discardableResult func saveToStorage(original: String, translation: String) -> TranslationWord?
    func getDataFromStorage() -> Single<[TranslationWord]>
    func removeFromStorage(by uuid: UUID)
}

class WordStoreService: TranslateStoragable {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
    // MARK: - Internal
    
    @discardableResult
    func saveToStorage(original: String, translation: String) -> TranslationWord? {
        let translationWord = TranslationWord(context: managedObjectContext)
        translationWord.original = original
        translationWord.translation = translation
        translationWord.uuid = UUID()
        coreDataStack.saveContext(managedObjectContext)
        return translationWord
    }
    func getDataFromStorage() -> Single<[TranslationWord]> {
        return Single<[TranslationWord]>.create { [weak self] single in
            
            guard let self = self else { return Disposables.create() }
            
            do {
                let words = try self.coreDataStack.storeContainer.viewContext
                    .fetch(NSFetchRequest<TranslationWord>(entityName: CoreDataStack.modelName))
                single(.success(words))
            } catch let error as NSError {
                single(.failure(error))
            }
            
            return Disposables.create()
        }
    }
    
    func removeFromStorage(by uuid: UUID) {
        getDataFromStorage()
            .subscribe(
                onSuccess: { [weak self] data in
                    guard
                        let self = self,
                        let object = self.findBy(uuid: uuid)
                    else {
                        return
                    }
                    
                    self.coreDataStack.mainContext.delete(object)
                    self.coreDataStack.saveContext(self.managedObjectContext)
                })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    
    
    private func findBy(uuid: UUID) -> TranslationWord? {
        var object: TranslationWord? = nil
        
        getDataFromStorage()
            .subscribe(
                onSuccess: {
                    object = $0.first(where: { $0.uuid == uuid })
                }
            )
            .disposed(by: disposeBag)
        
        return object
    }
    
}
