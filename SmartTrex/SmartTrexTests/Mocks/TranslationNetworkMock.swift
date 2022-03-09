//
//  TranslationNetworkMock.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 27.02.2022.
//

import Foundation
@testable import SmartTrex

class TranslationNetworkMock: Translationable {
    
    var responseType: ResponseType = .success
    
    enum ResponseType {
        case success
        case failed
    }
    
    func responseType(responseType: ResponseType) {
        self.responseType = responseType
    }
    
    func toTranslate(_ words: TranslationRequestModel, completion: @escaping ((TranslationResponsePayload?) -> Void)) {
        switch responseType {
        case .success: completion(.init(responseData: .init(data: .init(translations: [.init(translatedText: "Baz")])),
                                        stringError: nil))
        case .failed: completion(.init(responseData: nil, stringError: "Foo"))
        }
    }
    
}
