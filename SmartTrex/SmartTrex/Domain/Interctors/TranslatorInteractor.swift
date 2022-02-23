//
//  TranslatorInteractor.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 18.02.2022.
//

import Foundation

class TranslatorInteractor {
    
    let serviceStorage: WordStoreService
    let serviceTranslate: GoogleTranslationService
    
    init(storage: WordStoreService, translate: GoogleTranslationService) {
        self.serviceStorage = storage
        self.serviceTranslate = translate
    }
    
    func translateAndSaveToStore(text: String, completion: @escaping (String) -> () ) {
        let model = TranslationRequestModel(q: text, target: .en)
        
        serviceTranslate.toTranslate(model) { response in
            
            guard
                let translate = response?.responseData?.data?.translations?.first?.translatedText
            else {
                let err = response?.errorMessage
                completion(err!)
                return
            }
            
            //            let _ = self?.serviceStorage.saveToStorage(original: text, translation: translate)
            //            let _ = self?.serviceStorage.getDataFromStorage { dataStorage in
            //                dataStorage.map { print($0.translation) }
            //            }
            
            completion(translate)
        }
        
        
    }
    
}
