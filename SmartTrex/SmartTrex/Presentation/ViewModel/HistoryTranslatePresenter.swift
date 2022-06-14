//
//  HistoryTranslatePresenter.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 09.03.2022.
//

import Foundation
import RxSwift
import RxCocoa

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

class HistoryTranslateViewModel: ViewModelProtocol {
    
    // MARK: - Private property
    
    private let interactor: HistoryTranslateInteractorable
    private let disposeBag = DisposeBag()
    
    // MARK: - Input / Output
    
    let input: Input
    let output: Output
    
    struct Input {
        let onUuidToDel: AnyObserver<String>
    }
    
    struct Output {
        let onTranslationWords: Driver<[TranslationWordPresentation]>
    }
    
    // Input
    let uuidAsStringToDel = BehaviorSubject(value: "")
    
    // Output
    let translationWords = PublishSubject<[TranslationWordPresentation]>()
   
    // MARK: - Init
    
    init(interactor: HistoryTranslateInteractorable) {
        input = Input(
            onUuidToDel: uuidAsStringToDel.asObserver()
        )
        output = Output(
            onTranslationWords: translationWords.asDriver(onErrorJustReturn: [])
        )
        
        self.interactor = interactor
    }
    
    // MARK: - Bindings
    
    private func initBindings() {
        uuidAsStringToDel
            .bind { [weak self] uuidAsString in
                guard
                    let uuid = UUID(uuidString: uuidAsString)
                else {
                    // TODO: - верни ошибку
                    return
                }
                self?.interactor.removeElement(uuid: uuid)
                // TODO: - сообщи что удалено
            }
            .disposed(by: disposeBag)
    }
    
}
