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
    
    // MARK: - Internal
    
    func translateAndSaveToStore(text: String, target: String) -> Observable<String> {
        Observable.create { [unowned self] observable in
                let requestModel = TranslationRequestModel(q: text, target: target)
                
                self.serviceTranslate
                    .toTranslate(word: requestModel)
                    .subscribe {
                        observable.onNext($0)
                        observable.onCompleted()
                        self.saveToStorage(text, $0)
                    } onFailure: {
                        observable.onError($0)
                        observable.onCompleted()
                    }
                    .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    // MARK: - Private
    
    private func saveToStorage(_ original: String, _ translation: String) {
        serviceStorage.saveToStorage(original: original, translation: translation)
    }
    
}
