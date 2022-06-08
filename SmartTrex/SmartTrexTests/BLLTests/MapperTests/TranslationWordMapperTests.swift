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

class TranslationWordMapperTests: XCTestCase {
    
    var sut: TranslationWordMapperable!
    var serviceStore: TranslateStoragable!
    var coreDataStackMock: CoreDataStackMock!
    
    override func setUp() {
        super.setUp()
        sut = TranslationWordMapper()
        coreDataStackMock = CoreDataStackMock()
        serviceStore = WordStoreService(managedObjectContext: coreDataStackMock.mainContext,
                                        coreDataStack: coreDataStackMock)
    }
    
    override func tearDown() {
        coreDataStackMock = nil
        sut = nil
        super.tearDown()
    }
    
    func test_mapping_for_presenter() {
        // given
        let expectation = expectation(description: "mapping")
        var givenModels = [TranslationWord]()
        
        //when
        let savedModel = serviceStore.saveToStorage(original: "Foo", translation: "Bar")
        let expectedModel = TranslationWordPresentation(uuid: savedModel!.uuid!,
                                                        original: "Foo",
                                                        translation: "Bar")
        
        serviceStore.getDataFromStorage { [weak self] models in
            givenModels = models
            let result = self!.sut.toPresentationLayer(from: givenModels)
            
            // then
            XCTAssertEqual(result.first!, expectedModel)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
    }
    
    func test_mapping_for_presenter_with_nil_property() {
        // given
        let expectation = expectation(description: "mapping nil")
        let _ = TranslationWord(context: coreDataStackMock.mainContext)
        var expectedArray = [TranslationWordPresentation]()
        let expectedCountArray = 0
        
        // when
        serviceStore.getDataFromStorage { [weak self] models in
            expectedArray = self!.sut!.toPresentationLayer(from: models)
            
            // then
            XCTAssertEqual(expectedArray.count, expectedCountArray)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
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
