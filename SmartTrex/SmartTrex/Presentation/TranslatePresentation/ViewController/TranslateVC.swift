//
//  TestVC.swift
//  Smart Trex
//
//  Created by Yegor Gorskikh on 25.01.2022.
//

import UIKit

class TranslateVC: UIViewController, TranslateVCAble {

    // MARK: - Property
    
    @IBOutlet weak var targetTextView: UITextView!
    @IBOutlet weak var targetSegmentControl: UISegmentedControl!
    @IBOutlet weak var translationTextView: UITextView!
    
    var presenter: TranslatePresentable!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextViews()
    }
    
    @IBAction func translateButtonTapped(_ sender: Any) {
        presenter.translate()
    }
    
    // MARK: - Internal
    
    func showErrorAlert(text: String) {
        let alert = UIAlertController(title: "Something went wrong",
                                      message: text,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getTextForTranslation() -> String {
        return targetTextView.text ?? ""
    }
    
    func setTheResultingTextTranslation(text: String) {
        translationTextView.text = text
    }
    
    func getSelectedLanguageForTranslation() -> String {
        return targetSegmentControl.titleForSegment(at: targetSegmentControl.selectedSegmentIndex) ?? "en"
    }
    
    // MARK: - Private
    
    private func setupTextViews() {
        targetTextView.delegate = self
        translationTextView.isEditable = false
    }
    
}

// MARK: - UITextViewDelegate

extension TranslateVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
            
        }
        return true
    }
    
}


