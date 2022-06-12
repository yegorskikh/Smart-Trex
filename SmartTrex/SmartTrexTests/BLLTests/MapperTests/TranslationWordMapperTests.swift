//
//  TranslationWordMapperTests.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 08.06.2022.
//

import Foundation
import XCTest
@testable import SmartTrex
import CoreData
import RxSwift
import RxCocoa

class TranslationWordMapperTests: XCTestCase {
    
    var sut: TranslationWordMapperable!
    var serviceStore: TranslateStoragable!
    var coreDataStackMock: CoreDataStackMock!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        sut = TranslationWordMapper()
        coreDataStackMock = CoreDataStackMock()
        serviceStore = WordStoreService(managedObjectContext: coreDataStackMock.mainContext,
                                        coreDataStack: coreDataStackMock)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        coreDataStackMock = nil
        sut = nil
        serviceStore = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func test_mapping_for_presenter() {
        // given && when
        let savedModel = serviceStore.saveToStorage(original: "Foo", translation: "Bar")
        let expectedModel = TranslationWordPresentation(uuid: savedModel!.uuid!,
                                                        original: "Foo",
                                                        translation: "Bar")
        
        // when
        serviceStore
            .getDataFromStorage()
            .subscribe(
                onSuccess: { models in
                    // then
                    XCTAssertEqual(models.first!.original, expectedModel.original)
                }
            )
            .disposed(by: disposeBag)
        
    }
    
    func test_mapping_for_presenter_with_nil_property() {
        // given
        let _ = TranslationWord(context: coreDataStackMock.mainContext)
        let expectedCountArray = 0
        
        // when
        serviceStore
            .getDataFromStorage()
            .subscribe(
                // when
                onSuccess: { [weak self] words in
                    let models = self?.sut.toPresentationLayer(from: words)
                    XCTAssertEqual(models!.count, expectedCountArray)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func test_mapping_for_dal() {
        // given
        let expectedUuid = UUID()
        let model = TranslationWordPresentation(uuid: expectedUuid,
                                                original: "Foo",
                                                translation: "Baz")
        
        // when
        let uuid = sut.toDataLayer(from: model)
        
        // then
        XCTAssertEqual(expectedUuid, uuid)
    }
    
}
