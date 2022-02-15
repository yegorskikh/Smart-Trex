//
//  TestVC.swift
//  Smart Trex
//
//  Created by Yegor Gorskikh on 25.01.2022.
//

import UIKit

class TestVC: UIViewController {

    let service = GoogleTranslationService()

    override func viewDidLoad() {
        super.viewDidLoad()
        


        detect()
        translate()
    
    }
    
    func detect() {
        service.detectLanguage(DetectRequest(q: "Приветик")) { data in
            guard
                let det = data?.responseData?.data?.detections?.first?.language
            else {
                let err = data?.errorMessage
                print(err!)
                return
            }
            
            print("Detect -", det)
        }
    }
    
    func translate() {
        service.toTranslate(.init(q: "Я", target: .en)) { data in

            guard
                let tr = data?.responseData?.data?.translations?.first?.translatedText
            else {
                let err = data?.errorMessage
                print(err!)
                return
            }
            print("Translated -",tr)
        }
    }
    
}

