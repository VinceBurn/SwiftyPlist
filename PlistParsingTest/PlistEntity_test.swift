//
//  PlistParsingTest.swift
//  PlistParsingTest
//
//  Created by Vincent Bernier on 21-08-2015.
//  Copyright (c) 2015 Vincent Bernier. All rights reserved.
//

import Cocoa
import XCTest
import PlistParsing

class PlistEntity_test: XCTestCase {
    
    
    func test_givenStringInput_whenCreation_thenReturnAPlistEntityWithStringProperty() {
        let p = PlistEntity(string: "hello")
        XCTAssertEqual(p.string!, "hello", "string is the provieded one")
        XCTAssertTrue(p.number == nil, "Only the provied input is given back")
    }
    
    func test_givenIntInput_whenCreation_thenReturnAPlistEntityWithNumberProperty() {
        let p = PlistEntity(int: 1)
        XCTAssertEqual(p.number as! Int, 1, "")
        XCTAssertTrue(p.string == nil, "Only the provied input is given back")
    }
    
    func test_givenFloatInput_whenCreation_thenCanGetTheValueBack() {
        let p = PlistEntity(float: 1.3)
        XCTAssertEqual(p.number as! Float, 1.3, "")
        XCTAssertTrue(p.string == nil, "Only the provied input is given back")
    }
    
}
