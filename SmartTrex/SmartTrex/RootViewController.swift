//
//  MainVC.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 07.03.2022.
//

import UIKit

class RootViewController: UIViewController {

    var collector: CollectorModuleFactory!
    
   
    @IBAction func booksButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Ops",
                                      message: "I'm still in development",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OKEY", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func translateButtonTapped(_ sender: Any) {
        collector = TranslateCollectorFactory()
        let vc = collector.getModule()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func historyButtonTapped(_ sender: Any) {
        collector = HistoryTranslateCollectorFactory()
        let vc = collector.getModule()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
