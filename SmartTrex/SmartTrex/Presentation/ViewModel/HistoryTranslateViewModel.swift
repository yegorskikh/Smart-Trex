//
//  HistoryTranslateViewModel.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 09.03.2022.
//

import Foundation
import RxSwift
import RxCocoa

// TODO: - !!! This must be tested
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
        let onError: Driver<String>
    }
    
    // Input
    let indexPathToDel = PublishSubject<IndexPath>()
    let sendAction = PublishSubject<Void>()
    
    // Output
    let translationWords = PublishSubject<[TranslationWordPresentation]>()
    let error = PublishSubject<String>()
    
    // MARK: - Init
    
    init(interactor: HistoryTranslateInteractorable) {
        self.interactor = interactor
        
        input = Input(
            viewControllerDidLoadView: sendAction.asObserver(),
            indexPathToDel: indexPathToDel.asObserver()
        )
        output = Output(
            onTranslationWords: translationWords.asDriver(onErrorJustReturn: []),
            onError: error.asDriver(onErrorJustReturn: "")
        )
        
        initBindings()
    }
    
    // MARK: - Bindings
    
    private func initBindings() {
        indexPathToDel
            .bind { [unowned self] indexPath in
                self.interactor.getData()
                    .subscribe(onNext: { [unowned self] data in
                        let uuid = data[indexPath.row].uuid
                        self.interactor.removeElement(uuid: uuid)
                        
                        // TODO: - !!! Deleted too quickly?
                        // Update data after deletion
                        self.sendAction.onNext(Void())
                        
                    }, onError: { [unowned self] error in
                        self.error.onNext(error.localizedDescription)
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
