//
//  HistoryTranslatePresenterTests.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 09.03.2022.
//

import Foundation
import XCTest
@testable import SmartTrex

class HistoryTranslatePresenterTests: XCTestCase {
    
    var sut: HistoryTranslatePresenter!
    var interactorMock: HistoryTranslateInteractorMock!
    
    override func setUp() {
        super.setUp()
        interactorMock = HistoryTranslateInteractorMock()
        sut = HistoryTranslatePresenter()
        
        sut.interactor = interactorMock
    }
    
    override func tearDown() {
        sut = nil
        interactorMock = nil
        super.tearDown()
    }
    
    func test_getting_data_from_the_interactor() {
        // when
        sut.getArrayOfTranslatedWords()
        
        // then
        XCTAssertEqual(interactorMock.getDataWasCalled, true)
    }
    
    func test_delete_from_database() {
        // when
        sut.removeElement(translation: TranslationWord())
        
        // then
        XCTAssertEqual(interactorMock.removeElementWasCalled, true)
    }
    
    func test_counting_array_of_stored_words() {
        // when
        sut.getArrayOfTranslatedWords()
        let count = sut.numberOfRowsInSection()
        
        // then
        XCTAssertEqual(count > 0, true)
    }

}
