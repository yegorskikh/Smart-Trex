//
//  TestVCProtocol.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 01.03.2022.
//

import Foundation
import UIKit

protocol TranslateVCAble: AnyObject {
    var presenter: TranslationPresentable! { get set }
    var textField: UITextField! { get }
    var label: UILabel! { get }
    
    func showAlert(text: String)
}
