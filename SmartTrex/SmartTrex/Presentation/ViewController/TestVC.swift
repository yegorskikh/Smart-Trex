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
        service.dontWork(.init(q: "Hello, World!", target: "ru")) { data in
            print(data)
        }
    
    }
    
    
}

