//
//  SessionMock.swift
//  SmartTrexTests
//
//  Created by Yegor Gorskikh on 15.02.2022.
//

import Foundation
@testable import SmartTrex
import XCTest

class URLProtocolMock: URLProtocol {
    
    static var loadingHandler: ((URLRequest) -> (HTTPURLResponse, Data?))?
    
    enum ErrorT: Error {
        case er
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard
            let handler = URLProtocolMock.loadingHandler
        else {
            XCTFail("Loading handler is not set.")
            return
        }
        let (response, data) = handler(request)
        
        if let data = data {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
        else {
            client?.urlProtocol(self, didFailWithError: ErrorT.er)
            
        }
    }
    
    override func stopLoading() {}
    
}
