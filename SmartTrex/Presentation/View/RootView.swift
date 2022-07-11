//
//  RootView.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 03.07.2022.
//

import UIKit

class RootView: UIView {
    
    lazy var booksButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule
        configuration.title = "books"
        
        let button = UIButton()
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var translateButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule
        configuration.title = "translate"
        
        let button = UIButton()
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var historyButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule
        configuration.title = "history"
        
        let button = UIButton()
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [booksButton,
                                                       translateButton,
                                                       historyButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        backgroundColor = .lightGray
        addSubview(stackView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
}
