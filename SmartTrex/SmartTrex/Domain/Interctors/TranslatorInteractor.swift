//
//  TranslatorInteractor.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 18.02.2022.
//

import Foundation

class TranslatorInteractor: TranslatorInteractorable {
    
    var serviceStorage: WordStoragable
    var serviceTranslate: Translationable
    
    init(storage: WordStoragable, translate: Translationable) {
        self.serviceStorage = storage
        self.serviceTranslate = translate
    }
    
    func translateAndSaveToStore(text: String, completion: @escaping (String) -> () ) {
        let model = TranslationRequestModel(q: text, target: .en)
        
        serviceTranslate.toTranslate(model) { [weak self] response in
            
            guard
                let translate = response?.responseData?.data?.translations?.first?.translatedText
            else {
                let err = response?.errorMessage
                completion(err!)
                return
            }
            
            let _ = self?.serviceStorage.saveToStorage(original: text, translation: translate)
            completion(translate)
        }
        
        
    }
    
}
