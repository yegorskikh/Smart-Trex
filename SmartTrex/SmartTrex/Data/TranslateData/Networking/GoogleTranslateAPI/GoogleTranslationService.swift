//
//  GoogleTranslationService.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 13.02.2022.
//

import Foundation
import Alamofire

protocol Translationable {
    func toTranslate(_ words: TranslationRequestModel, completion: @escaping ((TranslationResponsePayload?) -> Void))
}

class GoogleTranslationService: Translationable {
    
    // MARK: - Property
    
    private let session: Session
    private let urlStringTranslate = SecureUrlString.urlStringTranslate
    private let urlStringDetect = SecureUrlString.urlStringDetect
    
    // MARK: - Lifecycle
    
    init(urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = Session(configuration: urlConfiguration)
    }
    
    // MARK: - Public
    
    public func toTranslate(_ words: TranslationRequestModel, completion: @escaping ((TranslationResponsePayload?) -> Void)) {
        
        session.request(URL(string: urlStringTranslate)!,
                        method: .post,
                        parameters: words,
                        encoder: URLEncodedFormParameterEncoder.default,
                        headers: SecureHeader.headers)
            .response { response in
                
                guard
                    let responseData = response.data,
                    let statusCode = response.response?.statusCode
                else {
                    completion(TranslationResponsePayload(responseData: nil,
                                                          stringError: NetworkingErrorMessage.responseData.rawValue))
                    return
                }
                
                switch statusCode {
                case 200:
                    do {
                        let data = try JSONDecoder().decode(TranslateResponseData.self, from: responseData)
                        completion(TranslationResponsePayload(responseData: data, stringError: nil))
                    } catch {
                        completion(TranslationResponsePayload(responseData: nil,
                                                              stringError: NetworkingErrorMessage.decodeData.rawValue))
                    }
                default:
                    completion(TranslationResponsePayload(responseData: nil,
                                                          stringError: "\(NetworkingErrorMessage.statusCode.rawValue) - \(statusCode)"))
                }
            }
    }
    
    
    
    public func detectLanguage(_ words: DetectRequest, completion: @escaping ((DetectLanguageResponsePayload?) -> Void)) {
        
        session.request(URL(string: urlStringDetect)!,
                        method: .post,
                        parameters: words,
                        encoder: URLEncodedFormParameterEncoder.default,
                        headers: SecureHeader.headers)
            .response { response in
                
                guard
                    let responseData = response.data,
                    let statusCode = response.response?.statusCode
                else {
                    completion(DetectLanguageResponsePayload(responseData: nil,
                                                             stringError: NetworkingErrorMessage.responseData.rawValue))
                    return
                }
                
                switch statusCode {
                case 200:
                    do {
                        let data = try JSONDecoder().decode(DetectLanguageResponeData.self, from: responseData)
                        completion(DetectLanguageResponsePayload(responseData: data, stringError: nil))
                    } catch {
                        completion(DetectLanguageResponsePayload(responseData: nil,
                                                                 stringError:  NetworkingErrorMessage.decodeData.rawValue))
                    }
                default:
                    completion(DetectLanguageResponsePayload(responseData: nil,
                                                             stringError: "\(NetworkingErrorMessage.statusCode.rawValue) - \(statusCode)"))
                }
            }
    }
    
}




