//
//  HistoryTranslateInteractorable.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 08.03.2022.
//

import Foundation

protocol HistoryTranslateInteractorable {
    var storage: TranslateStoragable! { get set }
    
    func getData(completion: @escaping ([TranslationWord]) -> ())
    func removeElement(translation: TranslationWord)
}
