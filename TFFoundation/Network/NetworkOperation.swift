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

/// Executes URL request through network request scheduller and delivers the result as `Converter.TargetType`.
/// If any error occurs it is reported via `result` property.
/// - note: URL requests are scheduled with the operation priority.
public class NetworkOperation<Converter : DataConverterter>: AsynchronousOperation {
    
    public let request: URLRequest
    public let scheduler: NetworkRequestScheduler
    public let acceptableStatusCodes: [HTTPStatusCode]
    
    /// Result of the operation is available only after it has finished.
    public var result: Result<Converter.TargetType>! { return isCancelled ? .failure(NetworkOperationError.cancelled) : requestResult }
    private var requestResult: Result<Converter.TargetType>!
    
    public init(request: URLRequest, scheduler: NetworkRequestScheduler, acceptableStatusCodes: [HTTPStatusCode] = [.ok]) {
        self.request = request
        self.scheduler = scheduler
        self.acceptableStatusCodes = acceptableStatusCodes
    }
    
    public override func didStart() {
        scheduler.schedule(request, with: queuePriority) { (result, response) -> Void in
            defer { self.markFinished() }
            
            switch result {
                
            case .failure(let error):
                self.requestResult = .failure(error)
                return
                
            case .success(let data):
                let HTTPResponse = response as! HTTPURLResponse
                let statusCode = HTTPStatusCode(rawValue: HTTPResponse.statusCode)
                
                guard self.acceptableStatusCodes.contains(statusCode) else {
                    self.requestResult = .failure(NetworkOperationError.unacceptableStatusCode(statusCode))
                    return
                }
                
                do {
                    let object = try Converter.makeInstance(from: data)
                    self.requestResult = .success(object)
                }
                catch {
                    self.requestResult = .failure(error)
                }
            }
        }
    }
}

public protocol NetworkRequestScheduler {
    func schedule(_ request: URLRequest, with priority: Operation.QueuePriority, completionHandler: @escaping (Result<Data>, URLResponse?) -> Void)
}


public enum NetworkOperationError: Error, CustomStringConvertible {
    
    case cancelled
    case unacceptableStatusCode(HTTPStatusCode)
    
    public var description: String {
        let description = String(describing: NetworkOperationError.self) + "."
        switch self {
        case .cancelled: return description + "cancelled"
        case .unacceptableStatusCode(let statusCode): return description + "unacceptableStatusCode(\(statusCode))"
        }
    }
}
