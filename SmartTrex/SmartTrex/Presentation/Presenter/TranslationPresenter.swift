//
//  TranslationPresenter.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 28.02.2022.
//

import Foundation

protocol TranslationPresentable {
    var interactor: TranslatorInteractorable { get }
    var view: TestVC! { get set }
    
    func translate()
}

class TranslationPresenter: TranslationPresentable {
    
    weak var view: TestVC!
    var interactor: TranslatorInteractorable
   
    init(interactor: TranslatorInteractorable) {
        self.interactor = interactor
    }
    
    func translate() {
        interactor.translateAndSaveToStore(text: view.textField.text ?? "") { translte in
            self.view.label.text = translte
        }
        
    }
    
}
