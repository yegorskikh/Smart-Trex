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
    
    func translateAndSaveToStore(text: String, target: String) -> Observable<String> {
        let observable = Observable.just("Foo")
        return observable
    }
    
    // TODO: - УДАЛИТЬ ВО ВРЕМЯ ЗАДАЧИ 16
    func translateAndSaveToStore(text: String, target: String, completion: @escaping (String?, String?) -> ()) {
        wasCalled = true
        
        switch typeResponse {
        case .succes: completion("Foo", nil)
        case .error: completion(nil, "Bar")
        }
    }
    
    
}
