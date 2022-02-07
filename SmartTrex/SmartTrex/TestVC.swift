//
//  TestVC.swift
//  Smart Trex
//
//  Created by Yegor Gorskikh on 25.01.2022.
//

import UIKit
import CoreData

class TestVC: UIViewController {
    
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        printTest()
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {

    }
    
    @IBAction func delButtonTapped(_ sender: Any) {

    }
    
    private func printTest() {
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "accept-encoding": "application/gzip",
            "x-rapidapi-host": "google-translate1.p.rapidapi.com",
            "x-rapidapi-key": "9d2d2a03c1mshc9f23a48517a991p1dd382jsna54af8d5d5bd"
        ]

        let postData = NSMutableData(data: "q=Hello, world!&target=ru&source=en".data(using: String.Encoding.utf8)!)
//        postData.append("&target=ru".data(using: String.Encoding.utf8)!)
//        postData.append("&source=en".data(using: String.Encoding.utf8)!)

        let request = NSMutableURLRequest(url: NSURL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                print("This is translate -", data)
                do {
                    let transData = try JSONDecoder.decode(String.self, from )
                }
                catch let error {
                    print(error.localizedDescription)
                }
            }
        })

        dataTask.resume()
    }
    
}

struct Tr: Codable {
    
}
