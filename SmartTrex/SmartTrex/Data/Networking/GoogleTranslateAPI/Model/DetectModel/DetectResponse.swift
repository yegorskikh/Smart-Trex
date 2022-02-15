//
//  DetectResponse.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 16.02.2022.
//

import Foundation

struct DetectLanguageResponePayload: Decodable {
    let responseData: DetectLanguageResponeData?
    let errorMessage: String?
}

struct DetectLanguageResponeData: Decodable {
    let data: DetectLanguageResponseModel?
}

struct DetectLanguageResponseModel: Decodable {
    let detections: [DetectResponseModel]?
}

struct DetectResponseModel: Decodable {
    let confidence: Int?
    let language: String?
    let isReliable: Bool?
}
