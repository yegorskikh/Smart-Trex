//
//  TestWordStoreManager.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 30.01.2022.
//


import XCTest
import CoreData
@testable import SmartTrex
import RxCocoa
import RxSwift


class TestWordStoreManager: XCTestCase {
    
    var wordService: WordStoreService!
    var coreDataStack: CoreDataStackMock!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataStackMock()
        wordService = WordStoreService(managedObjectContext: coreDataStack.mainContext,
                                       coreDataStack: coreDataStack)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        coreDataStack = nil
        wordService = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func test_fetch_from_storage() {
        // given
        let countDataArray = 1
        
        let _ = wordService.saveToStorage(original: "Foo", translation: "Baz")
        
        // when
        wordService.getDataFromStorage()
            .subscribe(
                onSuccess: {
                    // then
                    XCTAssertEqual($0.count, countDataArray)
                },
                onFailure: {_ in
                    XCTFail()
                })
            .disposed(by: disposeBag)
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
    
    func test_removed_by_uuid_successful() {
        // given
        let countDataArray = 1
        
        // when
        let _ = wordService.saveToStorage(original: "Bar", translation: "Foo")
        let secondWord = wordService.saveToStorage(original: "Foo", translation: "Baz")
        wordService.removeFromStorage(by: secondWord!.uuid!)
        
        wordService.getDataFromStorage()
            .subscribe(
                onSuccess: {
                    // then
                    XCTAssertEqual($0.count, countDataArray)
                },
                onFailure: {_ in
                    XCTFail()
                })
            .disposed(by: disposeBag)
    }
    
    func test_removed_by_uuid_failure() {
        // given
        let countDataArray = 1
        
        // when
        wordService.saveToStorage(original: "Qux", translation: "Bar")
        let uuid = UUID()
        wordService.removeFromStorage(by: uuid)
        
        // when
        wordService.getDataFromStorage()
            .subscribe(
                onSuccess: {
                    // then
                    XCTAssertEqual($0.count, countDataArray)
                },
                onFailure: {_ in
                    XCTFail()
                })
            .disposed(by: disposeBag)
        
    }
    
}

