//
//  TranslatorInteractor.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 18.02.2022.
//

import Foundation
import RxSwift

protocol TranslateInteractorable {
    func translateAndSaveToStore(text: String, target: String) -> Observable<String>
}

class TranslateInteractor: TranslateInteractorable {
    
    // MARK: - Property
    
    private let serviceStorage: TranslateStoragable!
    private let serviceTranslate: Translationable!
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle

    init(storage: TranslateStoragable, serviceTranslate: Translationable) {
        self.serviceStorage = storage
        self.serviceTranslate = serviceTranslate
    }
    
    // MARK: - Internal method
    
    func translateAndSaveToStore(text: String, target: String) -> Observable<String> {
        let requestModel = TranslationRequestModel(q: text, target: target)
        
        return serviceTranslate
            .toTranslate(word: requestModel)
            .asObservable()
            .do(onNext: { self.saveToStorage(text, $0)} )
    }
    
    // MARK: - Private
    
    private func saveToStorage(_ original: String, _ translation: String) {
        serviceStorage.saveToStorage(original: original, translation: translation)
    }
    
}
