//
//  TranslateView.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 02.07.2022.
//

import UIKit

final class TranslateView: UIView {

    // MARK: - UI
    
    lazy var targetTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    lazy var targetSegmentControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: - Take out of here
        segmentedControl.insertSegment(withTitle: "en", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "ru", at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        
        return segmentedControl
    }()

    lazy var translationTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.isEditable = false
        textView.layer.cornerRadius = 5
        return textView
    }()

    lazy var toTranslateButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule
        configuration.title = "To Translate"
        
        let button = UIButton()
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
        backgroundColor = .systemPink
        addSubview(targetTextView)
        addSubview(targetSegmentControl)
        addSubview(translationTextView)
        addSubview(toTranslateButton)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            targetTextView.heightAnchor.constraint(equalToConstant: 150.0),
            targetTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            targetTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            targetTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0),

            targetSegmentControl.topAnchor.constraint(equalTo: targetTextView.bottomAnchor, constant: 20.0),
            targetSegmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            targetSegmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),

            translationTextView.topAnchor.constraint(equalTo: targetSegmentControl.bottomAnchor, constant: 20.0),
            translationTextView.heightAnchor.constraint(equalToConstant: 150.0),
            translationTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            translationTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),

            toTranslateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
            toTranslateButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            toTranslateButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0)
        ])
    }
    
}
