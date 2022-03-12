//
//  HistoryTranslateVC.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 07.03.2022.
//

import UIKit

class HistoryTranslateVC: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    // MARK: - Property
    
    var presenter: HistoryTranslatePresentable!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getArrayOfTranslatedWords()
    }
    
    func setupTableView() {
        historyTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.rowHeight = 85
    }

}

extension HistoryTranslateVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTranslateCell.reuseIdentifier,
                                                         for: indexPath) as! HistoryTranslateCell

        guard
            let word = presenter?.translatedWordsArray[indexPath.row]
        else {
            return cell
        }
        cell.setupCell(original: word.original ?? "",
                       translation: word.translation ?? "")
        return cell
    }
    
}

extension HistoryTranslateVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard
            let removeElement = presenter?.translatedWordsArray[indexPath.row]
        else {
            return
        }
        presenter.removeElement(translation: removeElement)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    
}