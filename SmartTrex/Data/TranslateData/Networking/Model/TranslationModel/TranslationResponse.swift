//
//  ResponeData.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 15.02.2022.
//

import Foundation

struct TranslationResponsePayload {
    let responseData: TranslateResponseData?
    let stringError: String?
}

struct TranslateResponseData: Codable, Equatable {
    let data: TranslationResponseModel?
}

struct TranslationResponseModel: Codable, Equatable {
    let translations: [WordResponseModel]?
}

struct WordResponseModel: Codable, Equatable {
    let translatedText: String?
}
