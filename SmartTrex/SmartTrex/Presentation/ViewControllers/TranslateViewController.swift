//
//  TestVC.swift
//  Smart Trex
//
//  Created by Yegor Gorskikh on 25.01.2022.
//

import UIKit
import RxSwift

class TranslateViewController: UIViewController {
    
    // MARK: - Property
    private let disposeBag = DisposeBag()
    // TODO: - ! after getting rid of the storyboard, put it in init and make it private
    var viewModel: TranslateViewModel!
    
    @IBOutlet weak var targetTextView: UITextView!
    @IBOutlet weak var targetSegmentControl: UISegmentedControl!
    @IBOutlet weak var translationTextView: UITextView!
    @IBOutlet weak var toTranslateButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputToViewModelBindings()
        outputViewModelBindings()
        internalSettingUI()
    }
    
    // MARK: - Input to VM
    
    private func inputToViewModelBindings() {
        targetTextView
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.input.onToTranslate)
            .disposed(by: disposeBag)
        
        toTranslateButton
            .rx
            .tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.onSendAction)
            .disposed(by: disposeBag)
        
        targetSegmentControl
            .rx
            .selectedTitle
            .bind(to: viewModel.input.onTarget)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Output VM
    
    private func outputViewModelBindings() {
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
    
    // MARK: - Internal setting
    
    private func internalSettingUI() {
        translationTextView.isEditable = false
        
        targetTextView
            .rx
            .text
            .subscribe(onNext: { text in
                guard let text = text else { return }
                if text.contains("\n") {
                    self.targetTextView.text.removeLast()
                    self.targetTextView.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
    }
    
}
