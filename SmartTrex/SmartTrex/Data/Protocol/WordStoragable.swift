//
//  WordStoragable.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 27.02.2022.
//

import Foundation

protocol WordStoragable {
    func saveToStorage(original: String, translation: String) -> TranslationWord?
    func getDataFromStorage(completion: @escaping ([TranslationWord]) -> ())
    func removeFromStorage(_ word: TranslationWord)
}
