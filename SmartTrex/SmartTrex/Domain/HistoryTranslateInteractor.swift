//
//  HistoryTranslateInteractor.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 08.03.2022.
//

import Foundation
import RxSwift

protocol HistoryTranslateInteractorable {
    func getData() -> Observable<[TranslationWordPresentation]>
    func removeElement(uuid: UUID)
}

class HistoryTranslateInteractor: HistoryTranslateInteractorable {
    // MARK: - Property
    private let disposeBag = DisposeBag()
    private let mapper: TranslationWordMapperable
    private let storage: TranslateStoragable
    
    // MARK: - Int
    init(storage: TranslateStoragable, mapper: TranslationWordMapperable){
        self.storage = storage
        self.mapper = mapper
    }
    
    // MARK: - Internal method
    
    func getData() -> Observable<[TranslationWordPresentation]> {
        Observable<[TranslationWordPresentation]>.create { [weak self] observable in

            guard let self = self else { return Disposables.create() }
            
            self.storage.getDataFromStorage()
                .subscribe(
                    onSuccess: { [unowned self] data in
                        let models = self.mapper.toPresentationLayer(from: data)
                        observable.onNext(models)
                        observable.onCompleted()
                    },
                    onFailure: {
                        observable.onError($0)
                    }
                )
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }

    }
    
    func removeElement(uuid: UUID) {
        storage.removeFromStorage(by: uuid)
    }
    
}

