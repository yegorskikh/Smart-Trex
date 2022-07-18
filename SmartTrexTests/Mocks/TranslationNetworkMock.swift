//
//  TranslationNetworkMock.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 27.02.2022.
//

import Foundation
import RxCocoa
import RxSwift
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
    
    func toTranslate(word: TranslationRequestModel) -> Single<String> {
        return Single<String>.create { single in
            
            switch self.responseType {
            case .success:
                let response = "Baz"
                single(.success(response))
            case .failed:
                single(.failure(NetworkingErrorMessage.responseData))
            }
            return Disposables.create()
        }
        
    }
    
    func getLanguages() -> Single<[String]> {
        return Single<[String]>.create { single in
            
            switch self.responseType {
            case .success:
                let response = ["Baz"]
                single(.success(response))
            case .failed:
                single(.failure(NetworkingErrorMessage.responseData))
            }
            return Disposables.create()
        }
    }
    
}
