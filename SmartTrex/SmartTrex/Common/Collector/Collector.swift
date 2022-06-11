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
        let responseModel = TranslateResponseData(data: .init(translations: [.init(translatedText: "Yep")]))
        let responseJsonData = try! JSONEncoder().encode(responseModel)
        
        let mock: URLMock = URLMock()
        mock.setupMock(statusCode: 200, responseData: responseJsonData)
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLMock.self]
        
        // assembly
        let service = GoogleTranslationService(urlConfiguration: configuration)
      //  let service = GoogleTranslationService()
        let coreDataStack = CoreDataStack()
        let mapper = TranslationWordMapper()
        let storage = WordStoreService(managedObjectContext: coreDataStack.mainContext,
                                       coreDataStack: coreDataStack,
                                       mapper: mapper)
        
        let interactor = TranslateInteractor()
        interactor.serviceStorage = storage
        interactor.serviceTranslate = service
        
        let storyboard = UIStoryboard(name: "Translate", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "TranslateVC") as! TranslateVC
        
        let presenter = TranslatePresenter()
        presenter.interactor = interactor
        presenter.view = view
        
        view.presenter = presenter
        
        return view
    }
    
}

class HistoryTranslateCollectorFactory: CollectorModuleFactory {
    
    func getModule() -> UIViewController {
        let coreDataStack = CoreDataStack()
        let mapper = TranslationWordMapper()
        
        let storage = WordStoreService(managedObjectContext: coreDataStack.mainContext,
                                       coreDataStack: coreDataStack,
                                       mapper: mapper)
        
        let interactor = HistoryTranslateInteractor()
        interactor.storage = storage
        
        let presenter = HistoryTranslatePresenter()
        presenter.interactor = interactor
        
        let storyboard = UIStoryboard(name: "Translate", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HistoryTranslateVC") as! HistoryTranslateVC
        vc.presenter = presenter
        
        return vc
    }
    
}