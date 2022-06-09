//
//  HistoryTranslateInteractor.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 08.03.2022.
//

import Foundation

protocol HistoryTranslateInteractorable {
    var storage: TranslateStoragable! { get set }
    
    func getData(completion: @escaping ([TranslationWordPresentation]) -> ())
    func removeElement(uuid: UUID)
}

class HistoryTranslateInteractor: HistoryTranslateInteractorable {
    
    var storage: TranslateStoragable!

    func getData(completion: @escaping ([TranslationWordPresentation]) -> ()) {
        storage.getDataFromStorage { dataArray in
            completion(dataArray)
        }
    }
    
    func removeElement(uuid: UUID) {
        storage.removeFromStorage(by: uuid)
    }
    
}
