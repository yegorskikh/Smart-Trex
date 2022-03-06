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

        let text = self.view.getTextForTranslation()
        let target = self.view.getSelectedLanguageForTranslation()        
        
        interactor.translateAndSaveToStore(text: text, target: target) { [weak self] translation, error in
            
            guard
                let translation = translation
            else {
                self?.view.showErrorAlert(text: error!)
                return
            }
            
            self?.view.setTheResultingTextTranslation(text: translation)
        }
        
    }
    
    
}
