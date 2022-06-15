//
//  HistoryTranslateVC.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 07.03.2022.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryTranslateVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var historyTableView: UITableView!
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    // TODO: - ! after getting rid of the storyboard, put it in init and make it private
    var viewModel: HistoryTranslateViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func initBindings() {
        // Input to ViewModel
        self.rx
            .sentMessage(#selector(self.viewWillAppear(_:)))
            .map { _ in }
            .bind(to: viewModel.input.viewControllerDidLoadView)
            .disposed(by: disposeBag)
        
        historyTableView
            .rx
            .itemDeleted
            .bind(to: viewModel.input.indexPathToDel)
            .disposed(by: disposeBag)
        
        // Output ViewModel
        viewModel
            .output
            .onTranslationWords
            .asObservable()
            .bind(to: historyTableView.rx.items(cellIdentifier: HistoryTranslateCell.reuseIdentifier,
                                                cellType: HistoryTranslateCell.self) ) { index, model, cell in
                cell.setupCell(original: model.original, translation: model.translation)
            }
            .disposed(by: disposeBag)
        
        viewModel
            .output
            .onError
            .drive(self.rx.showAlert)
            .disposed(by: disposeBag)
    }
    
}

