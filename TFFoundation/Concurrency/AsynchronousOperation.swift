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
    
    override public final var isExecuting: Bool { synchronized { state == .executing } }
    override public final var isFinished: Bool { synchronized { state == .finished } }
    override public final var isAsynchronous: Bool { return true }
    
    override public final func start() {
        // An operation that was cancelled before its execution started cannot immediately move into finished state
        // Instead, it has to be marked as finished as soon as it is started
        let isCancelledBeforeStart = !synchronized { beginStart() }
        guard !isCancelledBeforeStart else {
            return
        }
        didStart()
        // In order to guarantee didStart()/didCancel() invocation order, do not transition into executing state until after didStart() returns
        // As a result, if the operation is cancelled during didStart(), didCancel() is not invoked as a part of the regular cancellation flow
        let isStartCancelled = !synchronized { completeStart() }
        if isStartCancelled {
            didCancel()
        }
    }
    
    override public final func cancel() {
        let cancelState = synchronized { doCancel() }
        // See start() implementation for explanation why didCancel() isn't always executed here
        if cancelState == .executing {
            didCancel()
        }
    }
    
    /// To be overridden in subclasses, invoked after operation is successfully started.
    ///
    /// - Note: May not be invoked at all if the operation was cancelled early.
    open func didStart() {
        fatalError("Template method. Must be overriden")
    }

    /// To be overridden in subclasses, invoked at most once after the operation is cancelled.
    ///
    /// - Note: If `didStart()` was invoked, this is guaranteed to be invoked after that.
    open func didCancel() {
        fatalError("Template method. Must be overriden")
    }
    
    /// Called to mark execution as finished.
    public final func markFinished() {
        synchronized { state = .finished }
    }
    
    private func beginStart() -> Bool {
        if isCancelled {
            state = .finished
            return false
        } else {
            return true
        }
    }
    
    private func completeStart() -> Bool {
        guard !isCancelled else {
            return false
        }
        // Check if the operation hasn't been marked as finished on startup
        if state == .idle {
            state = .executing
        }
        return true
    }
    
    private func doCancel() -> State? {
        let isAlreadyCancelled = isCancelled
        super.cancel()
        return isAlreadyCancelled ? nil : state
    }
}
