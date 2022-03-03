//
//  GoogleTranslationService.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 13.02.2022.
//

import Foundation
import Alamofire

class GoogleTranslationService: Translationable {
    
    // MARK: - Property
    
    private let session: Session
    private let urlStringTranslate = SecureUrlString.urlStringTranslate
    private let urlStringDetect = SecureUrlString.urlStringDetect
    
    // MARK: - Lifecycle
    
    init(urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = Session(configuration: urlConfiguration)
    }
    
    // MARK: - Pubclic
    
    public func toTranslate(_ words: TranslationRequestModel, completion: @escaping ((TranslationResponePayload?) -> Void)) {
            
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
                    completion(TranslationResponePayload(responseData: nil,
                                                         errorMessage: NetworkingErrorMessage.responeData.rawValue))
                    return
                }
                
                switch statusCode {
                case 200:
                    do {
                        let data = try JSONDecoder().decode(TranslateResponeData.self, from: responseData)
                        completion(TranslationResponePayload(responseData: data, errorMessage: nil))
                    } catch {
                        completion(TranslationResponePayload(responseData: nil,
                                                             errorMessage: NetworkingErrorMessage.decodeData.rawValue))
                    }
                default:
                    completion(TranslationResponePayload(responseData: nil,
                                                         errorMessage: "\(NetworkingErrorMessage.statusCode.rawValue) - \(statusCode)"))
                }
            }
    }
    
    
    
    public func detectLanguage(_ words: DetectRequest, completion: @escaping ((DetectLanguageResponePayload?) -> Void)) {
        
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
                    completion(DetectLanguageResponePayload(responseData: nil,
                                                            errorMessage: NetworkingErrorMessage.responeData.rawValue))
                    return
                }
                
                switch statusCode {
                case 200:
                    do {
                        let data = try JSONDecoder().decode(DetectLanguageResponeData.self, from: responseData)
                        completion(DetectLanguageResponePayload(responseData: data, errorMessage: nil))
                    } catch {
                        completion(DetectLanguageResponePayload(responseData: nil,
                                                                errorMessage:  NetworkingErrorMessage.decodeData.rawValue))
                    }
                default:
                    completion(DetectLanguageResponePayload(responseData: nil,
                                                            errorMessage: "\(NetworkingErrorMessage.statusCode.rawValue) - \(statusCode)"))
                }
            }
    }
    
}




