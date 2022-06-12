//
//  HistoryTranslateInteractorTests.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 08.03.2022.
//

import Foundation
import XCTest
@testable import SmartTrex

class HistoryTranslateInteractorTests: XCTestCase {
    
    var sut: HistoryTranslateInteractorable!
    var storeMock: StoreMock!
    
    override func setUp() {
        super.setUp()
        storeMock = StoreMock()
        sut = HistoryTranslateInteractor()
        sut.storage = storeMock
    }
    
    override func tearDown() {
        sut = nil
        storeMock = nil
        super.tearDown()
    }
    
    func test_successful_retrieval_of_saved_translations() {
        let expectation = XCTestExpectation(description: "Get data from storage")
        
        sut.getData(completion: { array in
            XCTAssertEqual(self.storeMock.getDataFromStorageWasCalled, true)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_successful_deletion_of_a_word_from_storage() {
        sut.removeElement(uuid: UUID())
        XCTAssertEqual(self.storeMock.removeFromStorageWasCalled, true)
    }
    
}
