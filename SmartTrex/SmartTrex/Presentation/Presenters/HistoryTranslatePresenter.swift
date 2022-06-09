//
//  HistoryTranslatePresenter.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 09.03.2022.
//

import Foundation

protocol HistoryTranslatePresentable {
    var translatedWordsArray: [TranslationWordPresentation] { get set }
    
    func getArrayOfTranslatedWords()
    func numberOfRowsInSection() -> Int
    func removeElement(uuid: UUID)
}

class HistoryTranslatePresenter: HistoryTranslatePresentable {
    
    var interactor: HistoryTranslateInteractorable!
    
    var translatedWordsArray: [TranslationWordPresentation] = []
    
    func getArrayOfTranslatedWords() {
        interactor.getData { [weak self] data in
            self?.translatedWordsArray = data
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return translatedWordsArray.count
    }
    
    func removeElement(uuid: UUID) {
        interactor.removeElement(uuid: uuid)
        getArrayOfTranslatedWords()
    }
    
}
