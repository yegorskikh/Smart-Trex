//
//  String+Validation.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 26.06.2022.
//

import Foundation

extension String {
    
    func isLetter() -> Bool {
        var set = Set(self)
        
        guard
            let spaceIndex = set.firstIndex(of: " ")
        else {
            return !set.isEmpty
        }
        
        set.remove(at: spaceIndex)
        
        return !set.isEmpty
    }
    
}
