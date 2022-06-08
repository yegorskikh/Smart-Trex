//
//  TranslationWordMapper.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 08.06.2022.
//

import Foundation

struct TranslationWordMapper {
    
    func toPresentationLayer(from model: TranslationWord) -> TranslationWordPresentation? {
        guard
            let uuid = model.uuid,
            let original = model.original,
            let translation = model.translation
        else {
            return nil
        }
        let modelPresentation = TranslationWordPresentation(uuid: uuid,
                                                            original: original,
                                                            translation: translation)
        return modelPresentation
    }
    
    func toDataLayer(from model: TranslationWordPresentation) -> UUID {
        return model.uuid
    }
    
}
