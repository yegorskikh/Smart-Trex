//
//  TranslatorInteractor.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 18.02.2022.
//

import Foundation

class TranslateInteractor: TranslateInteractorable {
    
    var serviceStorage: TranslateStoragable!
    var serviceTranslate: Translationable!
        
    func translateAndSaveToStore(text: String, target: TargerLanguage, completion: @escaping (_ translate: String?,
                                                                      _ error: String?) -> () ) {
        let model = TranslationRequestModel(q: text, target: target.rawValue)
        
        serviceTranslate.toTranslate(model) { [weak self] response in
            
            guard
                let translate = response?.responseData?.data?.translations?.first?.translatedText
            else {
                completion(nil, response?.errorMessage!)
                return
            }
            
            let _ = self?.serviceStorage.saveToStorage(original: text, translation: translate)
            completion(translate, nil)
        }
        
        
    }
    
}
