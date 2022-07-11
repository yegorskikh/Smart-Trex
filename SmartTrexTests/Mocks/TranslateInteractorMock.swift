//
//  TranslateInteractorMock.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 01.03.2022.
//

import Foundation
@testable import SmartTrex
import RxSwift

class TranslateInteractorMock: TranslateInteractorable {
    
    var serviceStorage: TranslateStoragable!
    var serviceTranslate: Translationable!
    var wasCalled = false
    
    
    enum TypeResponse {
        case succes
        case error
    }
    
    var typeResponse = TypeResponse.succes
    
    /// return: ```Observable.just("Foo")```
    func translateAndSaveToStore(text: String, target: String) -> Observable<String> {
        switch typeResponse {
        case .succes:
            wasCalled = true
            let observable = Observable.just("Foo")
            return observable
        case .error:
            wasCalled = true
            let observable = Observable<String>.error(NetworkingErrorMessage.responseData)
            return observable
        }
    }
    
}
