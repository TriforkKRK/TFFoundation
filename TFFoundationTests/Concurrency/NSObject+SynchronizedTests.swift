//
//  NSObject+SynchronizedTests.swift
//  TFFoundationTests
//
//  Created by Wojciech Nagrodzki on 10/02/2018.
//

import XCTest
@testable import TFFoundation

class NSObject_SynchronizedTests: XCTestCase {
    
    func testSynchronization() {
        let counter = Counter()
        let operationCount = 1024
        
        let operations = Array(1...operationCount).map { _ in
            BlockOperation { counter.incrementCounter() }
        }
        OperationQueue().addOperations(operations, waitUntilFinished: true)
        
        XCTAssertEqual(counter.value, operationCount * counter.increment)
    }
}

private class Counter: NSObject {
    
    var value = 0
    let increment = 1
    
    func incrementCounter() {
        synchronized {
            let currentValue = value
            usleep(1000)
            value = currentValue + increment
        }
    }
}
