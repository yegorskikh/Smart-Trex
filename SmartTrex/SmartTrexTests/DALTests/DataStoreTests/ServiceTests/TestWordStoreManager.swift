//
//  TestWordStoreManager.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 30.01.2022.
//


import XCTest
import CoreData
@testable import SmartTrex


class TestWordStoreManager: XCTestCase {
    
    var wordService: WordStoreService!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack = coreDataStackMock()
        wordService = WordStoreService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        coreDataStack = nil
        wordService = nil
        super.tearDown()
    }
    
    func test_fetch_from_storage() {
        // given
        let countDataArray = 1
        let expectation = expectation(description: "Fetch")
        
        // when
        let _ = wordService.saveToStorage(original: "Foo", translation: "Baz")
        wordService.getDataFromStorage { data in
            XCTAssertEqual(data.count, countDataArray)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    
    func test_removed_from_storage() {
        // given
        let expectation = expectation(description: "Removed")
        let countDataArray = 1
        
        // when
        let _ = wordService.saveToStorage(original: "Bar", translation: "Foo")
        let secondWord = wordService.saveToStorage(original: "Foo", translation: "Baz")
        wordService.removeFromStorage(translation: secondWord!)
        
        wordService.getDataFromStorage { data in
            // then
            XCTAssertEqual(data.count, countDataArray)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
    }
    
    func test_save_to_storage() {
        // when
        let word = wordService.saveToStorage(original: "Foo", translation: "Baz")
        
        // then
        XCTAssertNotNil(word)
        XCTAssertTrue(word?.original == "Foo")
        XCTAssertTrue(word?.translation == "Baz")
    }
    
    func test_root_context_in_saved_after_adding_word() {
        // when
        let derivedContext = coreDataStack.newDerivedContext()
        wordService = WordStoreService(managedObjectContext: derivedContext,
                                       coreDataStack: coreDataStack)
        
        expectation(forNotification: .NSManagedObjectContextDidSave,
                    object: coreDataStack.mainContext) { _ in
            return true
        }
        
        derivedContext.perform {
            let camper = self.wordService.saveToStorage(original: "Foo", translation: "Baz")
            // then
            XCTAssertNotNil(camper)
        }
        
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    
}
