//
//  HistoryTranslateView.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 28.06.2022.
//

import UIKit

final class HistoryTranslateView: UIView {
    
    // MARK: - UI
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HistoryTranslateCell.self, forCellReuseIdentifier: HistoryTranslateCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 90.0
        return tableView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private method
    
    private func setupViews() {
        addSubview(tableView)
        backgroundColor = .green
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10.0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
        ])
    }
    
}
