//
//  TranslationPresenter.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 28.02.2022.
//

import RxSwift
import RxCocoa

class TranslateViewModel: ViewModelProtocol {
    
    // MARK: - Private property
    
    private let interactor: TranslateInteractorable
    private let disposeBag = DisposeBag()
    
    // MARK: - Input / Output
    
    let input: Input
    let output: Output
    
    struct Input {
        let onToTranslate: AnyObserver<String>
        let onTarget: AnyObserver<String>
        let onSendAction: AnyObserver<Void>
    }
    
    struct Output {
        let onTranslate: Driver<String>
        let onError: Driver<String>
    }
    
    // Input
    let textToTranslate = BehaviorSubject(value: "")
    let targetToTranslate = BehaviorSubject(value: "")
    let sendAction = PublishSubject<Void>()
    
    // Output
    let translate = PublishSubject<String>()
    let error = PublishSubject<String>()
    
    // MARK: - Init
    
    init(interactor: TranslateInteractorable) {
        self.interactor = interactor
        
        input = Input(
            onToTranslate: textToTranslate.asObserver(),
            onTarget: targetToTranslate.asObserver(),
            onSendAction: sendAction.asObserver()
        )
        
        output = Output(
            onTranslate: translate.asDriver(onErrorJustReturn: ""),
            onError: error.asDriver(onErrorJustReturn: "")
        )
        
        initBindings()
    }
    
    // MARK: - Bindings
    
    private func initBindings() {
        sendAction
            .withLatestFrom(
                Observable.combineLatest(textToTranslate, targetToTranslate)
            )
            .bind { text, target in
                
                self.interactor.translateAndSaveToStore(
                        text: text,
                        target: target
                    )
                    .asDriver(onErrorRecover: { error in
                        let err = error as! NetworkingErrorMessage
                        self.error.onNext(err.errorDescription)
                        return .empty()
                    })
                    .drive(
                        onNext: { translate in
                            self.translate.onNext(translate)
                        }
                    )
                    .disposed(by: self.disposeBag)
                
            }
            .disposed(by: disposeBag)
    }
    
}
