//
//  TranslatePresenterTests.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 01.03.2022.
//

import Foundation
import XCTest
import RxTest
import RxBlocking
import RxSwift
@testable import SmartTrex

class TranslateViewModelTests: XCTestCase {
    
    var sut: TranslateViewModel!
    var interactorMock: TranslateInteractorMock!
    
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        interactorMock = TranslateInteractorMock()
        sut = TranslateViewModel(
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
    
    func test_success_translate() {
        // given
        let tappedToTranslate = scheduler.createObserver(Void.self)
        let textToTranslate = scheduler.createObserver(String.self)
        let targetToTranslate = scheduler.createObserver(String.self)
        
        sut.sendAction
            .subscribe(tappedToTranslate)
            .disposed(by: disposeBag)
        
        sut.textToTranslate
            .subscribe(textToTranslate)
            .disposed(by: disposeBag)
        
        sut.targetToTranslate
            .subscribe(targetToTranslate)
            .disposed(by: disposeBag)
        
        // when
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.input.onSendAction)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(12, "Foo")])
            .bind(to: sut.input.onToTranslate)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(12, "Bar")])
            .bind(to: sut.input.onTarget)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // then
        XCTAssertEqual(textToTranslate.events, [
            .next(0, ""),
            .next(12, "Foo")
        ])
        XCTAssertEqual(targetToTranslate.events, [
            .next(0, ""),
            .next(12, "Bar")
        ])
        XCTAssertEqual(interactorMock.wasCalled, true)
    }
    
    func test_failed_translate() {
        // given
        interactorMock.typeResponse = .error
        
        let tappedToTranslate = scheduler.createObserver(Void.self)
        let textToTranslate = scheduler.createObserver(String.self)
        let targetToTranslate = scheduler.createObserver(String.self)
        
        sut.sendAction
            .subscribe(tappedToTranslate)
            .disposed(by: disposeBag)
        
        sut.textToTranslate
            .subscribe(textToTranslate)
            .disposed(by: disposeBag)

        sut.targetToTranslate
            .subscribe(targetToTranslate)
            .disposed(by: disposeBag)
        
        // when
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.input.onSendAction)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.completed(11)])
            .bind(to: sut.input.onToTranslate)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.completed(11)])
            .bind(to: sut.input.onTarget)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // then
        XCTAssertEqual(textToTranslate.events, [
            .next(0, ""),
            .completed(11)
        ])
        
        XCTAssertEqual(targetToTranslate.events, [
            .next(0, ""),
            .completed(11)
        ])
        
        XCTAssertEqual(interactorMock.wasCalled, true)
    }
    
}
