//
//  TranslationPresenter.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 28.02.2022.
//

import Foundation

class TranslatePresenter: TranslatePresentable {
    
    weak var view: TranslateVCAble!
    var interactor: TranslateInteractorable!
    
    func translate() {
        // TODO: - Pull target with view
        interactor.translateAndSaveToStore(text: view.textField.text ?? "", target: .en) { [weak self] translte, error in
            
            guard
                let translte = translte
            else {
                self?.view.showErrorAlert(text: error!)
                return
            }

            self?.view.label.text = translte
        }
        
    }
    
}
