//
//  DetectResponse.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 16.02.2022.
//

import Foundation

struct DetectLanguageResponePayload: Codable, Equatable {
    let responseData: DetectLanguageResponeData?
    let errorMessage: String?
}

struct DetectLanguageResponeData: Codable, Equatable {
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
