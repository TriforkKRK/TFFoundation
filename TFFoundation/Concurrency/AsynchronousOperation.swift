//
// MIT License
//
// Copyright (c) 2017 Trifork Kraków Office
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

/// Base class for asynchronous `NSOperation`s. Handles thread-safe execution state management.
open class AsynchronousOperation: Operation {
    
    private enum State {
        
        case idle
        case executing
        case finished
    }
    
    private var state: State = .idle {
        
        willSet {
            
            willChangeValue(forKey: "isExecuting")
            willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            
            didChangeValue(forKey: "isFinished")
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var stateSynchronized: State {
        
        get { return synchronized { self.state } }
        set { synchronized { self.state = newValue } }
    }
    
    override public final var isExecuting: Bool { return stateSynchronized == .executing }
    override public final var isFinished: Bool { return stateSynchronized == .finished }
    override public final var isAsynchronous: Bool { return true }
    
    override public final func start() {
        
        guard isCancelled == false else {
            
            markFinished()
            return
        }

        stateSynchronized = .executing
        didStart()
    }
    
    /// To be overridden in subclasses, invoked after operation is successfully started.
    open func didStart() {
        
        fatalError("Template method. Must be overriden")
    }
    
    /// Called to mark execution as finished.
    public final func markFinished() { stateSynchronized = .finished }
}
