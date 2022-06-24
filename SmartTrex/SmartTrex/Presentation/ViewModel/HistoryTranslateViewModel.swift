//
//  HistoryTranslateViewModel.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 09.03.2022.
//

import Foundation
import RxSwift
import RxCocoa

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
    let indexPathToDelete = PublishSubject<IndexPath>()
    let startDownload = PublishSubject<Void>()
    
    // Output
    let translationWords = PublishSubject<[TranslationWordPresentation]>()
    let error = PublishSubject<String>()
    
    // MARK: - Init
    
    init(interactor: HistoryTranslateInteractorable) {
        self.interactor = interactor
        
        input = Input(
            viewControllerDidLoadView: startDownload.asObserver(),
            indexPathToDel: indexPathToDelete.asObserver()
        )
        
        output = Output(
            onTranslationWords: translationWords.asDriver(onErrorJustReturn: []),
            onError: error.asDriver(onErrorJustReturn: "")
        )
        
        initBindings()
    }
    
    // MARK: - Bindings
    
    private func initBindings() {
        // input
        indexPathToDelete
            .bind { indexPath in
                self.interactor.getData()
                    .subscribe(onNext: { data in
                        let element = data[indexPath.row]
                        self.interactor.remove(element)
                        self.startDownload.onNext(Void())
                        
                    })
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        // output
        startDownload
            .bind { _ in
                self.interactor.getData()
                    .subscribe(
                        onNext: { data in
                            self.translationWords.onNext(data)
                        },
                        onError: { error in 
                            self.error.onNext(error.localizedDescription)
                        }
                    )
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
    }
    
}
