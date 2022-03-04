//
//  TranslationPresentable.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 01.03.2022.
//

import Foundation

protocol TranslatePresentable {
    var interactor: TranslateInteractorable! { get set  }
    var view: TranslateVCAble! { get set }
    
    func translate()
}
