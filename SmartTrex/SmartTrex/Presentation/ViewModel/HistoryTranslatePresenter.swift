//
//  HistoryTranslatePresenter.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 09.03.2022.
//

import Foundation
import RxSwift

protocol HistoryTranslatePresentable {
    var translatedWordsArray: [TranslationWordPresentation] { get set }
    
    func getArrayOfTranslatedWords()
    func numberOfRowsInSection() -> Int
    func removeElement(uuid: UUID)
}

class HistoryTranslatePresenter: HistoryTranslatePresentable {
    
    var interactor: HistoryTranslateInteractorable!
    var translatedWordsArray: [TranslationWordPresentation] = []
    let disposeBag = DisposeBag()
    
    func getArrayOfTranslatedWords() {
        interactor
            .getData()
            .subscribe(
                onNext: { [weak self] data in
                    self?.translatedWordsArray = data
                },
                onError: {
                    print($0.localizedDescription)
                },
                onCompleted: {
                    print("onCompleted")
                },
                onDisposed: {
                    print("onDisposed")
                })
            .disposed(by: disposeBag)
    }
    
    func numberOfRowsInSection() -> Int {
        return translatedWordsArray.count
    }
    
    func removeElement(uuid: UUID) {
        interactor.removeElement(uuid: uuid)
        getArrayOfTranslatedWords()
    }
    
}
