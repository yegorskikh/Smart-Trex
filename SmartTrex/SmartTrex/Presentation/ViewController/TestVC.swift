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
        
        service.toTranslate(.init(q: "Я", target: "en")) { data in
            
            guard let tr = data?.responseData?.data?.translations?.first?.translatedText else { return }
            print("Translated -",tr)
        }
    
    }
    
    
}

