//
//  TranslatePresenterTests.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 01.03.2022.
//

import Foundation
import XCTest
@testable import SmartTrex

class TranslateViewModelTests: XCTestCase {
    
    var sut: TranslateViewModel!
    var interactorMock: TranslateInteractorMock!
    var viewMock: TranslateVcMock!
    
    override func setUp() {
        super.setUp()
        interactorMock = TranslateInteractorMock()

        sut = TranslateViewModel()
        sut.interactor = interactorMock
    }
    
    override func tearDown() {
        sut = nil
        interactorMock = nil
        super.tearDown()
    }
    
    func test_success_translate() {
        //        // given
        //        interactorMock.typeResponse = .succes
        //
        //        // when
        //        sut.translate()
        //
        //        // then
        //        XCTAssertEqual(interactorMock.wasCalled, true)
        //        XCTAssertEqual(viewMock.setTranslationTextWasCalled, true)
    }
    
    func test_faild_translate() {
        //        // given
        //        interactorMock.typeResponse = .error
        //
        //        // when
        //        sut.translate()
        //
        //        // then
        //        XCTAssertEqual(interactorMock.wasCalled, true)
        //        XCTAssertEqual(viewMock.showAlertWasCalled, true)
    }
    
}
