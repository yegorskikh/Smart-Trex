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

class GoogleTranslationServiceTests: XCTestCase {
    
    var sut: GoogleTranslationService!
    var mock: URLProtocol!
    var translationRequestModel: TranslationRequestModel!
    var detectRequestModel: DetectRequest!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        
        translationRequestModel = TranslationRequestModel(q: "Bar", target: .en)
        detectRequestModel = DetectRequest(q: "Foo")
        sut = GoogleTranslationService(urlConfiguration: configuration)
        mock = URLProtocolMock()
    }
    
    override func tearDown() {
        translationRequestModel = nil
        detectRequestModel = nil
        sut = nil
        mock = nil
        super.tearDown()
    }
    
    func test_translate_successful_request() {
        // given
        let expected = TranslationResponeData(data: TranslationResponseModel(translations:
                                                                                [WordResponseModel(translatedText: "Foo")]))
        let responseJsonData = try! JSONEncoder().encode(expected)
        setupMock(statusCode: 200, responseData: responseJsonData)
        let expectation = XCTestExpectation(description: "successful request")
        
        // when
        sut.toTranslate(translationRequestModel) { response in
            // then
            let responseText = response?.responseData?.data?.translations?.first?.translatedText
            let expectedText = expected.data?.translations?.first?.translatedText
            XCTAssertEqual(responseText, expectedText)
            XCTAssertNil(response?.errorMessage)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_translate_response_with_faild_status_code() {
        // given
        let expected = TranslationResponeData(data: TranslationResponseModel(translations:
                                                                                [WordResponseModel(translatedText: "Foo")]))
        let responseJsonData = try! JSONEncoder().encode(expected)
        setupMock(statusCode: 404, responseData: responseJsonData)
        let expectation = XCTestExpectation(description: "faild status code")
        
        // when
        sut.toTranslate(translationRequestModel) { response in
            // then
            XCTAssertNotNil(response?.errorMessage)
            XCTAssertNil(response?.responseData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_translate_faild_response_data() {
        // given
        setupMock(statusCode: 200, responseData: nil)
        let expectation = XCTestExpectation(description: "faild response data")
        
        // when
        sut.toTranslate(translationRequestModel) { response in
            // then
            XCTAssertNotNil(response?.errorMessage)
            XCTAssertNil(response?.responseData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_translate_faild_decode_data() {
        // given
        let expected = ""
        let responseJsonData = try! JSONEncoder().encode(expected)
        setupMock(statusCode: 200, responseData: responseJsonData)
        let expectation = XCTestExpectation(description: "faild decode data")
        
        // when
        sut.toTranslate(translationRequestModel) { response in
            // then
            XCTAssertNotNil(response?.errorMessage)
            XCTAssertNil(response?.responseData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    
    func test_detect_successful_response() {
        // given
        let expected = DetectLanguageResponeData(data:
                                                    DetectLanguageResponseModel(detections:
                                                                                    [DetectResponseModel(confidence: 1,
                                                                                                         language: "Foo",
                                                                                                         isReliable: true)]))
        let responseJsonData = try! JSONEncoder().encode(expected)
        setupMock(statusCode: 200, responseData: responseJsonData)
        let expectation = XCTestExpectation(description: "successful request")
        
        // when
        sut.detectLanguage(detectRequestModel) { response in
            // then
            let responseModel = response?.responseData?.data?.detections?.first
            let expectedModel = expected.data?.detections?.first
            
            XCTAssertEqual(responseModel, expectedModel)
            XCTAssertNil(response?.errorMessage)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_detect_faild_status_code() {
        // given
        let expected = DetectLanguageResponeData(data:
                                                    DetectLanguageResponseModel(detections:
                                                                                    [DetectResponseModel(confidence: 1,
                                                                                                         language: "Foo",
                                                                                                         isReliable: true)]))
        let responseJsonData = try! JSONEncoder().encode(expected)
        setupMock(statusCode: 404, responseData: responseJsonData)
        let expectation = XCTestExpectation(description: "faild status code")
        
        // when
        sut.detectLanguage(detectRequestModel) { response in
            // then
            XCTAssertNotNil(response?.errorMessage)
            XCTAssertNil(response?.responseData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    func test_detect_response_with_faild_status_code() {
        // given
        let expected = DetectLanguageResponeData(data:
                                                    DetectLanguageResponseModel(detections:
                                                                                    [DetectResponseModel(confidence: 1,
                                                                                                         language: "Foo",
                                                                                                         isReliable: true)]))
        let responseJsonData = try! JSONEncoder().encode(expected)
        setupMock(statusCode: 404, responseData: responseJsonData)
        let expectation = XCTestExpectation(description: "faild status code")
        
        // when
        sut.detectLanguage(detectRequestModel) { response in
            // then
            XCTAssertNotNil(response?.errorMessage)
            XCTAssertNil(response?.responseData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_detect_faild_decode_data() {
        // given
        let expected = ""
        let responseJsonData = try! JSONEncoder().encode(expected)
        setupMock(statusCode: 200, responseData: responseJsonData)
        let expectation = XCTestExpectation(description: "faild decode data")
        
        // when
        sut.detectLanguage(detectRequestModel) { response in
            // then
            XCTAssertNotNil(response?.errorMessage)
            XCTAssertNil(response?.responseData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_detect_faild_response_data() {
        // given
        setupMock(statusCode: 200, responseData: nil)
        let expectation = XCTestExpectation(description: "faild response data")
        
        // when
        sut.detectLanguage(detectRequestModel) { response in
            // then
            XCTAssertNotNil(response?.errorMessage)
            XCTAssertNil(response?.responseData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    
}

extension GoogleTranslationServiceTests {
    
    func setupMock(statusCode: Int, responseData: Data?) {
        URLProtocolMock.loadingHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
            return (response, responseData)
        }
    }
}
