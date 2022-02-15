//
//  ResponeData.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 15.02.2022.
//

import Foundation

struct TranslatResponePayload {
    let responseData: TranslatResponeData?
    let errorMessage: String?
}

struct TranslatResponeData: Decodable {
    let data: TranslationsResponseModel?
}

struct TranslationsResponseModel: Decodable {
    let translations: [WordResponseModel]?
}

struct WordResponseModel: Decodable {
    let translatedText: String?
}
