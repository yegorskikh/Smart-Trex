//
//  RootViewModelTests.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 11.07.2022.
//

import Foundation
import XCTest
import RxTest
import RxBlocking
import RxSwift
@testable import SmartTrex

class RootViewModelTests: XCTestCase {
    
    var sut: RootViewModel!
    
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        sut = RootViewModel()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    override func tearDown() {
        sut = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testTransition() {
        // given
        let tappedToTranslate = scheduler.createObserver(Void.self)
        let tappedToHistory = scheduler.createObserver(Void.self)
        let tappedToBooks = scheduler.createObserver(Void.self)
        
        sut.actionBooks
            .subscribe(tappedToBooks)
            .disposed(by: disposeBag)
        
        sut.actionTranslate
            .subscribe(tappedToTranslate)
            .disposed(by: disposeBag)
        
        sut.actionHistory
            .subscribe(tappedToHistory)
            .disposed(by: disposeBag)
        
        // when
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.input.onSendActionBooks)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.input.onSendActionHistory)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.input.onSendActionTranslate)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // then
        
        XCTAssertEqual(tappedToTranslate.events.count, 1)
        
        XCTAssertEqual(tappedToBooks.events.count, 1)

        XCTAssertEqual(tappedToHistory.events.count, 1)
    }

}
