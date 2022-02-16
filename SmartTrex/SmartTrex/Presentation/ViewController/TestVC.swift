//
//  TestVC.swift
//  Smart Trex
//
//  Created by Yegor Gorskikh on 25.01.2022.
//

import UIKit

class TestVC: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    let service = GoogleTranslationService()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        translate(text: textField.text!)
    }
    
    // MARK: - Private
    
    private func setupViews() {
        textField.delegate = self
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.green.cgColor
        textField.layer.cornerRadius = 10.0
        textField.clipsToBounds = true
    }
    
    private func detect(text: String) {
        service.detectLanguage(DetectRequest(q: text)) { data in
            guard
                let det = data?.responseData?.data?.detections?.first?.language
            else {
                let err = data?.errorMessage
                self.label.text = err!
                return
            }
            
            self.label.text = "Detect -, \(det)"
        }
    }
    
    private func translate(text: String) {
        service.toTranslate(.init(q: text, target: .en)) { data in
            
            guard
                let tr = data?.responseData?.data?.translations?.first?.translatedText
            else {
                let err = data?.errorMessage
                self.label.text = err!
                return
            }
            self.label.text = "Translated - \(tr)"
        }
    }
    
}

extension TestVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
