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

import Foundation

extension Sequence {
    
    func count(where predicate: (Self.Element) throws -> Bool) rethrows -> Int {
        return try reduce(into: 0, { (count, element) in
            if try predicate(element) { count += 1 }
        })
    }
    
    func anySatisfy(_ predicate: (Self.Element) throws -> Bool) rethrows -> Bool {
        for element in self {
            if try predicate(element) { return true }
        }
        return false
    }
    
    func reject(_ isExcluded: (Self.Element) throws -> Bool) rethrows -> [Self.Element] {
        return try filter { try !isExcluded($0) }
    }
    
    func reduce(_ updateAccumulatingElement: (inout Element, Self.Element) throws -> ()) rethrows -> Element? {
        var accumulator: Element?
        for (_, element) in enumerated() {
            if accumulator == nil {
                accumulator = element
                continue
            }
            try updateAccumulatingElement(&accumulator!, element)
        }
        return accumulator
    }
}

extension Sequence where Iterator.Element: Hashable {
    
    func unique() -> [Iterator.Element] {
        var unique: Set<Iterator.Element> = []
        return filter {
            if unique.contains($0) {
                return false
            }
            else {
                unique.insert($0)
                return true
            }
        }
    }
}
