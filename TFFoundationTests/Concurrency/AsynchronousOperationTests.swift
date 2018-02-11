//
//  AsynchronousOperationTests.swift
//  TFFoundationTests
//
//  Created by Wojciech Nagrodzki on 10/02/2018.
//

import XCTest
@testable import TFFoundation

class AsynchronousOperationTests: XCTestCase {
    
    func testFinishing() {
        let expectation = XCTestExpectation(description: "Operation finished")
        expectation.expectedFulfillmentCount = 1
        
        let operation = FinishingOperation()
        operation.completionBlock = {
            expectation.fulfill()
        }
        OperationQueue().addOperation(operation)
        
        let waiter = XCTWaiter(delegate: self)
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testUnfinishing() {
        let expectation = XCTestExpectation(description: "Operation did not finish")
        expectation.isInverted = true
        
        let operation = UnfinishingOperation()
        operation.completionBlock = {
            expectation.fulfill()
        }
        OperationQueue().addOperation(operation)
        
        let waiter = XCTWaiter(delegate: self)
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
    
    func testCancelling() {
        let expectation = XCTestExpectation(description: "didStart method was not run")
        expectation.isInverted = true
        
        let operation = FinishingOperation()
        operation.completionBlock = {
            if operation.didStartWasRun {
                expectation.fulfill()
            }
        }
        operation.cancel()
        OperationQueue().addOperation(operation)
        
        let waiter = XCTWaiter(delegate: self)
        let result = waiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .completed)
    }
}

private class FinishingOperation: AsynchronousOperation {
    
    var didStartWasRun = false
    
    override func didStart() {
        didStartWasRun = true
        let queue = DispatchQueue(label: "queue")
        queue.async {
            self.markFinished()
        }
    }
}

private class UnfinishingOperation: AsynchronousOperation {
    
    override func didStart() {
        // nop
    }
}
