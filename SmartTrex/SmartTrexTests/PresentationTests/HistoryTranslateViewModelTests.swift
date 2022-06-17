//
//  HistoryTranslatePresenterTests.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 09.03.2022.
//

import Foundation
import XCTest
@testable import SmartTrex
import RxBlocking
import RxSwift
import RxTest

class HistoryTranslateViewModelTests: XCTestCase {
    
    var sut: HistoryTranslateViewModel!
    var interactorMock: HistoryTranslateInteractorMock!
    
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        interactorMock = HistoryTranslateInteractorMock()
        sut = HistoryTranslateViewModel(
            interactor: interactorMock
        )
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        sut = nil
        interactorMock = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func test_success_getting_data_from_the_interactor() {
        
    }
    
    func test_failed_getting_data_from_the_interactor() {
        
    }
    
    //    func test_getting_data_from_the_interactor() {
    //        // when
    //        sut.getArrayOfTranslatedWords()
    //
    //        // then
    //        XCTAssertEqual(interactorMock.getDataWasCalled, true)
    //    }
    //
    //    func test_delete_from_database() {
    //        // when
    //        sut.removeElement(uuid: UUID())
    //
    //        // then
    //        XCTAssertEqual(interactorMock.removeElementWasCalled, true)
    //    }
    //
    //    func test_counting_array_of_stored_words() {
    //        // when
    //        sut.getArrayOfTranslatedWords()
    //        let count = sut.numberOfRowsInSection()
    //
    //        // then
    //        XCTAssertEqual(count == 0, true)
    //    }
    
}
