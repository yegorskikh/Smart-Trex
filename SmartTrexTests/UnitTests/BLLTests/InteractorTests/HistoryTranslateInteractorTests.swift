//
//  HistoryTranslateInteractorTests.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 08.03.2022.
//

import Foundation
import XCTest
@testable import SmartTrex
import RxSwift

class HistoryTranslateInteractorTests: XCTestCase {
    
    var sut: HistoryTranslateInteractorable!
    var storeMock: StoreMock!
    var mapperMock: TranslationWordMapperMock!
    let disposBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        storeMock = StoreMock()
        mapperMock = TranslationWordMapperMock()
        sut = HistoryTranslateInteractor(
            storage: storeMock, mapper: mapperMock
        )
    }
    
    override func tearDown() {
        sut = nil
        storeMock = nil
        mapperMock = nil
        super.tearDown()
    }
    
    func test_successful_retrieval_of_saved_translations() {
        // when
        sut.getData()
            .subscribe(
                onNext: { [unowned self] data in
                    // then
                    XCTAssertEqual(self.storeMock.getDataFromStorageWasCalled, true)
                },
                onError: {_ in
                    XCTFail()
                }
            )
            .disposed(by: disposBag)
    }
    
    func test_failed_retrieval_of_saved_translations() {
        // given
        storeMock.responseType = .failed
        
        // when
        sut.getData()
            .subscribe(
                onNext: { data in
                    XCTFail()
                },
                onError: {
                    // then
                   XCTAssertNotNil($0)
                }
            )
            .disposed(by: disposBag)
    }
    
    func test_successful_deletion_of_a_word_from_storage() {
        sut.remove(
            TranslationWordPresentation(uuid: UUID(), original: "Foo", translation: "Bar")
        )
        XCTAssertEqual(self.storeMock.removeFromStorageWasCalled, true)
    }
    
}
