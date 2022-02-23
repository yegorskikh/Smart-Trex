//
//  TestVC.swift
//  Smart Trex
//
//  Created by Yegor Gorskikh on 25.01.2022.
//

import UIKit

class TestVC: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    var interactor: TranslatorInteractor!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setDI()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        translate(text: textField.text!)
    }
    
    // MARK: - Private
    
    private func setupViews() {
        textField.delegate = self
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.green.cgColor
        textField.layer.cornerRadius = 10.0
        textField.clipsToBounds = true
    }
    
    private func translate(text: String) {
        interactor.translateAndSaveToStore(text: textField.text!) { i in
            self.label.text = i
        }
    }
    
    private func setDI() {
        // URLMock
        let mock: URLMock = URLMock()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLMock.self]
        
        let service = GoogleTranslationService(urlConfiguration: configuration)
        
        let expected = TranslationResponeData(data: TranslationResponseModel(translations:
                                                                                [WordResponseModel(translatedText: "Перевод")]))
        let responseJsonData = try! JSONEncoder().encode(expected)
        mock.setupMock(statusCode: 400, responseData: responseJsonData)
        
        let coreDataStack = CoreDataStack()
        let storage = WordStoreService(managedObjectContext: coreDataStack.mainContext,
                                       coreDataStack: coreDataStack)
        
        interactor = TranslatorInteractor(storage: storage, translate: service)
    }
    
}

extension TestVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
