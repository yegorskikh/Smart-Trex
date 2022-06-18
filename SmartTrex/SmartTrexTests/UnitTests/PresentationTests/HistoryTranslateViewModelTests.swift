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
    
    func test_success_send_message_to_receive_data() {
        // given
        interactorMock.responseType = .success
        let loadViewControllerObserver = scheduler.createObserver(Void.self)
        
        sut.startDownload
            .subscribe(loadViewControllerObserver)
            .disposed(by: disposeBag)
        
        // when
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.input.viewControllerDidLoadView)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        //then
        XCTAssertEqual(loadViewControllerObserver.events.count, 1)
    }
    
    func test_successfully_received_the_path_to_delete() {
        // given
        let indexPathToDelete = scheduler.createObserver(IndexPath.self)
        
        sut.indexPathToDelete
            .subscribe(indexPathToDelete)
            .disposed(by: disposeBag)
        
        // when
        scheduler.createColdObservable([.next(10, IndexPath(row: 0, section: 0))])
            .bind(to: sut.input.indexPathToDel)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // then
        XCTAssertEqual(indexPathToDelete.events.count, 1)
    }
    
    func test_failed_received_the_path_to_delete() {
        // given
        interactorMock.responseType = .failed
        let errorLoadViewControllerObserver = scheduler.createObserver(Void.self)
        
        sut.startDownload
            .subscribe(errorLoadViewControllerObserver)
            .disposed(by: disposeBag)
        
        // when
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.input.viewControllerDidLoadView)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        //then
        XCTAssertEqual(errorLoadViewControllerObserver.events.count, 1)
    }

}
