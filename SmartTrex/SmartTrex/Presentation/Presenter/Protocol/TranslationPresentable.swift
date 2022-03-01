//
//  TranslationPresentable.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 01.03.2022.
//

import Foundation

protocol TranslationPresentable {
    var interactor: TranslatorInteractorable! { get set  }
    var view: TranslateVCAble! { get set }
    
    func translate()
}
