//
//  TranslatorInteractorable.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 27.02.2022.
//

import Foundation

protocol TranslatorInteractorable {
    var serviceStorage: WordStoragable! { get set }
    var serviceTranslate: Translationable! { get set }
        
    func translateAndSaveToStore(text: String, completion: @escaping (_ translate: String?,
                                                                      _ error: String?) -> () )
}
