//
//  TestVC.swift
//  Smart Trex
//
//  Created by Yegor Gorskikh on 25.01.2022.
//

import UIKit
import RxSwift

class TranslateVC: UIViewController {

    // MARK: - Property
    private let disposeBag = DisposeBag()
    // TODO: - after getting rid of the storyboard, put it in init and make it private
    var viewModel: TranslateViewModel!
    
    @IBOutlet weak var targetTextView: UITextView!
    @IBOutlet weak var targetSegmentControl: UISegmentedControl!
    @IBOutlet weak var translationTextView: UITextView!
    @IBOutlet weak var toTranslateButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBindings()
        setupTextViews()
    }
    
    // MARK: - Private
    
    private func setupTextViews() {
        targetTextView.delegate = self
        translationTextView.isEditable = false
    }
    
    private func initBindings() {
        // MARK: - Input to VM
        targetTextView
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.input.onToTranslate)
            .disposed(by: disposeBag)
                
        toTranslateButton
            .rx
            .tap
            .bind(to: viewModel.input.onSendAction)
            .disposed(by: disposeBag)
        
        targetSegmentControl
            .rx
            .selectedTitle
            .bind(to: viewModel.targetToTranslate)
            .disposed(by: disposeBag)
        
        // MARK: - Output VM
        viewModel
            .output
            .onError
            .drive(self.rx.showAlert)
            .disposed(by: disposeBag)
        
        viewModel
            .output
            .onTranslate
            .drive(translationTextView.rx.text)
            .disposed(by: disposeBag)
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
