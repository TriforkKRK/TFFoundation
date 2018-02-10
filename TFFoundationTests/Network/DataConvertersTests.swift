//
//  DataConvertersTests.swift
//  TFFoundationTests
//
//  Created by Wojciech Nagrodzki on 10/02/2018.
//

import XCTest
@testable import TFFoundation

class DataConvertersTests: XCTestCase {
    
    func testDataToDataConverter() {
        let input = Data(bytes: [1, 2, 3, 4])
        let output = DataToDataConverter.makeInstance(from: input)
        XCTAssertEqual(input, output)
    }
    
    func testDataToUTF8StringConverter() {
        let input = Data(bytes: [65])
        let output = try? DataToUTF8StringConverter.makeInstance(from: input)
        XCTAssertEqual(output, "A")
    }
    
    func testDataToUTF8StringConverterError() {
        // see http://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-test.txt section 3.1.1
        let input = Data(bytes: [0x80])
        
        XCTAssertThrowsError(try DataToUTF8StringConverter.makeInstance(from: input)) { (error) in
            guard case DataToUTF8StringConverter.ConversionError.initializationFailed = error else {
                return XCTFail()
            }
        }
    }
    
    func testDataToImageConverter() {
        // 1x1 pixel bitmap with #aabbcc color
        let data = Data(bytes: [0x42, 0x4d, 0x3a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x36, 0x00,
                                0x00, 0x00, 0x28, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0xff, 0xff,
                                0xff, 0xff, 0x01, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                0x00, 0x00, 0x13, 0x0b, 0x00, 0x00, 0x13, 0x0b, 0x00, 0x00, 0x00, 0x00,
                                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xcc, 0xbb, 0xaa, 0xff])
        let image = try? DataToImageConverter.makeInstance(from: data)
        XCTAssertNotNil(image)
    }
    
    func testDataToImageConverterError() {
        let input = Data()
        XCTAssertThrowsError(try DataToImageConverter.makeInstance(from: input)) { (error) in
            guard case DataToImageConverter.ConversionError.initializationFailed = error else {
                return XCTFail()
            }
        }
    }
}
