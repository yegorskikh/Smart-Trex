//
//  WordRequestModel.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 15.02.2022.
//

import Foundation

struct TranslatRequestModel: Encodable {
    let q: String
    let target: String
}
