//
//  Translationable.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 27.02.2022.
//

import Foundation

protocol Translationable {
    func toTranslate(_ words: TranslationRequestModel, completion: @escaping ((TranslationResponePayload?) -> Void))
}
