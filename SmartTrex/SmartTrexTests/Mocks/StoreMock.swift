//
//  StoreMock.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 27.02.2022.
//

import Foundation
@testable import SmartTrex

class StoreMock: TranslateStoragable {
    
    var saveToStorageWasCalled = false
    var getDataFromStorageWasCalled = false
    var removeFromStorageWasCalled = false
    
    func saveToStorage(original: String, translation: String) -> TranslationWord? {
        saveToStorageWasCalled = true
        return nil
    }
    
    func getDataFromStorage(completion: @escaping ([TranslationWord]) -> ()) {
        getDataFromStorageWasCalled = true
        completion([])
    }
    
    func removeFromStorage(translation: TranslationWord) {
        removeFromStorageWasCalled = true
    }
    
}
