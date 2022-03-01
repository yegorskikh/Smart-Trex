//
//  TranslationPresenter.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 28.02.2022.
//

import Foundation

class TranslationPresenter: TranslationPresentable {
    
    weak var view: TranslateVCAble!
    var interactor: TranslatorInteractorable!
    
    func translate() {
        interactor.translateAndSaveToStore(text: view.textField.text ?? "") { [weak self] translte, error in
            
            guard
                let translte = translte
            else {
                self?.view.showAlert(text: error!)
                return
            }

            self?.view.label.text = translte
        }
        
    }
    
}
