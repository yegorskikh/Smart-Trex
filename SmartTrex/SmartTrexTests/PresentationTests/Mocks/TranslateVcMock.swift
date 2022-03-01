//
//  VcMock.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 01.03.2022.
// TranslationPresentable

import Foundation
@testable import SmartTrex
import UIKit

class TranslateVcMock: TranslateVCAble {
    var presenter: TranslationPresentable!
    var textField: UITextField!
    var label: UILabel!
    
    var showAlertWasCalled = false
    
    func showAlert(text: String) {
        showAlertWasCalled = true
    }
    
    
}
