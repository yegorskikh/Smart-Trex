import Foundation
import Alamofire

class GoogleTranslationService {
    
    let session: Session = Session(configuration: URLSessionConfiguration.default)
    let url = URL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2")!
    
    let headers: HTTPHeaders = [
        "content-type": "application/x-www-form-urlencoded",
        "accept-encoding": "application/gzip",
        "x-rapidapi-host": "google-translate1.p.rapidapi.com",
        "x-rapidapi-key": SecureString.xRapidapiKey
    ]
    
    func toTranslate(_ words: TranslatRequestModel, completion: @escaping ((TranslatResponePayload?) -> Void)) {
        
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
                    completion(TranslatResponePayload(responseData: nil,
                                                      errorMessage: "Faild response data"))
                    return
                }

                
                switch statusCode {
                case 200:
                    do {
                        let data = try JSONDecoder().decode(TranslatResponeData.self, from: responseData)
                        completion(TranslatResponePayload(responseData: data, errorMessage: nil))
                    }
                    catch {
                        completion(TranslatResponePayload(responseData: nil,
                                                          errorMessage: "Faild decode data"))
                    }
                default:
                    completion(TranslatResponePayload(responseData: nil,
                                                      errorMessage: "Faild status code"))
                }
                
            }
            
    }
    
    
}




