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
    
    lazy var coreDataStack = CoreDataStack(modelName: "TranslationWord")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        coreDataStack.saveData(word: originalLabel.text!, translation: translationLabel.text!)
        printSaveData()
    }
    
    private func printSaveData() {
        coreDataStack.fetchData { data in
            print(data.count)
        }
    }
    
}

