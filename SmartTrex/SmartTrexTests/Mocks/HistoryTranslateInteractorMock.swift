//
//  HistoryTranslateInteractorMock.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 09.03.2022.
//

import Foundation
@testable import SmartTrex

class HistoryTranslateInteractorMock: HistoryTranslateInteractorable {
    
    var storage: TranslateStoragable!
    var getDataWasCalled = false
    var removeElementWasCalled = false
    
    func getData(completion: @escaping ([TranslationWord]) -> ()) {
        getDataWasCalled = true
        completion([TranslationWord()])
    }
    
    func removeElement(translation: TranslationWord) {
        removeElementWasCalled = true
    }
    
}
