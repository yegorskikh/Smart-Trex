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
    
    // MARK: - Private property
    
    private let disposeBag = DisposeBag()
    private var goToVc: UIViewController!
    private var collector: CollectorModuleFactory!
    
    private enum GoTo {
        case translate
        case historyTranslate
        case book
    }
    
    // MARK: - Internal property
    
    let input: Input
    let output: Output
    
    struct Input {
        let onSendActionBooks: AnyObserver<Void>
        let onSendActionHistory: AnyObserver<Void>
        let onSendActionTranslate: AnyObserver<Void>
    }
    
    struct Output {
        let onShowError: Signal<String>
        let onPushViewController: Signal<UIViewController>
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
            onShowError: showError.asSignal(onErrorJustReturn: ""),
            onPushViewController: viewController.asSignal(onErrorRecover: { _ in .empty() })
        )
        initBinding()
    }
    
    // MARK: - Private method
    
    private func initBinding() {
        actionBooks
            .bind { _ in
                self.showError.onNext("I'm still in development")
                //                let vc = self.getModule(.book)
                //                self.viewController.onNext(vc)
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
        case .book:
            collector = BookPageCollectorFactory()
        }
        let vc = collector.getModule()
        return vc
    }
    
}
