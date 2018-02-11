//
//  HTTPStatusCodeTests.swift
//  TFFoundationTests
//
//  Created by Wojciech Nagrodzki on 10/02/2018.
//

import XCTest
@testable import TFFoundation

class HTTPStatusCodeTests: XCTestCase {
    
    func testRawValues() {
        // Informational 1xx
        XCTAssertEqual(HTTPStatusCode.continue_.rawValue,100)
        XCTAssertEqual(HTTPStatusCode.switchingProtocols.rawValue,101)
        
        // Successful 2xx
        XCTAssertEqual(HTTPStatusCode.ok.rawValue,200)
        XCTAssertEqual(HTTPStatusCode.created.rawValue,201)
        XCTAssertEqual(HTTPStatusCode.accepted.rawValue,202)
        XCTAssertEqual(HTTPStatusCode.nonAuthoritativeInformation.rawValue,203)
        XCTAssertEqual(HTTPStatusCode.noContent.rawValue,204)
        XCTAssertEqual(HTTPStatusCode.resetContent.rawValue,205)
        XCTAssertEqual(HTTPStatusCode.partialContent.rawValue,206)
        
        // Redirection 3xx
        XCTAssertEqual(HTTPStatusCode.multipleChoices.rawValue,300)
        XCTAssertEqual(HTTPStatusCode.movedPermanently.rawValue,301)
        XCTAssertEqual(HTTPStatusCode.found.rawValue,302)
        XCTAssertEqual(HTTPStatusCode.seeOther.rawValue,303)
        XCTAssertEqual(HTTPStatusCode.notModified.rawValue,304)
        XCTAssertEqual(HTTPStatusCode.useProxy.rawValue,305)
        XCTAssertEqual(HTTPStatusCode.temporaryRedirect.rawValue,307)
        
        // ClientError 4xx
        XCTAssertEqual(HTTPStatusCode.badRequest.rawValue,400)
        XCTAssertEqual(HTTPStatusCode.unauthorized.rawValue,401)
        XCTAssertEqual(HTTPStatusCode.paymentRequired.rawValue,402)
        XCTAssertEqual(HTTPStatusCode.forbidden.rawValue,403)
        XCTAssertEqual(HTTPStatusCode.notFound.rawValue,404)
        XCTAssertEqual(HTTPStatusCode.methodNotAllowed.rawValue,405)
        XCTAssertEqual(HTTPStatusCode.notAcceptable.rawValue,406)
        XCTAssertEqual(HTTPStatusCode.proxyAuthenticationRequired.rawValue,407)
        XCTAssertEqual(HTTPStatusCode.requestTimeout.rawValue,408)
        XCTAssertEqual(HTTPStatusCode.conflict.rawValue,409)
        XCTAssertEqual(HTTPStatusCode.gone.rawValue,410)
        XCTAssertEqual(HTTPStatusCode.lengthRequired.rawValue,411)
        XCTAssertEqual(HTTPStatusCode.preconditionFailed.rawValue,412)
        XCTAssertEqual(HTTPStatusCode.payloadTooLarge.rawValue,413)
        XCTAssertEqual(HTTPStatusCode.uriTooLong.rawValue,414)
        XCTAssertEqual(HTTPStatusCode.unsupportedMediaType.rawValue,415)
        XCTAssertEqual(HTTPStatusCode.rangeNotSatisfiable.rawValue,416)
        XCTAssertEqual(HTTPStatusCode.expectationFailed.rawValue,417)
        XCTAssertEqual(HTTPStatusCode.upgradeRequired.rawValue,426)
        
        // ServerError 5xx
        XCTAssertEqual(HTTPStatusCode.internalServerError.rawValue,500)
        XCTAssertEqual(HTTPStatusCode.notImplemented.rawValue,501)
        XCTAssertEqual(HTTPStatusCode.badGateway.rawValue,502)
        XCTAssertEqual(HTTPStatusCode.serviceUnavailable.rawValue,503)
        XCTAssertEqual(HTTPStatusCode.gatewayTimeout.rawValue,504)
        XCTAssertEqual(HTTPStatusCode.httpVersionNotSupported.rawValue,505)
        
        // Custom
        XCTAssertEqual(HTTPStatusCode.custom(600).rawValue,600)
    }
    
