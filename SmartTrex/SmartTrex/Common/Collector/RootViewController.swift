//
//  MainVC.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 07.03.2022.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: - Property
    
    var collector: CollectorModuleFactory!
    var goToVc: UIViewController!
    
    enum GoTo {
        case translate
        case historyTranslate
    }
    
    // MARK: - Action
    
    @IBAction func booksButtonTapped(_ sender: Any) {
        showAlert()
    }
    
    @IBAction func translateButtonTapped(_ sender: Any) {
        pushVc(.translate)
    }
    
    @IBAction func historyButtonTapped(_ sender: Any) {
        pushVc(.historyTranslate)
    }
    

    init() {
        super.init(nibName: nil, bundle: nil)
        print("Yep")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    //    fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func pushVc(_ to: GoTo) {
        switch to {
        case .translate:
            collector = TranslateCollectorFactory()
            goToVc = collector.getModule()
        case .historyTranslate:
            collector = HistoryTranslateCollectorFactory()
            goToVc = collector.getModule()
        }
        self.navigationController?.pushViewController(goToVc, animated: true)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Ops",
                                      message: "I'm still in development",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OKEY", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
