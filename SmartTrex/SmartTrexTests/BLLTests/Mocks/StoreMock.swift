//
//  StoreMock.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 27.02.2022.
//

import Foundation
@testable import SmartTrex

class StoreMock: TranslateStoragable {
    
    var wasCalled = false
    
    func saveToStorage(original: String, translation: String) -> TranslationWord? {
        wasCalled = true
        return nil
    }
    
    func getDataFromStorage(completion: @escaping ([TranslationWord]) -> ()) { }
    func removeFromStorage(_ word: TranslationWord) { }
}
