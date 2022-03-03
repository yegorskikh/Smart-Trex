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
    
    func test_success() {
        // given
        let expectation = XCTestExpectation(description: "successful")
        translationNetworkMock.responseType = .success
        
        // when
        sut.translateAndSaveToStore(text: "Bar", target: .en) { [weak self] translation, error in
            // than
            XCTAssertEqual(translation, "Baz")
            XCTAssertEqual(true, self?.storeMock.wasCalled)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_failer() {
        // given
        let expectation = XCTestExpectation(description: "failed")
        translationNetworkMock.responseType = .failed
        
        // when
        sut.translateAndSaveToStore(text: "Bar", target: .en) { [weak self] translation, error in
            // than
            XCTAssertEqual(error, "Foo")
            XCTAssertEqual(false, self?.storeMock.wasCalled)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
}
