//
//  HistoryTranslateVC.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 07.03.2022.
//

import UIKit
import RxSwift

class HistoryTranslateViewController: UIViewController {
    
    // MARK: - Property
    
    private let htView = HistoryTranslateView()
    private let disposeBag = DisposeBag()
    private var viewModel: HistoryTranslateViewModel
    
    // MARK: - Lifecycle object
    
    init(viewModel: HistoryTranslateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.inputToViewModelBindings()
        self.outputViewModelBindings()
        self.internalSettingUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle ViewController
    
    override func loadView() {
        view = htView
    }
    
    // MARK: - Input to ViewModel
    
    private func inputToViewModelBindings() {
        self.rx
            .sentMessage(#selector(self.viewWillAppear(_:)))
            .map { _ in }
            .bind(to: viewModel.input.viewControllerDidLoadView)
            .disposed(by: disposeBag)
        
        htView.tableView
            .rx
            .itemDeleted
            .bind(to: viewModel.input.indexPathToDel)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Output ViewModel
    
    private func outputViewModelBindings() {
        viewModel
            .output
            .onTranslationWords
            .asObservable()
            .bind(
                to: htView.tableView.rx.items(
                    cellIdentifier: HistoryTranslateCell.reuseIdentifier,
                    cellType: HistoryTranslateCell.self)
            ) { index, model, cell in
                cell.setupCell(
                    original: model.original,
                    translation: model.translation
                )
            }
            .disposed(by: disposeBag)
        
        viewModel
            .output
            .onError
            .drive(self.rx.showAlert)
            .disposed(by: disposeBag)
    }
    
    private func internalSettingUI() {
        htView.tableView
            .rx
            .itemSelected
            .subscribe(
                onNext: { indexPath in
                    self.htView.tableView.deselectRow(at: indexPath, animated: true)
                }
            )
            .disposed(by: disposeBag)
    }
    
}

