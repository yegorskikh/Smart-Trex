//
//  HistoryTranslateInteractor.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 08.03.2022.
//

import Foundation
import RxSwift

protocol HistoryTranslateInteractorable {
    var storage: TranslateStoragable! { get set }
    
    func getData(completion: @escaping ([TranslationWordPresentation]) -> ())
    func removeElement(uuid: UUID)
}

class HistoryTranslateInteractor: HistoryTranslateInteractorable {
    
    private let disposeBag = DisposeBag()
    private let mapper: TranslationWordMapperable = TranslationWordMapper()
    var storage: TranslateStoragable!
    
    
    func getData(completion: @escaping ([TranslationWordPresentation]) -> ()) {
        storage.getDataFromStorage()
            .subscribe(
                onSuccess: { [unowned self] data in
                    let models = self.mapper.toPresentationLayer(from: data)
                    completion(models)
                },
                onFailure: {
                    print($0)
                    completion([])
                }
            )
            .disposed(by: disposeBag)
    }
    
    func removeElement(uuid: UUID) {
        storage.removeFromStorage(by: uuid)
    }
    
}
