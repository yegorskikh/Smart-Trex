//
//  TranslatePresenterTests.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 01.03.2022.
//

import Foundation
import XCTest
@testable import SmartTrex

class TranslatePresenterTests: XCTestCase {
    
    var sut: TranslationPresentable!
    var interactorMock: TranslateInteractorMock!
    var viewMock: TranslateVcMock!
    
    override func setUp() {
        super.setUp()
        interactorMock = TranslateInteractorMock()
        viewMock = TranslateVcMock()
        sut = TranslationPresenter()
        
        sut.interactor = interactorMock
        sut.view = viewMock
    }
    
    override func tearDown() {
        sut = nil
        interactorMock = nil
        viewMock = nil
        super.tearDown()
    }
    
    func test_success_translate() {
        // given
        interactorMock.typeResponse = .succes
        
        // when
        sut.translate()
        
        // then
        XCTAssertEqual(interactorMock.wasCalled, true)
        XCTAssertEqual(viewMock.label.text?.isEmpty, false)
    }
    
    func test_faild_translate() {
        // given
        interactorMock.typeResponse = .error
        
        // when
        sut.translate()
        
        // then
        XCTAssertEqual(interactorMock.wasCalled, true)
        XCTAssertEqual(viewMock.showAlertWasCalled, true)
    }
    
}
