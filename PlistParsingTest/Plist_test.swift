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
    func plistArrayFromStrings(strings: [String]) -> Plist {
        var ar : [Plist] = []
        for s in strings {
            let p = Plist(string: s)
            ar.append(p)
        }
        
        let p = Plist(array: ar)
        return p
    }
    
    func plistDicFromKeysValues(keysValues: [(String, String)]) -> Plist {
        var dic : [String : Plist] = [:]
        for (k, v) in keysValues {
            let p = Plist(string: v)
            dic[k] = p
        }
        
        let p = Plist(dictionary: dic)
        return p
    }
    
    //MARK:- Entity Creation & Accessing Values
    func test_givenStringInput_whenCreation_thenCanGetTheValueBack() {
        let sut = Plist(string: "hello")
        XCTAssertEqual(sut.string!, "hello", "string is the provieded one")
        XCTAssertTrue(sut.number == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    
    func test_givenIntInput_whenCreation_thenCanGetTheValueBack() {
        let sut = Plist(int: 1)
        XCTAssertEqual(sut.number as! Int, 1, "")
        XCTAssertTrue(sut.string == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    
    func test_givenFloatInput_whenCreation_thenCanGetTheValueBack() {
        let sut = Plist(float: 1.3)
        XCTAssertEqual(sut.number as! Float, 1.3, "")
        XCTAssertTrue(sut.string == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    
    func test_givenBoolInput_whenCreation_thenCanGetTheValueBack() {
        let sut = Plist(bool: true)
        XCTAssertEqual(sut.number as! Bool, true, "")
        XCTAssertTrue(sut.string == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
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
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
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
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    
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
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    
    func test_givenArrayOfArrayInput_whenCreation_thenCanGetTheValuesBack() {
        let sut = Plist(array: [plistArrayFromStrings(["p0", "p1"])])
        if let rAr = sut.array, let resultAr = rAr[0].array where resultAr.count == 2  {
            for var i = 0; i < resultAr.count; ++i {
                let s = resultAr[i]
                if let str = s.string {
                    let controlStr = "p\(i)"
                    XCTAssertEqual(str, controlStr, "")
                } else { XCTFail("") }
            }
        } else { XCTFail("") }
    }
    
    func test_givenEmptyDictionaryInput_whenCreation_thenCanGetTheValueBack() {
        let sut = plistDicFromKeysValues([])
        if let result = sut.dictionary {
            XCTAssertEqual(result.count, 0, "")
        } else { XCTFail("") }
        XCTAssertTrue(sut.string == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.number == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
    }
    
    func test_givenDictionaryInput_whenCreation_thenCanGetTheValueBack() {
        let sut = plistDicFromKeysValues([("key", "p")])
        if let rDic = sut.dictionary, let value = rDic["key"]?.string {
            XCTAssertEqual(value, "p", "")
        } else { XCTFail("") }
    }
    
    //MARK:- Subscripting Array
    func test_givenArrayPlist_whenReadSubscripting_thenRetreiveTheProperIndex() {
        let sut = plistArrayFromStrings(["p0", "p1"])
        if let result = sut[1].string {
            XCTAssertEqual(result, "p1", "")
        } else { XCTFail("") }
    }
    
    func test_givenArrayPlist_whenWriteSubscripting_thenSetTheProperIndex() {
        var sut = plistArrayFromStrings(["p0", "p1"])
        sut[0] = Plist(string:"NEW")
        if let rAr = sut.array, let p = rAr[0].string {
            XCTAssertEqual(p, "NEW", "")
        } else { XCTFail("") }
    }
    
    func test_givenArrayPlist_whenSubscriptingOutsideBound_thenAssertion() {
        //  CAN't be tested right now, there is not Assert Throw in Swift 1.2
    }
    
    //MARK:- Subscripting Dictionary
    func test_givenDictionaryPlist_whenReadSubscriptKeyNotInDic_thenNil() {
        let sut = plistDicFromKeysValues([])
        let result = sut["oups"]
        XCTAssertTrue(result == nil, "")
    }
    
    func test_givenDictionaryPlist_whenReadSubscripting_thenRetreiveTheProperValue() {
        let sut = plistDicFromKeysValues([("key", "p")])
        if let result = sut["key"]?.string {
            XCTAssertEqual(result, "p", "")
        } else { XCTFail("") }
    }
    
    func test_givenDictionaryPlist_whenWriteSubscriptKeyNotInDic_thenInsertNewItem() {
        var sut = plistDicFromKeysValues([])
        let p = Plist(string: "new")
        sut["k"] = p
        if let pStr = sut.dictionary!["k"], result = pStr.string {
            XCTAssertEqual(result, "new", "")
        } else { XCTFail("") }
    }
    
    func test_givenDictionaryPlist_whenWriteSubscriptKeyInDic_thenOverrideExistingKey() {
        var sut = plistDicFromKeysValues([("key", "p")])
        sut["key"] =  Plist(string: "NEW")
        if let pStr = sut.dictionary!["key"], result = pStr.string {
            XCTAssertEqual(result, "NEW", "")
        } else { XCTFail("") }
    }
    
    func test_givenDictionaryPlist_whenWriteSubscriptKeyInDicWithNil_thenRemoveExistingKey() {
        var sut = plistDicFromKeysValues([("key", "p")])
        sut["key"] = nil
        let result = sut["key"]
        XCTAssertTrue(result == nil, "")
    }
    
    
    
}
