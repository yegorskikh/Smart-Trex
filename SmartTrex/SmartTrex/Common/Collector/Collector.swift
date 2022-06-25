//
//  Collector.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 03.03.2022.
//

import UIKit

protocol CollectorModuleFactory {
    func getModule() -> UIViewController
}

class TranslateCollectorFactory: CollectorModuleFactory {
    
    func getModule() -> UIViewController {
        
        // mock
        let responseModel = TranslateResponseData(
            data: .init(translations: [.init(translatedText: "Foo Bar Baz Qux")])
        )
        let responseJsonData = try! JSONEncoder().encode(responseModel)
        
        let mock: URLMock = URLMock()
        mock.setupMock(statusCode: 200, responseData: responseJsonData)
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLMock.self]
        
        // assembly
        let service = GoogleTranslationService(urlConfiguration: configuration)
        //let service = GoogleTranslationService()
        let coreDataStack = CoreDataStack()
        
        let storage = WordStoreService(
            managedObjectContext: coreDataStack.mainContext,
            coreDataStack: coreDataStack
        )
        
        let interactor = TranslateInteractor(
            storage: storage,
            serviceTranslate: service
        )
        
        let storyboard = UIStoryboard(name: "Translate", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "TranslateVC") as! TranslateViewController
        
        let viewModel = TranslateViewModel(
            interactor: interactor
        )
        
        view.viewModel = viewModel
        
        return view
    }
    
}

class HistoryTranslateCollectorFactory: CollectorModuleFactory {
    
    func getModule() -> UIViewController {
        let coreDataStack = CoreDataStack()
        
        let mapper = TranslationWordMapper()
        let storage = WordStoreService(
            managedObjectContext: coreDataStack.mainContext,
            coreDataStack: coreDataStack
        )
        
        let interactor = HistoryTranslateInteractor(
            storage: storage,
            mapper: mapper
        )
        
        let presenter = HistoryTranslateViewModel(
            interactor: interactor
        )
        
        let storyboard = UIStoryboard(name: "Translate", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HistoryTranslateVC") as! HistoryTranslateViewController
        vc.viewModel = presenter
        
        return vc
    }
    
}
