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
        indexPathToDelete
            .bind { [weak self] indexPath in
                guard let self = self else { return }
                self.interactor.getData()
                    .subscribe(onNext: { [weak self] data in
                        let uuid = data[indexPath.row].uuid
                        self?.interactor.removeElement(uuid: uuid)
                        // Update data after deletion
                        self?.startDownload.onNext(Void())
                        
                    })
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        startDownload
            .bind { [weak self] in
                guard let self = self else { return }
                self.interactor.getData()
                    .subscribe(
                        onNext: { [weak self] data in
                            self?.translationWords.onNext(data)
                        },
                        onError: { [weak self] error in
                            self?.error.onNext(error.localizedDescription)
                        }
                    )
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
    }
    
}
