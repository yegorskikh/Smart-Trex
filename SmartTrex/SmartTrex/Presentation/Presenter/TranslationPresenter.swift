//
//  TranslationPresenter.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 28.02.2022.
//

import Foundation

protocol TranslationPresentable {
    var interactor: TranslatorInteractorable! { get set  }
    var view: TestVC! { get set }
    
    func translate()
}

class TranslationPresenter: TranslationPresentable {
    
    weak var view: TestVC!
    var interactor: TranslatorInteractorable!
    
    func translate() {
        interactor.translateAndSaveToStore(text: view.textField.text ?? "") { translte in
            self.view.label.text = translte
        }
        
    }
    
}
