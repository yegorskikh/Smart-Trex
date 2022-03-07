//
//  MainVC.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 07.03.2022.
//

import UIKit

class MainVC: UIViewController {

    var collector: CollectorModuleFactory!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func translateButtonTapped(_ sender: Any) {
        collector = TranslateCollectorFactory()
        let vc = collector.getModule()        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func historyButtonTapped(_ sender: Any) {
        collector = HistoryTranslateCollectorFactory()
        let vc = collector.getModule()
        present(vc, animated: true, completion: nil)
    }
    
}
