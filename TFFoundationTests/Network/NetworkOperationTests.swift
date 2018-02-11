//
//  NetworkOperationTests.swift
//  TFFoundationTests
//
//  Created by Wojciech Nagrodzki on 10/02/2018.
//

import XCTest
@testable import TFFoundation

class NetworkOperationTests: XCTestCase {
    
    let request = URLRequest(url: URL(string: "http://a.b")!)
    
    func testSuccess() {
        let sentData = Data()
        let scheduler = SchedulerMock(statusCode: HTTPStatusCode.ok.rawValue, result: Result<Data>.success(sentData))
        let networkOperation = NetworkOperation<DataToDataConverter>(request: request, scheduler: scheduler, acceptableStatusCodes: [.ok])
        
        let successExpectation = XCTestExpectation(description: "Data has been delivered")
        
        networkOperation.completionBlock = {
            guard case Result<Data>.success(let receivedData)? = networkOperation.result,
                  receivedData == sentData
            else { return }
            successExpectation.fulfill()
        }
        
        OperationQueue().addOperation(networkOperation)
        
        let waiter = XCTWaiter(delegate: self)
        let testResult = waiter.wait(for: [successExpectation], timeout: 1)
        XCTAssertEqual(testResult, .completed)
    }
    
    func testUnacceptableStatusCodeError() {
        let sentData = Data()
        let scheduler = SchedulerMock(statusCode: HTTPStatusCode.created.rawValue, result: Result<Data>.success(sentData))
        let networkOperation = NetworkOperation<DataToDataConverter>(request: request, scheduler: scheduler, acceptableStatusCodes: [.ok])
        
        let failureExpectation = XCTestExpectation(description: "Unacceptable HTTP status code")
        
        networkOperation.completionBlock = {
            guard case Result<Data>.failure(let error)? = networkOperation.result else { return }
            guard case NetworkOperationError.unacceptableStatusCode(.created) = error else { return }
            failureExpectation.fulfill()
        }
        
        OperationQueue().addOperation(networkOperation)
        
        let waiter = XCTWaiter(delegate: self)
        let testResult = waiter.wait(for: [failureExpectation], timeout: 1)
        XCTAssertEqual(testResult, .completed)
    }
    
    func testConverterError() {
        // see http://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-test.txt section 3.1.1
        let sentData = Data(bytes: [0x80])
        let scheduler = SchedulerMock(statusCode: HTTPStatusCode.ok.rawValue, result: Result<Data>.success(sentData))
        let networkOperation = NetworkOperation<DataToUTF8StringConverter>(request: request, scheduler: scheduler, acceptableStatusCodes: [.ok])
        
        let failureExpectation = XCTestExpectation(description: "Data to string conversion error")
        
        networkOperation.completionBlock = {
            guard case Result<String>.failure(let error)? = networkOperation.result else { return }
            guard case DataToUTF8StringConverter.ConversionError.initializationFailed = error else { return }
            failureExpectation.fulfill()
        }
        
        OperationQueue().addOperation(networkOperation)
        
        let waiter = XCTWaiter(delegate: self)
        let testResult = waiter.wait(for: [failureExpectation], timeout: 1)
        XCTAssertEqual(testResult, .completed)
    }
    
    func testNetworkError() {
        let networkError = SchedulerMock.NetworkError()
        let scheduler = SchedulerMock(statusCode: HTTPStatusCode.badRequest.rawValue, result: Result<Data>.failure(networkError))
        let networkOperation = NetworkOperation<DataToDataConverter>(request: request, scheduler: scheduler, acceptableStatusCodes: [.ok])
        
        let failureExpectation = XCTestExpectation(description: "Network error")
        
        networkOperation.completionBlock = {
            guard case Result<Data>.failure(let error)? = networkOperation.result else { return }
            guard error is SchedulerMock.NetworkError else { return }
            failureExpectation.fulfill()
        }
        
        OperationQueue().addOperation(networkOperation)
        
        let waiter = XCTWaiter(delegate: self)
        let testResult = waiter.wait(for: [failureExpectation], timeout: 1)
        XCTAssertEqual(testResult, .completed)
    }
    
    func testCancellationError() {
        let sentData = Data()
        let scheduler = SchedulerMock(statusCode: HTTPStatusCode.ok.rawValue, result: Result<Data>.success(sentData))
        let networkOperation = NetworkOperation<DataToDataConverter>(request: request, scheduler: scheduler, acceptableStatusCodes: [.ok])
        
        let successExpectation = XCTestExpectation(description: "Data has been delivered")
        
        networkOperation.completionBlock = {
            guard case Result<Data>.failure(let error)? = networkOperation.result else { return }
            guard case NetworkOperationError.cancelled = error else { return }
            successExpectation.fulfill()
        }
        
        networkOperation.cancel()
        OperationQueue().addOperation(networkOperation)
        
        let waiter = XCTWaiter(delegate: self)
        let testResult = waiter.wait(for: [successExpectation], timeout: 1)
        XCTAssertEqual(testResult, .completed)
    }
    
    func testNetworkOperationErrorDescription() {
        let cancelled = NetworkOperationError.cancelled
        XCTAssertEqual(cancelled.description, "NetworkOperationError.cancelled")
        
        let unacceptableStatusCode = NetworkOperationError.unacceptableStatusCode(.ok)
        XCTAssertEqual(unacceptableStatusCode.description, "NetworkOperationError.unacceptableStatusCode(ok)")
    }
}

private class SchedulerMock: NetworkRequestScheduler {
    
    struct NetworkError: Error {}
    
    var statusCode: Int
    var result: Result<Data>
    
    init(statusCode: Int, result: Result<Data>) {
        self.statusCode = statusCode
        self.result = result
    }
    
    func schedule(_ request: URLRequest, with priority: Operation.QueuePriority, completionHandler: @escaping (Result<Data>, URLResponse?) -> Void) {
        DispatchQueue(label: "queue").async {
            let response = HTTPURLResponse(url: request.url!, statusCode: self.statusCode, httpVersion: nil, headerFields: nil)
            completionHandler(self.result, response)
        }
    }
}
