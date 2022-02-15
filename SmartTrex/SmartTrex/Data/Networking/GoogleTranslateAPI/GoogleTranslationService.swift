import Foundation
import Alamofire

class GoogleTranslationService {
    
    let session: Session = Session(configuration: URLSessionConfiguration.default)
    let url = URL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2")!
    
    let headers: HTTPHeaders = [
        "content-type": "application/x-www-form-urlencoded",
        "accept-encoding": "application/gzip",
        "x-rapidapi-host": "google-translate1.p.rapidapi.com",
        "x-rapidapi-key": "9d2d2a03c1mshc9f23a48517a991p1dd382jsna54af8d5d5bd"
    ]
    
    func dontWork(_ word: TranslatRequestModel, completion: @escaping ((TranslatResponeData?) -> Void)) {
        
        session.request(url,
                        method: .post,
                        parameters: word,
                        encoder: URLEncodedFormParameterEncoder.default,
                        headers: headers)
            .response { response in

                guard
                    let responseData = response.data,
                    let statusCode = response.response?.statusCode
                else {
                    print("Faild response data")
                    completion(nil)
                    return
                }

                
                switch statusCode {
                case 200:
                    do {
                        let data = try JSONDecoder().decode(TranslatResponeData.self, from: responseData)
                        completion(data)
                    }
                    catch {
                        print("Faild decode data")
                        completion(nil)
                    }
                default:
                    print("Faild status code")
                    completion(nil)
                }
                
            }
            
    }
    
    
}




