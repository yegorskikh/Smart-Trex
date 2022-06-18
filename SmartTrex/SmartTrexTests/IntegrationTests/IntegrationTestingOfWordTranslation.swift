//
//  IntegrationTestingOfWordTranslation.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 18.06.2022.
//

import Foundation
import XCTest
import RxTest
import RxBlocking
import RxSwift
@testable import SmartTrex

class IntegrationTestingOfWordTranslation: XCTestCase {
    
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    
    var viewModel: TranslateViewModel!
    var interactor: TranslateInteractor!
    var networking: GoogleTranslationService!
    var storage: WordStoreService!
    
    var urlProtocolMock: URLProtocolMock!
    var coreDataStackMock: CoreDataStackMock!
    
    override func setUp() {
        super.setUp()
        
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        
        // setup networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        urlProtocolMock = URLProtocolMock()
        
        networking = GoogleTranslationService(
            urlConfiguration: configuration
        )
        
        // setup store
        coreDataStackMock = CoreDataStackMock()
        storage = WordStoreService(
            managedObjectContext: coreDataStackMock.mainContext,
            coreDataStack: coreDataStackMock
        )
        
        // setup interactor
        interactor = TranslateInteractor(
            storage: storage,
            serviceTranslate: networking
        )
        
        // setup viewModel
        viewModel = TranslateViewModel(
            interactor: interactor
        )
        
    }
    
    override func tearDown() {
        disposeBag = nil
        scheduler = nil
        
        viewModel = nil
        interactor = nil
        networking = nil
        storage = nil
        
        urlProtocolMock = nil
        coreDataStackMock = nil
        super.tearDown()
    }
    
    func test_success_to_translate() {
        // given
        let responseData = TranslateResponseData(
            data: .init(translations: [.init(translatedText: "Qux")])
        )
        let responseJsonData = try! JSONEncoder().encode(responseData)
        urlProtocolMock.setupMock(statusCode: 200, responseData: responseJsonData)
        
        let tappedToTranslate = scheduler.createObserver(Void.self)
        let textToTranslate = scheduler.createObserver(String.self)
        let targetToTranslate = scheduler.createObserver(String.self)
        
        viewModel.sendAction
            .subscribe(tappedToTranslate)
            .disposed(by: disposeBag)
        
        viewModel.textToTranslate
            .subscribe(textToTranslate)
            .disposed(by: disposeBag)
        
        viewModel.targetToTranslate
            .subscribe(targetToTranslate)
            .disposed(by: disposeBag)
        
        // when
        scheduler.createColdObservable([.next(9, "Foo")])
            .bind(to: viewModel.input.onToTranslate)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(9, "en")])
            .bind(to: viewModel.input.onTarget)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(10, ())])
            .bind(to: viewModel.input.onSendAction)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let ex = expectation(description: "G")
        
        viewModel
            .output
            .onTranslate
            .drive(
                onNext: { event in
                    // then
                    XCTAssertEqual(event, "Qux")
                    ex.fulfill()
                }
            )
            .disposed(by: disposeBag)
        
        wait(for: [ex], timeout: 5)
    }
    
    func test_failed_to_translate() {
        // given
        let responseData = TranslateResponseData(
            data: nil
        )
        let responseJsonData = try! JSONEncoder().encode(responseData)
        urlProtocolMock.setupMock(statusCode: 400, responseData: responseJsonData)
        
        let tappedToTranslate = scheduler.createObserver(Void.self)
        let textToTranslate = scheduler.createObserver(String.self)
        let targetToTranslate = scheduler.createObserver(String.self)
        
        viewModel.sendAction
            .subscribe(tappedToTranslate)
            .disposed(by: disposeBag)
        
        viewModel.textToTranslate
            .subscribe(textToTranslate)
            .disposed(by: disposeBag)
        
        viewModel.targetToTranslate
            .subscribe(targetToTranslate)
            .disposed(by: disposeBag)
        
        // when
        scheduler.createColdObservable([.next(9, "Foo")])
            .bind(to: viewModel.input.onToTranslate)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(9, "en")])
            .bind(to: viewModel.input.onTarget)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(10, ())])
            .bind(to: viewModel.input.onSendAction)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let ex = expectation(description: "G")
        
        viewModel
            .output
            .onError
            .drive(
                onNext: { error in
                    XCTAssertNotNil(error)
                    ex.fulfill()
                }
            )
            .disposed(by: disposeBag)
        
        wait(for: [ex], timeout: 5)
    }
    
}
