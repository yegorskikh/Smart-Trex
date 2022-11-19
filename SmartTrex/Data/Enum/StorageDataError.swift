//
//  StorageDataError.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 13.06.2022.
//

import Foundation

enum StorageDataError: LocalizedError {
    case failedData
    
    var errorDescription: String? {
        switch self {
        case .failedData:
            return "Wrong data in storage"
        }
    }
}
