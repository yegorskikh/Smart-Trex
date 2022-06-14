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
        let viewControllerDidLoadView: AnyObserver<Void>
        let indexPathToDel: AnyObserver<IndexPath>
    }
    
    struct Output {
        let onTranslationWords: Driver<[TranslationWordPresentation]>
    }
    
    // Input
    let indexPathToDel = PublishSubject<IndexPath>()
    let sendAction = PublishSubject<Void>()
    
    // Output
    let translationWords = PublishSubject<[TranslationWordPresentation]>()
    
    // MARK: - Init
    
    init(interactor: HistoryTranslateInteractorable) {
        input = Input(
            viewControllerDidLoadView: sendAction.asObserver(),
            indexPathToDel: indexPathToDel.asObserver()
        )
        output = Output(
            onTranslationWords: translationWords.asDriver(onErrorJustReturn: [])
        )
        
        self.interactor = interactor
        
        initBindings()
    }
    
    // MARK: - Bindings
    
    private func initBindings() {
        indexPathToDel
            .bind { [unowned self] indexPath in
                self.interactor.getData()
                    .subscribe(onNext: { data in
                        let uuid = data[indexPath.row].uuid
                        self.interactor.removeElement(uuid: uuid)
                    }, onError: {_ in
                        print("Упс")
                    })
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        sendAction
            .bind { [unowned self] in
                self.interactor.getData()
                    .subscribe(
                        onNext: { [unowned self] data in
                            self.translationWords.onNext(data)
                        }
                    )
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
    }
    
}
