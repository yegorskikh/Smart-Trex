//
//  HistoryTranslatePresenter.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 09.03.2022.
//

import Foundation

protocol HistoryTranslatePresentable {
    var translatedWordsArray: [TranslationWord] { get set }
    
    func getArrayOfTranslatedWords()
    func numberOfRowsInSection() -> Int
    func removeElement(translation: TranslationWord)
}

class HistoryTranslatePresenter: HistoryTranslatePresentable {
    
    var interactor: HistoryTranslateInteractorable!
    
    var translatedWordsArray: [TranslationWord] = []
    
    func getArrayOfTranslatedWords() {
        interactor.getData { [weak self] data in
            self?.translatedWordsArray = data
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return translatedWordsArray.count
    }
    
    func removeElement(translation: TranslationWord) {
        interactor.removeElement(translation: translation)
        getArrayOfTranslatedWords()
    }
    
}
