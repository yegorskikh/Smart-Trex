//
//  TranslatorInteractorable.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 27.02.2022.
//

import Foundation

protocol TranslateInteractorable {
    var serviceStorage: TranslateStoragable! { get set }
    var serviceTranslate: Translationable! { get set }
        
    func translateAndSaveToStore(text: String, target: String, completion: @escaping (_ translate: String?,
                                                                      _ error: String?) -> () )
}
