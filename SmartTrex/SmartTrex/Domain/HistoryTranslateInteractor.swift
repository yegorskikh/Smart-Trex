//
//  HistoryTranslateInteractor.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 08.03.2022.
//

import Foundation

protocol HistoryTranslateInteractorable {
    var storage: TranslateStoragable! { get set }
    
    func getData(completion: @escaping ([TranslationWord]) -> ())
    func removeElement(translation: TranslationWord)
}

class HistoryTranslateInteractor: HistoryTranslateInteractorable {
    
    var storage: TranslateStoragable!

    func getData(completion: @escaping ([TranslationWord]) -> ()) {
        storage.getDataFromStorage { dataArray in
            completion(dataArray)
        }
    }
    
    func removeElement(translation: TranslationWord) {
        storage.removeFromStorage(translation: translation)
    }
    
}
