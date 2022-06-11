//
//  ErrorMessage.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 18.02.2022.
//

import Foundation

enum NetworkingErrorMessage: LocalizedError {
    
    case responseData
    case statusCode
    case decodeData
    case corruptedData
    
    var errorDescription: String {
        switch self {
        case .responseData:
            return "Failed response data"
        case .statusCode:
            return "Failed status code"
        case .decodeData:
            return "Failed decode data"
        case .corruptedData:
            return "Corrupted data"
        }
    }

}
