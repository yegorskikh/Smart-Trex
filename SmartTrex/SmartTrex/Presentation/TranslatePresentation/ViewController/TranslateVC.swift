//
//  TestVC.swift
//  Smart Trex
//
//  Created by Yegor Gorskikh on 25.01.2022.
//

import UIKit

class TranslateVC: UIViewController, TranslateVCAble {

    // MARK: - Property
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var targetSegmentControl: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    
    var presenter: TranslatePresentable!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Action
    
    @IBAction func buttonTapped(_ sender: Any) {
        presenter.translate()
    }
    
    func showErrorAlert(text: String) {
        let alert = UIAlertController(title: "Something went wrong",
                                      message: text,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getTextForTranslation() -> String {
        return textField.text ?? ""
    }
    
    func setTheResultingTextTranslation(text: String) {
        textView.text = text
    }
    
    // MARK: - Private
    
    private func setupViews() {
        textField.delegate = self
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.green.cgColor
        textField.layer.cornerRadius = 10.0
        textField.clipsToBounds = true
    }
    
    func getSelectedLanguageForTranslation() -> String {
        return targetSegmentControl.titleForSegment(at: targetSegmentControl.selectedSegmentIndex) ?? "en"
    }
    
}

extension TranslateVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


