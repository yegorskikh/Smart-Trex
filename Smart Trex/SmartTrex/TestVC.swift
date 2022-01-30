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
    
    var data = [TranslationWord]()
    
    lazy var coreDataStack = WordStoreManager(managedObjectContext: CoreDataStack().mainContext, coreDataStack: CoreDataStack())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        var _ = coreDataStack.saveData(word: originalLabel.text!, translation: translationLabel.text!)
        printSaveData()
    }
    
    @IBAction func delButtonTapped(_ sender: Any) {
        let first = data[0]
        coreDataStack.delete(word: first)
        printSaveData()
    }
    
    private func printSaveData() {
        coreDataStack.fetchArrayData { data in
            self.data = data
            print(data.count)
        }
    }
    
}

