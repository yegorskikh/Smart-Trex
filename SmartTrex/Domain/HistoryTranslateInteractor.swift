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
    func remove(_ element: TranslationWordPresentation)
}

class HistoryTranslateInteractor: HistoryTranslateInteractorable {
    // MARK: - Property
    private let disposeBag = DisposeBag()
    private let mapper: TranslationWordMapperable
    private let storage: TranslateStoragable
    
    // MARK: - Init
    init(storage: TranslateStoragable, mapper: TranslationWordMapperable){
        self.storage = storage
        self.mapper = mapper
    }
    
    // MARK: - Internal method
    func getData() -> Observable<[TranslationWordPresentation]> {
        return storage
            .getDataFromStorage()
            .asObservable()
            .map { self.mapper.toPresentationLayer(from: $0) }
    }
    
    func remove(_ element: TranslationWordPresentation) {
        let uuid = element.uuid
        storage.removeFromStorage(by: uuid)
    }
    
}

