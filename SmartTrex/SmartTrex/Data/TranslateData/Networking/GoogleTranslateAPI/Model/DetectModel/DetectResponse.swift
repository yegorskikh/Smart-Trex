//
//  DetectResponse.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 16.02.2022.
//

import Foundation

struct DetectLanguageResponsePayload: Codable, Equatable {
    let responseData: DetectLanguageResponseData?
    let stringError: String?
}

struct DetectLanguageResponseData: Codable, Equatable {
    let data: DetectLanguageResponseModel?
}

struct DetectLanguageResponseModel: Codable, Equatable {
    let detections: [DetectResponseModel]?
}

struct DetectResponseModel: Codable, Equatable {
    let confidence: Int?
    let language: String?
    let isReliable: Bool?
}
