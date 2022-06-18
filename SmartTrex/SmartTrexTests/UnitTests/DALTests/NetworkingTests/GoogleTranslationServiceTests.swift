//
//  GoogleTranslationServiceTests.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 15.02.2022.
//

import Foundation
import XCTest
@testable import SmartTrex
import Alamofire
import RxSwift

class GoogleTranslationServiceTests: XCTestCase {
    
    var sut: GoogleTranslationService!
    var mock: URLProtocolMock!
    var translationRequestModel: TranslationRequestModel!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        
        sut = GoogleTranslationService(urlConfiguration: configuration)
        mock = URLProtocolMock()
        
        translationRequestModel = TranslationRequestModel(q: "Bar", target: "en")
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        translationRequestModel = nil
        sut = nil
        mock = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func test_translate_successful_request() {
        // given
        let responseData = TranslateResponseData(
            data: TranslationResponseModel(
                translations: [WordResponseModel(translatedText: "Foo")]
            )
        )
        let responseJsonData = try! JSONEncoder().encode(responseData)
        mock.setupMock(statusCode: 200, responseData: responseJsonData)
        let expectedResponseModel = "Foo"
        let expectation = XCTestExpectation(description: "successful request")
        
        // when
        sut.toTranslate(word: translationRequestModel)
            .subscribe(
                onSuccess: {
                    // then
                    XCTAssertEqual($0, expectedResponseModel)
                    expectation.fulfill()
                },
                onFailure: {_ in
                    XCTFail()
                })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_translate_successful_corrupted_data() {
        // given
        let expectation = XCTestExpectation(description: "corrupted data")
        let responseData = TranslateResponseData(data: nil)
        let responseJsonData = try! JSONEncoder().encode(responseData)
        mock.setupMock(statusCode: 200, responseData: responseJsonData)

        
        // when
        sut.toTranslate(word: translationRequestModel)
            .subscribe(
                onSuccess: {_ in
                    XCTFail()
                },
                onFailure: { error in
                    // then
                    XCTAssertEqual(
                        error.localizedDescription,
                        NetworkingErrorMessage.corruptedData.localizedDescription
                    )
                    expectation.fulfill()
                })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_translate_response_with_failed_status_code() {
        // given
        let expected = TranslateResponseData(data: TranslationResponseModel(translations:
                                                                                [WordResponseModel(translatedText: "Foo")]))
        let responseJsonData = try! JSONEncoder().encode(expected)
        mock.setupMock(statusCode: 404, responseData: responseJsonData)
        let expectation = XCTestExpectation(description: "failed status code")
        
        // when
        sut.toTranslate(word: translationRequestModel)
            .subscribe(
                onFailure: {
                    // then
                    XCTAssertEqual(
                        $0.localizedDescription,
                        NetworkingErrorMessage.statusCode.localizedDescription
                    )
                    expectation.fulfill()
                })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_translate_failed_response_data() {
        // given
        let expectation = XCTestExpectation(description: "failed response data")
        mock.setupMock(statusCode: 200, responseData: nil)
        
        // when
        sut.toTranslate(word: translationRequestModel)
            .subscribe(
                onFailure: {
                    // then
                    XCTAssertEqual(
                        $0.localizedDescription,
                        NetworkingErrorMessage.responseData.localizedDescription
                    )
                    expectation.fulfill()
                })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_translate_failed_decode_data() {
        // given
        let expectation = XCTestExpectation(description: "failed decode data")
        let expected = ""
        let responseJsonData = try! JSONEncoder().encode(expected)
        mock.setupMock(statusCode: 200, responseData: responseJsonData)
        
        // when
        sut.toTranslate(word: translationRequestModel)
            .subscribe(
                onFailure: {
                    // then
                    XCTAssertEqual(
                        $0.localizedDescription,
                        NetworkingErrorMessage.decodeData.localizedDescription
                    )
                    expectation.fulfill()
                })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5)
    }
    
}
