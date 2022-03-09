//
//  ErrorMessage.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 18.02.2022.
//

import Foundation

enum NetworkingErrorMessage: String {
    case responseData = "Failed response data"
    case statusCode = "Failed status code"
    case decodeData = "Failed decode data"
}
