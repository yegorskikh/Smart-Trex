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

struct TranslationResponeData: Decodable {
    let data: TranslationResponseModel?
}

struct TranslationResponseModel: Decodable {
    let translations: [WordResponseModel]?
}

struct WordResponseModel: Decodable {
    let translatedText: String?
}
