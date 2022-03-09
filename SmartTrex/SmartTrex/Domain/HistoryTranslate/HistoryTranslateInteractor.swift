//
//  HistoryTranslateInteractor.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 08.03.2022.
//

import Foundation

class HistoryTranslateInteractor: HistoryTranslateInteractorable {
    
    var storage: TranslateStoragable!
    
    func getData(completion: @escaping ([TranslationWord]) -> ()) {
        storage.getDataFromStorage { [ weak self] dataArray in
            completion(dataArray)
        }
    }
    
    func removeElement(translation: TranslationWord) {
        storage.removeFromStorage(translation: translation)
    }
    
}
