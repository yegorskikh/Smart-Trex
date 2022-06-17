//
//  HistoryTranslateInteractorMock.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 09.03.2022.
//

import Foundation
@testable import SmartTrex
import RxSwift

class HistoryTranslateInteractorMock: HistoryTranslateInteractorable {
    var storage: TranslateStoragable!
    var getDataWasCalled = false
    var removeElementWasCalled = false

    enum ReturnType {
        case failed
        case success
    }
    
    var responseType: ReturnType = .success
    
    func getData() -> Observable<[TranslationWordPresentation]> {
        getDataWasCalled = true
        switch responseType {
        case .success:
            return Observable<[TranslationWordPresentation]>
                .just([.init(uuid: UUID(), original: "Foo", translation: "Qux")])
        case .failed:
            return Observable<[TranslationWordPresentation]>
                .error(StorageDataError.failedData)
        }
        
    }
    
    func removeElement(uuid: UUID) {
        removeElementWasCalled = true
    }
    
}
