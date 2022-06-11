//
//  TranslatorInteractorTests.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 27.02.2022.
//

import Foundation
import XCTest
@testable import SmartTrex
import RxSwift

class TranslatorInteractorTests: XCTestCase {
    
    var sut: TranslateInteractorable!
    var storeMock: StoreMock!
    var translationNetworkMock: TranslationNetworkMock!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        storeMock = StoreMock()
        translationNetworkMock = TranslationNetworkMock()
        sut = TranslateInteractor(
            storage: storeMock,
            serviceTranslate: translationNetworkMock
        )
//        sut.serviceTranslate = translationNetworkMock
//        sut.serviceStorage = storeMock
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        sut = nil
        storeMock = nil
        translationNetworkMock = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func test_success_translation_and_save() {
        //  let expectation = XCTestExpectation(description: "successful")
        
        translationNetworkMock.responseType = .success
        sut
            .translateAndSaveToStore(text: "Bar", target: "Foo")
            .subscribe(
                onNext: {
                    XCTAssertEqual($0, "Baz")
                    
                },
                onError: {_ in
                    XCTFail()
                }, onCompleted: {
                    print("onCompleted")
                }, onDisposed: {
                    print("onDisposed")
                })
            .disposed(by: disposeBag)
        
        XCTAssertEqual(true, self.storeMock.saveToStorageWasCalled)
    }
    
    func test_failed_translation_and_save() {
        translationNetworkMock.responseType = .failed
        sut
            .translateAndSaveToStore(text: "Bar", target: "Foo")
            .subscribe(
                onNext: {_ in
                    XCTFail()
                },
                onError: {
                    XCTAssertNotNil($0)
                })
            .disposed(by: disposeBag)
        
        XCTAssertEqual(false, self.storeMock.saveToStorageWasCalled)
    }
    
}
