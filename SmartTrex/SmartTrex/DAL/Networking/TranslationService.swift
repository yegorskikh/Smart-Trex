import Foundation
import Alamofire

struct WordRequestModel: Encodable {
    let q: String
    let target: String
}



struct ResponeData: Decodable {
    let data: TranslationsResponseModel?
}

struct TranslationsResponseModel: Decodable {
    let translations: [WordResponseModel]?
}

struct WordResponseModel: Decodable {
    let translatedText: String?
}


class TranslationService {
    
    let session: Session = Session(configuration: URLSessionConfiguration.default)
    let url = URL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2")!
    
    let headers: HTTPHeaders = [
        "content-type": "application/x-www-form-urlencoded",
        "accept-encoding": "application/gzip",
        "x-rapidapi-host": "google-translate1.p.rapidapi.com",
        "x-rapidapi-key": "9d2d2a03c1mshc9f23a48517a991p1dd382jsna54af8d5d5bd"
    ]
    
    func dontWork(_ word: WordRequestModel, completion: @escaping ((ResponeData?) -> Void)) {
        
        session.request(url,
                        method: .post,
                        parameters: WordRequestModel(q: "Hello", target: "es"),
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

                print("Status code: ", statusCode)
                
                do {
                    let data = try JSONDecoder().decode(ResponeData.self, from: responseData)
                    print("Success! - ", data)
                    completion(data)
                }
                catch {
                    print("Faild decode data")
                    completion(nil)
                }
            }
            
    }
    
    
}




