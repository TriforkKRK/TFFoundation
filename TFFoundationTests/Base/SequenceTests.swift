//
// MIT License
//
// Copyright (c) 2018 Trifork Kraków Office
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import XCTest
@testable import TFFoundation

class SequenceTests: XCTestCase {
    
    let empty = [Int]()
    let oneElement = [1]
    let twoElements = [1, 2]
    
    func testCountWhere() {
        XCTAssertEqual(0, empty.count(where: { $0 == 1 }))
        
        XCTAssertEqual(1, oneElement.count(where: { $0 == 1 }))
        XCTAssertEqual(0, oneElement.count(where: { $0 == 2 }))
        
        XCTAssertEqual(1, twoElements.count(where: { $0 == 1 }))
        XCTAssertEqual(1, twoElements.count(where: { $0 == 2 }))
        XCTAssertEqual(0, twoElements.count(where: { $0 == 3 }))
    }
    
    func testAnySatisfy() {
        XCTAssertFalse(empty.anySatisfy { $0 == 1 })
        
        XCTAssertTrue(oneElement.anySatisfy { $0 == 1 })
        XCTAssertFalse(oneElement.anySatisfy { $0 == 2 })
        
        XCTAssertTrue(twoElements.anySatisfy { $0 == 1 })
        XCTAssertTrue(twoElements.anySatisfy { $0 == 2 })
        XCTAssertFalse(twoElements.anySatisfy { $0 == 3 })
    }
    
    func testReject() {
        XCTAssertEqual([], empty.reject { $0 == 1 })
        
        XCTAssertEqual([], oneElement.reject { $0 == 1 })
        XCTAssertEqual([1], oneElement.reject { $0 == 2 })
        
        XCTAssertEqual([2], twoElements.reject { $0 == 1 })
        XCTAssertEqual([1], twoElements.reject { $0 == 2 })
        XCTAssertEqual([1, 2], twoElements.reject { $0 == 3 })
    }
    
    func testReduce() {
        XCTAssertEqual(nil, empty.reduce { $0 += $1 })
        XCTAssertEqual(1, oneElement.reduce { $0 += $1 })
        XCTAssertEqual(3, twoElements.reduce { $0 += $1 })
    }
    
    func testUnique() {
        XCTAssertEqual([], empty.unique())
        XCTAssertEqual([1], oneElement.unique())
        XCTAssertEqual([1, 2], twoElements.unique())
        
        let actual = [3, 1, 2, 1, 3, 2, 4, 4].unique()
        let expected = [3, 1, 2, 4]
        XCTAssertEqual(actual, expected)
    }
}
