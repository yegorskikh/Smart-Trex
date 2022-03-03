//
//  ResponeData.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 15.02.2022.
//

import Foundation

struct TranslationResponePayload {
    let responseData: TranslateResponeData?
    let errorMessage: String?
}

struct TranslateResponeData: Codable, Equatable {
    let data: TranslationResponseModel?
}

struct TranslationResponseModel: Codable, Equatable {
    let translations: [WordResponseModel]?
}

struct WordResponseModel: Codable, Equatable {
    let translatedText: String?
}
