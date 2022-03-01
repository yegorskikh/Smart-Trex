//
//  TranslatorInteractorable.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 27.02.2022.
//

import Foundation

protocol TranslatorInteractorable {
    var serviceStorage: WordStoragable { get }
    var serviceTranslate: Translationable { get }
        
//    func translateAndSaveToStore(text: String, completion: @escaping (String) -> ())
    func translateAndSaveToStore(text: String, completion: @escaping (_ translate: String?,
                                                                      _ error: String?) -> () )
}
