//
//  WordRequestModel.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 15.02.2022.
//

import Foundation

struct TranslationRequestModel: Codable {
    
    enum TargerLanguage: String, Codable {
        case ru = "ru"
        case en = "en"
    }
    
    let q: String
    let target: TargerLanguage
    
}
