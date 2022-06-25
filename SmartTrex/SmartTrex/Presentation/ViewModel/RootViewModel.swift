//
//  RootViewModel.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 24.06.2022.
//

import UIKit
import RxSwift
import RxCocoa

class RootViewModel: ViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    private var goToVc: UIViewController!
    private var collector: CollectorModuleFactory!
    
    private enum GoTo {
        case translate
        case historyTranslate
    }
    
    let input: Input
    let output: Output
    
    struct Input {
        let onSendActionBooks: AnyObserver<Void>
        let onSendActionHistory: AnyObserver<Void>
        let onSendActionTranslate: AnyObserver<Void>
    }
    
    struct Output {
        let onShowError: Driver<String>
        let onPushViewController: Driver<UIViewController>
    }
     
    // input
    let actionBooks = PublishSubject<Void>()
    let actionHistory = PublishSubject<Void>()
    let actionTranslate = PublishSubject<Void>()
    
    // output
    let showError = PublishSubject<String>()
    let viewController = PublishSubject<UIViewController>()
    
    init() {
        input = Input(
            onSendActionBooks: actionBooks.asObserver(),
            onSendActionHistory: actionHistory.asObserver(),
            onSendActionTranslate: actionTranslate.asObserver()
        )
        output = Output(
            onShowError: showError.asDriver(onErrorJustReturn: ""),
            onPushViewController: viewController.asDriver(onErrorJustReturn: UIViewController())
        )
        initBinding()
    }
    
    private func initBinding() {
        actionBooks
            .bind { _ in
                self.showError.onNext("I'm still in development")
            }
            .disposed(by: disposeBag)
        
        actionHistory
            .bind { _ in
                let vc = self.getModule(.historyTranslate)
                self.viewController.onNext(vc)
            }
            .disposed(by: disposeBag)
        
        actionTranslate
            .bind { _ in
                let vc = self.getModule(.translate)
                self.viewController.onNext(vc)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func getModule(_ vc: GoTo) -> UIViewController {
        switch vc {
        case .translate:
            collector = TranslateCollectorFactory()
        case .historyTranslate:
            collector = HistoryTranslateCollectorFactory()
        }
        let vc = collector.getModule()
        return vc
    }
    
}
