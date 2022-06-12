//
//  StoreMock.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 27.02.2022.
//

import Foundation
@testable import SmartTrex
import RxSwift
import RxCocoa

class StoreMock: TranslateStoragable {

    var saveToStorageWasCalled = false
    var getDataFromStorageWasCalled = false
    var removeFromStorageWasCalled = false

    func getDataFromStorage() -> Single<[TranslationWord]> {
        Single<[TranslationWord]>.create { [weak self] single in
            self?.getDataFromStorageWasCalled = true
            single(.success([]))
            return Disposables.create()
        }
    }

    func saveToStorage(original: String, translation: String) -> TranslationWord? {
        saveToStorageWasCalled = true
        return nil
    }

    func removeFromStorage(by uuid: UUID) {
        removeFromStorageWasCalled = true
    }

}
