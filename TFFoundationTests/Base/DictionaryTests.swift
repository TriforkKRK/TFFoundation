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

class DictionaryTests: XCTestCase {
    
    func testEmptyDictionary() {
        let empty = Dictionary<String, Int>()
        let result = empty.bisect { key, value in
            return true
        }
        XCTAssert(result.matched.isEmpty && result.unmatched.isEmpty)
    }
    
    func testMatchingAllElements() {
        let dict = ["1": 1]
        let result = dict.bisect { key, value in
            return true
        }
        XCTAssertEqual(result.matched, dict)
        XCTAssert(result.unmatched.isEmpty)
    }
    
    func testUnmatchingAllElements() {
        let dict = ["1": 1]
        let result = dict.bisect { key, value in
            return false
        }
        XCTAssert(result.matched.isEmpty)
        XCTAssertEqual(result.unmatched, dict)
    }
    
    func testMatchingAndUnmatchingElements() {
        let dict = ["1": 1, "2": 2]
        let result = dict.bisect { key, value in
            return value % 2 == 0
        }
        XCTAssertEqual(result.matched, ["2": 2])
        XCTAssertEqual(result.unmatched, ["1": 1])
    }
}
