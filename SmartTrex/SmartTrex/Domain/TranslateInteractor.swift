//
//  TranslatorInteractor.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 18.02.2022.
//

import Foundation
import RxSwift

protocol TranslateInteractorable {
    var serviceStorage: TranslateStoragable! { get set }
    var serviceTranslate: Translationable! { get set }
    
    func translateAndSaveToStore(text: String, target: String) -> Observable<String>
}

class TranslateInteractor: TranslateInteractorable {
    
    var serviceStorage: TranslateStoragable!
    var serviceTranslate: Translationable!
    private let disposeBag = DisposeBag()
    
    func translateAndSaveToStore(text: String, target: String) -> Observable<String> {
        Observable.create { [weak self] observable in
            
            guard let self = self else {
                return Disposables.create()
            }
            
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
    
    
    private func saveToStorage(_ original: String, _ translation: String) {
        serviceStorage.saveToStorage(original: original, translation: translation)
    }
    
}
