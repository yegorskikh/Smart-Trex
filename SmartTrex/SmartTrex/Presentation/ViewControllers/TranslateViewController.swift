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
    
    private let translateView = TranslateView()
    private let disposeBag = DisposeBag()
    private let viewModel: TranslateViewModel
    
    // MARK: - Object lifecycle
    
    init(viewModel: TranslateViewModel, nibName: String? = nil, bundle: Bundle? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: bundle)
        self.inputToViewModelBindings()
        self.outputViewModelBindings()
        self.internalSettingUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController lifecycle
    
    override func loadView() {
        view = translateView
    }
    
    // MARK: - Input to VM
    
    private func inputToViewModelBindings() {
        translateView.targetTextView
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.input.onToTranslate)
            .disposed(by: disposeBag)

        translateView.toTranslateButton
            .rx
            .tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.onSendAction)
            .disposed(by: disposeBag)

        translateView.targetSegmentControl
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
        .drive(translateView.translationTextView.rx.text)
        .disposed(by: disposeBag)
     }
    
    // MARK: - Internal setting
    
    private func internalSettingUI() {        
        translateView.targetTextView
            .rx
            .text
            .subscribe(onNext: { text in
                guard let text = text else { return }
                if text.contains("\n") {
                    self.translateView.targetTextView.text.removeLast()
                    self.translateView.targetTextView.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
    }
    
}
