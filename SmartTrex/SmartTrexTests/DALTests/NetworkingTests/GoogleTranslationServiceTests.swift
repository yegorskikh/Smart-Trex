//
//  GoogleTranslationServiceTests.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 15.02.2022.
//

import Foundation
import XCTest
@testable import SmartTrex

class GoogleTranslationServiceTests: XCTestCase {
    
    var sut: GoogleTranslationService!
    var mock: URLProtocol!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        
        sut = GoogleTranslationService(urlConfiguration: configuration)
        mock = URLProtocolMock()
    }
    
    override func tearDown() {
        sut = nil
        mock = nil
        super.tearDown()
    }
    
    func test_translate_successful_request() {}
    func test_translate_faild_response_data() {}
    func test_translate_response_with_faild_status_code() {}
    
    func test_detect_successful_response() {}
    func test_detect_faild_response_data() {}
    func test_detect_response_with_faild_status_code() {}
    
    
}