    func testInitialization() {
        // Informational 1xx
        XCTAssertEqual(HTTPStatusCode(rawValue: 100), HTTPStatusCode.continue_)
        XCTAssertEqual(HTTPStatusCode(rawValue: 101), HTTPStatusCode.switchingProtocols)
        
        // Successful 2xx
        XCTAssertEqual(HTTPStatusCode(rawValue: 200), HTTPStatusCode.ok)
        XCTAssertEqual(HTTPStatusCode(rawValue: 201), HTTPStatusCode.created)
        XCTAssertEqual(HTTPStatusCode(rawValue: 202), HTTPStatusCode.accepted)
        XCTAssertEqual(HTTPStatusCode(rawValue: 203), HTTPStatusCode.nonAuthoritativeInformation)
        XCTAssertEqual(HTTPStatusCode(rawValue: 204), HTTPStatusCode.noContent)
        XCTAssertEqual(HTTPStatusCode(rawValue: 205), HTTPStatusCode.resetContent)
        XCTAssertEqual(HTTPStatusCode(rawValue: 206), HTTPStatusCode.partialContent)
        
        // Redirection 3xx
        XCTAssertEqual(HTTPStatusCode(rawValue: 300), HTTPStatusCode.multipleChoices)
        XCTAssertEqual(HTTPStatusCode(rawValue: 301), HTTPStatusCode.movedPermanently)
        XCTAssertEqual(HTTPStatusCode(rawValue: 302), HTTPStatusCode.found)
        XCTAssertEqual(HTTPStatusCode(rawValue: 303), HTTPStatusCode.seeOther)
        XCTAssertEqual(HTTPStatusCode(rawValue: 304), HTTPStatusCode.notModified)
        XCTAssertEqual(HTTPStatusCode(rawValue: 305), HTTPStatusCode.useProxy)
        XCTAssertEqual(HTTPStatusCode(rawValue: 307), HTTPStatusCode.temporaryRedirect)
        
        // Client Error 4xx
        XCTAssertEqual(HTTPStatusCode(rawValue: 400), HTTPStatusCode.badRequest)
        XCTAssertEqual(HTTPStatusCode(rawValue: 401), HTTPStatusCode.unauthorized)
        XCTAssertEqual(HTTPStatusCode(rawValue: 402), HTTPStatusCode.paymentRequired)
        XCTAssertEqual(HTTPStatusCode(rawValue: 403), HTTPStatusCode.forbidden)
        XCTAssertEqual(HTTPStatusCode(rawValue: 404), HTTPStatusCode.notFound)
        XCTAssertEqual(HTTPStatusCode(rawValue: 405), HTTPStatusCode.methodNotAllowed)
        XCTAssertEqual(HTTPStatusCode(rawValue: 406), HTTPStatusCode.notAcceptable)
        XCTAssertEqual(HTTPStatusCode(rawValue: 407), HTTPStatusCode.proxyAuthenticationRequired)
        XCTAssertEqual(HTTPStatusCode(rawValue: 408), HTTPStatusCode.requestTimeout)
        XCTAssertEqual(HTTPStatusCode(rawValue: 409), HTTPStatusCode.conflict)
        XCTAssertEqual(HTTPStatusCode(rawValue: 410), HTTPStatusCode.gone)
        XCTAssertEqual(HTTPStatusCode(rawValue: 411), HTTPStatusCode.lengthRequired)
        XCTAssertEqual(HTTPStatusCode(rawValue: 412), HTTPStatusCode.preconditionFailed)
        XCTAssertEqual(HTTPStatusCode(rawValue: 413), HTTPStatusCode.payloadTooLarge)
        XCTAssertEqual(HTTPStatusCode(rawValue: 414), HTTPStatusCode.uriTooLong)
        XCTAssertEqual(HTTPStatusCode(rawValue: 415), HTTPStatusCode.unsupportedMediaType)
        XCTAssertEqual(HTTPStatusCode(rawValue: 416), HTTPStatusCode.rangeNotSatisfiable)
        XCTAssertEqual(HTTPStatusCode(rawValue: 417), HTTPStatusCode.expectationFailed)
        XCTAssertEqual(HTTPStatusCode(rawValue: 426), HTTPStatusCode.upgradeRequired)
        
        // Server Error 5xx
        XCTAssertEqual(HTTPStatusCode(rawValue: 500), HTTPStatusCode.internalServerError)
        XCTAssertEqual(HTTPStatusCode(rawValue: 501), HTTPStatusCode.notImplemented)
        XCTAssertEqual(HTTPStatusCode(rawValue: 502), HTTPStatusCode.badGateway)
        XCTAssertEqual(HTTPStatusCode(rawValue: 503), HTTPStatusCode.serviceUnavailable)
        XCTAssertEqual(HTTPStatusCode(rawValue: 504), HTTPStatusCode.gatewayTimeout)
        XCTAssertEqual(HTTPStatusCode(rawValue: 505), HTTPStatusCode.httpVersionNotSupported)
        
        XCTAssertEqual(HTTPStatusCode(rawValue: 600), HTTPStatusCode.custom(600))
    }
}
