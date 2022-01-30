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
    
    // MARK: Property
    var wordService: WordStoreManager!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        
        coreDataStack = MockCoreDataTests()
        wordService = WordStoreManager(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        
        coreDataStack = nil
        wordService = nil
    }
    
    func test_fetch_data() {
        // given
        let countDataArray = 1
        let expectation = expectation(description: "")
        
        // when
        let _ = wordService.saveData(word: "Foo", translation: "Baz")
        wordService.fetchArrayData { data in
            XCTAssertEqual(data.count, countDataArray)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    
    func test_delete_data() {
        // given
        let expectation = expectation(description: "")
        let countDataArray = 1
        
        // when
        let _ = wordService.saveData(word: "Bar", translation: "Foo")
        let secondWord = wordService.saveData(word: "Foo", translation: "Baz")
        wordService.delete(word: secondWord!)
        
        wordService.fetchArrayData { data in
            // then
            XCTAssertEqual(data.count, countDataArray)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
    }
    
    func test_save_to_store() {
        // when
        let word = wordService.saveData(word: "Foo", translation: "Baz")
        
        // then
        XCTAssertNotNil(word)
        XCTAssertTrue(word?.original == "Foo")
        XCTAssertTrue(word?.translation == "Baz")
    }
    
    func test_root_context_in_saved_after_adding_word() {
        // when
        let derivedContext = coreDataStack.newDerivedContext()
        wordService = WordStoreManager(managedObjectContext: derivedContext,
                                       coreDataStack: coreDataStack)
        
        expectation(forNotification: .NSManagedObjectContextDidSave,
                    object: coreDataStack.mainContext) { _ in
            return true
        }
        
        derivedContext.perform {
            let camper = self.wordService.saveData(word: "Foo", translation: "Baz")
            // then
            XCTAssertNotNil(camper)
        }
        
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    

    
}
