//
//  LanguagesResponse.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 15.07.2022.
//

struct LanguagesDataResponse: Codable {
    let data: Languages?
}

struct Languages: Codable {
    let languages: [Language]?
}

struct Language: Codable {
    let language: String?
}
