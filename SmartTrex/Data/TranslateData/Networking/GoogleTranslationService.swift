//
//  GoogleTranslationService.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 13.02.2022.
//

import Foundation
import Alamofire
import RxSwift

protocol Translationable {
    func toTranslate(word: TranslationRequestModel) -> Single<String>
    func getLanguages() -> Single<[String]>
}

class GoogleTranslationService: Translationable {
    
    // MARK: - Property
    private let session: Session
    
    // MARK: - Lifecycle
    
    init(urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = Session(configuration: urlConfiguration)
    }
    
    // MARK: - Public
    func toTranslate(word: TranslationRequestModel) -> Single<String> {
        return Single<String>.create { single in
            
            self.session.request(URL(string: SecureUrlString.urlStringTranslate)!,
                                 method: .post,
                                 parameters: word,
                                 encoder: URLEncodedFormParameterEncoder.default,
                                 headers: SecureHeader.headers)
            .response { response in
                
                guard
                    let responseData = response.data,
                    let statusCode = response.response?.statusCode
                else {
                    single(.failure(NetworkingErrorMessage.responseData))
                    return
                }
                
                switch statusCode {
                case 200..<300:
                    do {
                        let data = try JSONDecoder().decode(TranslateResponseData.self, from: responseData)
                        
                        guard
                            let translation = data.data?.translations?.first?.translatedText
                        else {
                            single(.failure(NetworkingErrorMessage.corruptedData))
                            return
                        }
                        
                        single(.success(translation))
                    } catch {
                        single(.failure(NetworkingErrorMessage.decodeData))
                        return
                    }
                default:
                    single(.failure(NetworkingErrorMessage.statusCode))
                    return
                }
            }
            
            return Disposables.create { self.session.cancelAllRequests() }
        }
    }
    
    func getLanguages() -> Single<[String]> {
        
        return Single<[String]>.create { single in
            self.session.request(URL(string: SecureUrlString.urlStringLanguage)!,
                                 method: .get,
                                 parameters: LanguagesRequest(target: nil, model: "nmt"),
                                 encoder: URLEncodedFormParameterEncoder.default,
                                 headers: SecureHeader.headers)
            .response { response in
                
                guard
                    let responseData = response.data,
                    let statusCode = response.response?.statusCode
                else {
                    single(.failure(NetworkingErrorMessage.responseData))
                    return
                }
                
                switch statusCode {
                case 200..<300:
                    do {
                        let data = try JSONDecoder().decode(LanguagesDataResponse.self, from: responseData)
                        
                        guard
                            let data = data.data?.languages
                        else {
                            single(.failure(NetworkingErrorMessage.corruptedData))
                            return
                        }
                        let languages = data.compactMap { $0.language }
                        single(.success(languages))
                    } catch {
                        single(.failure(NetworkingErrorMessage.decodeData))
                        return
                    }
                default:
                    single(.failure(NetworkingErrorMessage.statusCode))
                    return
                }
            }
            
            return Disposables.create { self.session.cancelAllRequests() }
        }
        
    }
    
}


