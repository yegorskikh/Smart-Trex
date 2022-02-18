//
//  ResponeData.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 15.02.2022.
//

import Foundation

struct TranslationResponePayload {
    let responseData: TranslationResponeData?
    let errorMessage: String?
}

struct TranslationResponeData: Codable, Equatable {
    let data: TranslationResponseModel?
}

struct TranslationResponseModel: Codable, Equatable {
    let translations: [WordResponseModel]?
}

struct WordResponseModel: Codable, Equatable {
    let translatedText: String?
}
