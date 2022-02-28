//
//  TranslationPresenter.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 28.02.2022.
//

import Foundation

protocol TranslationPresentable {
    var interactor: TranslatorInteractorable! { get set  }
    var view: TestVCProtocol! { get set }
    
    func translate()
}

class TranslationPresenter: TranslationPresentable {
    
    weak var view: TestVCProtocol!
    var interactor: TranslatorInteractorable!
    
    func translate() {
        interactor.translateAndSaveToStore(text: view.textField.text ?? "") { translte in
            self.view.showAlert(text: translte)
            self.view.label.text = translte
        }
        
    }
    
}
