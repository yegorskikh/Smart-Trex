//
//  TranslationPresenter.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 28.02.2022.
//

import Foundation
import RxSwift

protocol TranslatePresentable {
    var interactor: TranslateInteractorable! { get set  }
    var view: TranslateVCAble! { get set }
    
    func translate()
}

class TranslatePresenter: TranslatePresentable {
    
    weak var view: TranslateVCAble!
    var interactor: TranslateInteractorable!
    let disposeBag = DisposeBag()
    
    func translate() {
        let text = self.view.getTextForTranslation()
        let target = self.view.getSelectedLanguageForTranslation()
        
        interactor
            .translateAndSaveToStore(text: text, target: target)
            .subscribe {
                self.view.setTheResultingTextTranslation(text: $0)
            } onError: {
                self.view.showErrorAlert(text: $0.localizedDescription)
            }
            .disposed(by: disposeBag)
        
    }
    
}

class TranslateViewModel {
    
    let input: Input
    let output: Output
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init() {
        input = Input()
        output = Output()
        
        initBindings()
    }
    
    private func initBindings() {
        
    }
    
}
