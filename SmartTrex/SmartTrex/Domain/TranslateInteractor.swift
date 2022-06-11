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
    
    // TODO: - change to Rx
    func translateAndSaveToStore(text: String,
                                 target: String,
                                 completion: @escaping (_ translate: String?,
                                                        _ error: String?) -> () )
}

class TranslateInteractor: TranslateInteractorable {
    
    var serviceStorage: TranslateStoragable!
    var serviceTranslate: Translationable!
    private let disposeBag = DisposeBag()
    
    func translateAndSaveToStore(text: String,
                                 target: String,
                                 completion: @escaping (_ translate: String?,
                                                        _ error: String?) -> () ) {
        
        let model = TranslationRequestModel(q: text, target: target)
        
        serviceTranslate
            .toTranslate(word: model)
            .subscribe {
                self.saveToStorage(text, $0)
                completion($0, nil)
            } onFailure: {
                let errorAsString = $0.localizedDescription
                completion(nil, errorAsString)
            }
            .disposed(by: disposeBag)

    }
    
    private func saveToStorage(_ original: String, _ translation: String) {
        serviceStorage.saveToStorage(original: original, translation: translation)
    }
    
}
