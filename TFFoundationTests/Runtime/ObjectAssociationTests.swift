//
//  ObjectAssociationTests.swift
//  TFFoundationTests
//
//  Created by Wojciech Nagrodzki on 09/02/2018.
//

import XCTest
@testable import TFFoundation

class ObjectAssociationTests: XCTestCase {
    
    func testObjcObjectAssociationOnObjcObject() {
        let value1 = ObjcClass()
        let value2 = ObjcClass()
        XCTAssertFalse(value1 === value2)
        
        let object = ObjcClass()
        object.associatedObjcObject = value1
        XCTAssert(object.associatedObjcObject === value1)
        
        object.associatedObjcObject = value2
        XCTAssert(object.associatedObjcObject === value2)
        
        object.associatedObjcObject = nil
        XCTAssertNil(object.associatedObjcObject)
    }
    
    func testObjcObjectAssociationOnSwiftObject() {
        let value1 = ObjcClass()
        let value2 = ObjcClass()
        XCTAssertFalse(value1 === value2)
        
        let object = SwiftClass()
        object.associatedObjcObject = value1
        XCTAssert(object.associatedObjcObject === value1)
        
        object.associatedObjcObject = value2
        XCTAssert(object.associatedObjcObject === value2)
        
        object.associatedObjcObject = nil
        XCTAssertNil(object.associatedObjcObject)
    }
    
    func testSwiftObjectAssociationOnObjcObject() {
        let value1 = SwiftClass()
        let value2 = SwiftClass()
        XCTAssertFalse(value1 === value2)
        
        let object = ObjcClass()
        object.associatedSwiftObject = value1
        XCTAssert(object.associatedSwiftObject === value1)
        
        object.associatedSwiftObject = value2
        XCTAssert(object.associatedSwiftObject === value2)
        
        object.associatedSwiftObject = nil
        XCTAssertNil(object.associatedSwiftObject)
    }
    
    func testSwiftObjectAssociationOnSwiftObject() {
        let value1 = SwiftClass()
        let value2 = SwiftClass()
        XCTAssertFalse(value1 === value2)
        
        let object = SwiftClass()
        object.associatedSwiftObject = value1
        XCTAssert(object.associatedSwiftObject === value1)
        
        object.associatedSwiftObject = value2
        XCTAssert(object.associatedSwiftObject === value2)
        
        object.associatedSwiftObject = nil
        XCTAssertNil(object.associatedSwiftObject)
    }
}

private class ObjcClass: NSObject {
    
}

private extension ObjcClass {
    private static let objcAssociation = ObjectAssociation<ObjcClass>()
    var associatedObjcObject: ObjcClass? {
        get { return ObjcClass.objcAssociation[self] }
        set { ObjcClass.objcAssociation[self] = newValue }
    }
}

private extension ObjcClass {
    private static let swiftAssociation = ObjectAssociation<SwiftClass>()
    var associatedSwiftObject: SwiftClass? {
        get { return ObjcClass.swiftAssociation[self] }
        set { ObjcClass.swiftAssociation[self] = newValue }
    }
}

private class SwiftClass {
    
}

private extension SwiftClass {
    private static let objcAssociation = ObjectAssociation<ObjcClass>()
    var associatedObjcObject: ObjcClass? {
        get { return SwiftClass.objcAssociation[self] }
        set { SwiftClass.objcAssociation[self] = newValue }
    }
}

private extension SwiftClass {
    private static let swiftAssociation = ObjectAssociation<SwiftClass>()
    var associatedSwiftObject: SwiftClass? {
        get { return SwiftClass.swiftAssociation[self] }
        set { SwiftClass.swiftAssociation[self] = newValue }
    }
}
