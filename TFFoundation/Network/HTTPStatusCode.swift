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

/// HTTP status codes are based on [RFC 7231](https://tools.ietf.org/html/rfc7231).
public enum HTTPStatusCode: RawRepresentable {

    // Informational 1xx
    case continue_
    case switchingProtocols

    // Successful 2xx
    case ok
    case created
    case accepted
    case nonAuthoritativeInformation
    case noContent
    case resetContent
    case partialContent

    // Redirection 3xx
    case multipleChoices
    case movedPermanently
    case found
    case seeOther
    case notModified
    case useProxy
    case temporaryRedirect

    // Client Error 4xx
    case badRequest
    case unauthorized
    case paymentRequired
    case forbidden
    case notFound
    case methodNotAllowed
    case notAcceptable
    case proxyAuthenticationRequired
    case requestTimeout
    case conflict
    case gone
    case lengthRequired
    case preconditionFailed
    case payloadTooLarge
    case uriTooLong
    case unsupportedMediaType
    case rangeNotSatisfiable
    case expectationFailed
    case upgradeRequired

    // Server Error 5xx
    case internalServerError
    case notImplemented
    case badGateway
    case serviceUnavailable
    case gatewayTimeout
    case httpVersionNotSupported

    // Custom
    case custom(Int)

    public var rawValue: Int {

        switch self {

        // Informational 1xx
        case .continue_                     :return 100
        case .switchingProtocols            :return 101

        // Successful 2xx
        case .ok                            :return 200
        case .created                       :return 201
        case .accepted                      :return 202
        case .nonAuthoritativeInformation   :return 203
        case .noContent                     :return 204
        case .resetContent                  :return 205
        case .partialContent                :return 206

        // Redirection 3xx
        case .multipleChoices               :return 300
        case .movedPermanently              :return 301
        case .found                         :return 302
        case .seeOther                      :return 303
        case .notModified                   :return 304
        case .useProxy                      :return 305
        case .temporaryRedirect             :return 307

        // Client Error 4xx
        case .badRequest                    :return 400
        case .unauthorized                  :return 401
        case .paymentRequired               :return 402
        case .forbidden                     :return 403
        case .notFound                      :return 404
        case .methodNotAllowed              :return 405
        case .notAcceptable                 :return 406
        case .proxyAuthenticationRequired   :return 407
        case .requestTimeout                :return 408
        case .conflict                      :return 409
        case .gone                          :return 410
        case .lengthRequired                :return 411
        case .preconditionFailed            :return 412
        case .payloadTooLarge               :return 413
        case .uriTooLong                    :return 414
        case .unsupportedMediaType          :return 415
        case .rangeNotSatisfiable           :return 416
        case .expectationFailed             :return 417
        case .upgradeRequired               :return 426

        // Server Error 5xx
        case .internalServerError           :return 500
        case .notImplemented                :return 501
        case .badGateway                    :return 502
        case .serviceUnavailable            :return 503
        case .gatewayTimeout                :return 504
        case .httpVersionNotSupported       :return 505

        // Custom
        case .custom(let code): return code
        }
    }

    public init(rawValue: Int) {

        switch rawValue {

        // Informational 1xx
        case 100: self = .continue_
        case 101: self = .switchingProtocols

        // Successful 2xx
        case 200: self = .ok
        case 201: self = .created
        case 202: self = .accepted
        case 203: self = .nonAuthoritativeInformation
        case 204: self = .noContent
        case 205: self = .resetContent
        case 206: self = .partialContent

        // Redirection 3xx
        case 300: self = .multipleChoices
        case 301: self = .movedPermanently
        case 302: self = .found
        case 303: self = .seeOther
        case 304: self = .notModified
        case 305: self = .useProxy
        case 307: self = .temporaryRedirect

        // Client Error 4xx
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 402: self = .paymentRequired
        case 403: self = .forbidden
        case 404: self = .notFound
        case 405: self = .methodNotAllowed
        case 406: self = .notAcceptable
        case 407: self = .proxyAuthenticationRequired
        case 408: self = .requestTimeout
        case 409: self = .conflict
        case 410: self = .gone
        case 411: self = .lengthRequired
        case 412: self = .preconditionFailed
        case 413: self = .payloadTooLarge
        case 414: self = .uriTooLong
        case 415: self = .unsupportedMediaType
        case 416: self = .rangeNotSatisfiable
        case 417: self = .expectationFailed
        case 426: self = .upgradeRequired

        // Server Error 5xx
        case 500: self = .internalServerError
        case 501: self = .notImplemented
        case 502: self = .badGateway
        case 503: self = .serviceUnavailable
        case 504: self = .gatewayTimeout
        case 505: self = .httpVersionNotSupported

        // Custom
        default:  self = .custom(rawValue)
        }
    }
}


extension HTTPStatusCode: Equatable {

    public static func ==(lhs: HTTPStatusCode, rhs: HTTPStatusCode) -> Bool {

        return lhs.rawValue == rhs.rawValue
    }
}
