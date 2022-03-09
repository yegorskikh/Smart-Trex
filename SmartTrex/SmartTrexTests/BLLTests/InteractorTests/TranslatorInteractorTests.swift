//
//  TranslatorInteractorTests.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 27.02.2022.
//

import Foundation
import XCTest
@testable import SmartTrex

class TranslatorInteractorTests: XCTestCase {
    
    var sut: TranslateInteractorable!
    var storeMock: StoreMock!
    var translationNetworkMock: TranslationNetworkMock!
    
    override func setUp() {
        super.setUp()
        storeMock = StoreMock()
        translationNetworkMock = TranslationNetworkMock()
        sut = TranslateInteractor()
        sut.serviceTranslate = translationNetworkMock
        sut.serviceStorage = storeMock
    }
    
    override func tearDown() {
        sut = nil
        storeMock = nil
        translationNetworkMock = nil
        super.tearDown()
    }
    
    func test_success_save_after_translation() {
        // given
        let expectation = XCTestExpectation(description: "successful")
        translationNetworkMock.responseType = .success
        
        // when
        sut.translateAndSaveToStore(text: "Bar", target: "Foo") { [weak self] translation, error in
            
            // than
            XCTAssertEqual(translation, "Baz")
            XCTAssertEqual(true, self?.storeMock.saveToStorageWasCalled)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_failed_save_after_translation() {
        // given
        let expectation = XCTestExpectation(description: "failed")
        translationNetworkMock.responseType = .failed
        
        // when
        sut.translateAndSaveToStore(text: "Bar", target: "Foo") { [weak self] translation, error in
            
            // than
            XCTAssertEqual(error, "Foo")
            XCTAssertEqual(false, self?.storeMock.saveToStorageWasCalled)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
}
