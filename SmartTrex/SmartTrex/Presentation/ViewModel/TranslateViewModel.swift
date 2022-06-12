//
//  TranslationPresenter.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 28.02.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}

class TranslateViewModel: ViewModelProtocol {
    
    var interactor: TranslateInteractorable!
    let disposeBag = DisposeBag()
    
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
    
    init() {
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
    
    private func initBindings() {
        sendAction
            .withLatestFrom(
                Observable.combineLatest(textToTranslate, targetToTranslate)
            )
            .bind { [weak self] text, target in
                guard let self = self else { return }
                
                self.interactor
                    // FIXME: - Как передавать таргет? Нужен дизайн?
                    .translateAndSaveToStore(text: text, target: "en")//target)
                    .asDriver(onErrorRecover: { err in
                        self.error.onNext(err.localizedDescription)
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
