//
//  HistoryTranslateCell.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 07.03.2022.
//

import UIKit

final class HistoryTranslateCell: UITableViewCell {
    
    // MARK: - Property
    
    static let reuseIdentifier = "HistoryTranslateCell"
    
    // MARK: - UI
    
    lazy var originalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var translationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: - Internal method
    
    func setupCell(original: String, translation: String) {
        originalLabel.text = original
        translationLabel.text = translation
    }
    
    // MARK: - Private method
    
    private func setupViews() {
        layer.cornerRadius = 45
        addSubview(originalLabel)
        addSubview(translationLabel)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
        originalLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 10.0),
        originalLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10.0),
        originalLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -10.0),
        
        translationLabel.leadingAnchor.constraint(greaterThanOrEqualTo: originalLabel.trailingAnchor),
        
        translationLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -10.0),
        translationLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10.0),
        translationLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -10.0),
        ])
    }
    
}
