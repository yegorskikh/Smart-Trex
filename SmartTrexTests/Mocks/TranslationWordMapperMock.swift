//
//  TranslationWordMapperMock.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 09.06.2022.
//

import Foundation
@testable import SmartTrex

class TranslationWordMapperMock: TranslationWordMapperable {
    
    var response = [TranslationWordPresentation(uuid: UUID(), original: "Bar", translation: "Baz")]
    
    func toPresentationLayer(from models: [TranslationWord]) -> [TranslationWordPresentation] {
        return response
    }
    
    func toDataLayer(from model: TranslationWordPresentation) -> UUID {
        return UUID()
    }
    
}
