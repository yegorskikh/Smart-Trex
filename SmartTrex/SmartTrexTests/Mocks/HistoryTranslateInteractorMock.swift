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

    func getData() -> Observable<[TranslationWordPresentation]> {
        getDataWasCalled = true
        return Observable<[TranslationWordPresentation]>.just([])
    }
    
    func removeElement(uuid: UUID) {
        removeElementWasCalled = true
    }
    
}
