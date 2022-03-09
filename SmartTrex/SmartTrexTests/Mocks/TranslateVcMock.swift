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

    var presenter: TranslatePresentable!
    var textField: UITextField!
    var label: UILabel!
    
    var showAlertWasCalled = false
    var setTranslationTextWasCalled = false
    
    init() {
        textField = UITextField()
        label = UILabel()
        textField.text = "Foo"
    }
    
    func showErrorAlert(text: String) {
        showAlertWasCalled = true
    }
    
    func getTextForTranslation() -> String {
        return "Foo"
    }
    
    func getSelectedLanguageForTranslation() -> String {
        return "Foo"
    }
    
    func setTheResultingTextTranslation(text: String) {
        setTranslationTextWasCalled = true
    }
    
}
