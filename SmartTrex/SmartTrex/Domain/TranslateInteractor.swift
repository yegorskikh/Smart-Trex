//
//  TranslatorInteractor.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 18.02.2022.
//

import Foundation

protocol TranslateInteractorable {
    var serviceStorage: TranslateStoragable! { get set }
    var serviceTranslate: Translationable! { get set }
    
    func translateAndSaveToStore(text: String,
                                 target: String,
                                 completion: @escaping (_ translate: String?,
                                                        _ error: String?) -> () )
}

class TranslateInteractor: TranslateInteractorable {
    
    var serviceStorage: TranslateStoragable!
    var serviceTranslate: Translationable!
    
    func translateAndSaveToStore(text: String,
                                 target: String,
                                 completion: @escaping (_ translate: String?,
                                                        _ error: String?) -> () ) {
        
        let model = TranslationRequestModel(q: text, target: target)
        
        serviceTranslate.toTranslate(model) { [weak self] response in
            
            guard
                let translate = response?.responseData?.data?.translations?.first?.translatedText
            else {
                completion(nil, response?.stringError!)
                return
            }
            
            let _ = self?.serviceStorage.saveToStorage(original: text, translation: translate)
            completion(translate, nil)
        }
        
        
    }
    
}