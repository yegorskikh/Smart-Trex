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
    
    private let disposeBag = DisposeBag()
    var viewModel: RootViewModel!
    
    @IBOutlet weak var booksButton: UIButton!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBinding()
    }
    
    private func initBinding() {
        // MARK: - Input to View Model
        booksButton
            .rx
            .tap
            .bind(to: viewModel.input.onSendActionBooks)
            .disposed(by: disposeBag)
        
        translateButton
            .rx
            .tap
            .bind(to: viewModel.input.onSendActionTranslate)
            .disposed(by: disposeBag)
        
        historyButton
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
