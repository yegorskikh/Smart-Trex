//
//  GoogleTranslationService.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 13.02.2022.
//

import Foundation
import Alamofire

class GoogleTranslationService {
    
    // MARK: - Property
    
    private var session: Session
    private let urlString = "https://google-translate1.p.rapidapi.com/language/translate/v2"
    private let headers: HTTPHeaders = [
        "content-type": "application/x-www-form-urlencoded",
        "accept-encoding": "application/gzip",
        "x-rapidapi-host": "google-translate1.p.rapidapi.com",
        "x-rapidapi-key": SecureString.xRapidapiKey
    ]
    
    // MARK: - Lifecycle
    
    init(urlConfiguration: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = Session(configuration: urlConfiguration)
    }
    
    // MARK: - Pubclic
    
    public func toTranslate(_ words: TranslationRequestModel, completion: @escaping ((TranslationResponePayload?) -> Void)) {
        
        let url = URL(string: urlString)!
        
        session.request(url,
                        method: .post,
                        parameters: words,
                        encoder: URLEncodedFormParameterEncoder.default,
                        headers: headers)
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
                        let data = try JSONDecoder().decode(TranslationResponeData.self, from: responseData)
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
        
        let url = URL(string: urlString + "/detect")!
        
        session.request(url,
                        method: .post,
                        parameters: words,
                        encoder: URLEncodedFormParameterEncoder.default,
                        headers: headers)
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




