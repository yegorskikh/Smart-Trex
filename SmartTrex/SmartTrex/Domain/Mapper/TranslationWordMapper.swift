//
//  TranslationWordMapper.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 08.06.2022.
//

import Foundation

protocol TranslationWordMapperable {
    func toPresentationLayer(from models: [TranslationWord]) -> [TranslationWordPresentation]
    func toDataLayer(from model: TranslationWordPresentation) -> UUID
}

struct TranslationWordMapper: TranslationWordMapperable {
    
    func toPresentationLayer(from models: [TranslationWord]) -> [TranslationWordPresentation] {
        var modelsPresentation: [TranslationWordPresentation] = []
        
        for i in models {
            guard
                let uuid = i.uuid,
                let original = i.original,
                let translation = i.translation
            else {
                continue
            }
            
            modelsPresentation.append(TranslationWordPresentation(uuid: uuid,
                                                                  original: original,
                                                                  translation: translation))
        }
        
        return modelsPresentation
    }
    
    func toDataLayer(from model: TranslationWordPresentation) -> UUID {
        return model.uuid
    }
    
}
