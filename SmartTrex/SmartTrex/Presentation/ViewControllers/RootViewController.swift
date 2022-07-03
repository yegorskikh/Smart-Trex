//
//  MainVC.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 07.03.2022.
//

import UIKit
import RxSwift
import RxCocoa

class RootViewController: UIViewController {
    
    // MARK: - Property
    
    private let rootView = RootView()
    private let disposeBag = DisposeBag()
    private let viewModel: RootViewModel
    
    // MARK: - Lifecycle object
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.initBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle ViewController
    
    override func loadView() {
        view = rootView
    }
        
    private func initBinding() {
        // MARK: - Input to View Model
        rootView.booksButton
            .rx
            .tap
            .bind(to: viewModel.input.onSendActionBooks)
            .disposed(by: disposeBag)
        
        rootView.translateButton
            .rx
            .tap
            .bind(to: viewModel.input.onSendActionTranslate)
            .disposed(by: disposeBag)
        
        rootView.historyButton
            .rx
            .tap
            .bind(to: viewModel.input.onSendActionHistory)
            .disposed(by: disposeBag)
        
        // MARK: - Output ViewModel
        viewModel
            .output
            .onShowError
            .drive(self.rx.showAlert)
            .disposed(by: disposeBag)
        
        viewModel
            .output
            .onPushViewController
            .drive(self.rx.pushViewController)
            .disposed(by: disposeBag)
    }
    
}
