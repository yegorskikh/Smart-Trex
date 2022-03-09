//
//  URLMock.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 21.02.2022.
//

import Foundation

class URLMock: URLProtocol {
    
    static var loadingHandler: ((URLRequest) -> (HTTPURLResponse, Data?))?
    
    func setupMock(statusCode: Int, responseData: Data?) {
        URLMock.loadingHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
            return (response, responseData)
        }
    }
    
    enum ErrorMock: Error {
        case error
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard
            let handler = URLMock.loadingHandler
        else {
            return
        }
        let (response, data) = handler(request)
        
        if let data = data {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
        else {
            client?.urlProtocol(self, didFailWithError: ErrorMock.error)
            
        }
    }
    
    override func stopLoading() {}
    
}
