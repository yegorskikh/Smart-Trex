//
//  TestVCProtocol.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 01.03.2022.
//

import Foundation
import UIKit

protocol TranslateVCAble: AnyObject {
    var presenter: TranslatePresentable! { get set }
//    var textField: UITextField! { get }
//    var label: UILabel! { get }
    
    func showErrorAlert(text: String)
    func getTextForTranslation() -> String
    func getSelectedLanguageForTranslation() -> String
    func setTheResultingTextTranslation(text: String)
}
