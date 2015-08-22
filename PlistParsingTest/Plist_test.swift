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

// https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/PropertyLists/AboutPropertyLists/AboutPropertyLists.html

class Plist_test: XCTestCase {
    
    //MARK:- Convinience Helpers
    
    //MARK:- Entity Creation & Accessing Values
    func test_givenStringInput_whenCreation_thenCanGetTheValueBack() {
        let sut = Plist(string: "hello")
        XCTAssertEqual(sut.string!, "hello", "string is the provieded one")
        XCTAssertTrue(sut.number == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
    }
    
    func test_givenIntInput_whenCreation_thenCanGetTheValueBack() {
        let sut = Plist(int: 1)
        XCTAssertEqual(sut.number as! Int, 1, "")
        XCTAssertTrue(sut.string == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
    }
    
    func test_givenFloatInput_whenCreation_thenCanGetTheValueBack() {
        let sut = Plist(float: 1.3)
        XCTAssertEqual(sut.number as! Float, 1.3, "")
        XCTAssertTrue(sut.string == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
    }
    
    func test_givenBoolInput_whenCreation_thenCanGetTheValueBack() {
        let sut = Plist(bool: true)
        XCTAssertEqual(sut.number as! Bool, true, "")
        XCTAssertTrue(sut.string == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
    }
    
    func test_givenDateInput_whenCreation_thenCanGetTheValueBack() {
        let date = NSDate()
        let sut = Plist(date: date)
        if let result = sut.date {
            XCTAssertTrue(date.isEqualToDate(result), "")
        } else { XCTFail("Date is not nil") }
        XCTAssertTrue(sut.string == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.number == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
    }
    
    func test_giventDataInput_whenCreation_thenCanGetTheValueBack() {
        let data = "allo".dataUsingEncoding(NSUTF8StringEncoding)!
        let sut = Plist(data: data)
        if let result = sut.data {
            XCTAssertTrue(data.isEqualToData(result), "")
        } else { XCTFail("Data is not nil") }
        XCTAssertTrue(sut.string == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.number == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
}
    
    //NOTE: Remaining Array and Dictionary
    func test_givenEmptyArrayInput_whenCreation_thenCanGetTheValueBack() {
        let ar : [Plist] = []
        let sut = Plist(array: ar)
        if let result = sut.array {
            XCTAssertEqual(result.count, ar.count, "")
        } else { XCTFail("Array is not nil") }
        XCTAssertTrue(sut.string == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.number == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provided input is given back")
    }
    
    //  test with an array of stuff
}
