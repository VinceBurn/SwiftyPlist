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
            let p = Plist(plistObject: s)
            ar.append(p)
        }
        
        let p = Plist(plistObject: ar)
        return p
    }
    
    func plistDicFromKeysValues(keysValues: [(String, String)]) -> Plist {
        var dic : [String : Plist] = [:]
        for (k, v) in keysValues {
            let p = Plist(plistObject: v)
            dic[k] = p
        }
        
        let p = Plist(plistObject: dic)
        return p
    }
    
    //MARK:- Entity Creation & Accessing Values
    func test_givenStringInput_whenCreation_thenCanGetTheValueBack() {
        let sut = Plist(plistObject: "hello")
        XCTAssertEqual(sut.string!, "hello", "string is the provieded one")
        XCTAssertTrue(sut.number == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    
    func test_givenIntInput_whenCreation_thenCanGetTheValueBack() {
        let sut = Plist(plistObject: 1)
        XCTAssertEqual(sut.number as! Int, 1, "")
        XCTAssertTrue(sut.string == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    
    func test_givenFloatInput_whenCreation_thenCanGetTheValueBack() {
        let sut = Plist(plistObject: 1.3)
        XCTAssertEqual(sut.number as! Float, 1.3, "")
        XCTAssertTrue(sut.string == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    
    func test_givenBoolInput_whenCreation_thenCanGetTheValueBack() {
        let sut = Plist(plistObject: true)
        XCTAssertEqual(sut.number as! Bool, true, "")
        XCTAssertTrue(sut.string == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    
    func test_givenDateInput_whenCreation_thenCanGetTheValueBack() {
        let date = NSDate()
        let sut = Plist(plistObject: date)
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
        let sut = Plist(plistObject: data)
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
        let sut = Plist(plistObject: ar)
        if let result = sut.array {
            XCTAssertEqual(result.count, ar.count, "")
        } else { XCTFail("Array is not nil") }
        XCTAssertTrue(sut.string == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.number == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    
    func test_givenEmptyNotCastedArrayInput_whenCreation_thenCanGetTheValueBack() {
        let ar = []
        let sut = Plist(plistObject: ar)
        if let result = sut.array {
            XCTAssertEqual(result.count, 0, "")
        } else { XCTFail("") }
    }
    
    func test_givenArrayOfArrayInput_whenCreation_thenCanGetTheValuesBack() {
        let sut = Plist(plistObject: [plistArrayFromStrings(["p0", "p1"])])
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
    
    func test_givenNotCastedArrayInput_whenCreation_thenCanGetTheValuesBack() {
        let ar = ["bob", 1, true]
        let sut = Plist(plistObject: ar)
        if let result = sut.array, p0 = result[0].string, p1 = result[1].number as? Int, p2 = result[2].number as? Bool {
            XCTAssertEqual(result.count, 3, "")
            XCTAssertEqual(p0, "bob", "")
            XCTAssertEqual(p1, 1, "")
            XCTAssertEqual(p2, true, "")
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
    
    func test_givenPlistInput_whenCreation_thenGetSamePlistValueBack() {
        let p = Plist(plistObject: "p")
        let sut = Plist(plistObject: p)
        if let result = sut.string {
            XCTAssertEqual(result, "p", "")
        } else { XCTFail("") }
    }
    
    func test_givenEmptyNSDictionaryInput_whenCreation_thenCanGetTheValueBack() {
        let dic = NSDictionary()
        let sut = Plist(plistObject: dic)
        if let result = sut.dictionary {
            XCTAssertEqual(result.count, 0, "")
        } else { XCTFail("") }
    }
    
    func test_givenNSDictionaryInput_whenCreation_thenCeanGetTheValueBack() {
        let date = NSDate()
        let dic = NSDictionary(objectsAndKeys: "p", "str", 1, "int", date, "date")
        let sut = Plist(plistObject: dic)
        if let r = sut.dictionary, ps = r["str"]?.string, pi = r["int"]?.number as? Int, pd = r["date"]?.date {
            XCTAssertEqual(r.count, 3, "")
            XCTAssertEqual(ps, "p", "")
            XCTAssertEqual(pi, 1, "")
            XCTAssertTrue(pd.isEqualToDate(date), "")
        } else { XCTFail("") }
    }
    
    func test_givenDictionaryStringInt_whenCreation_thenCanGetTheValueBack() {
        let inputDic = [ "val0" : 0, "val1" : 1]
        let sut = Plist(plistObject: inputDic)
        if let dic = sut.dictionary, num0 = dic["val0"]?.number as? Int, num1 = dic["val1"]?.number as? Int {
            XCTAssertEqual(dic.count, 2, "")
            XCTAssertEqual(num0, 0, "")
            XCTAssertEqual(num1, 1, "")
        } else { XCTFail("") }
    }
    
    //MARK:- 
    
    //MARK:- Subscripting Array
    func test_givenArrayPlist_whenReadSubscripting_thenRetreiveTheProperIndex() {
        let sut = plistArrayFromStrings(["p0", "p1"])
        if let result = sut[1].string {
            XCTAssertEqual(result, "p1", "")
        } else { XCTFail("") }
    }
    
    func test_givenArrayPlist_whenWriteSubscripting_thenSetTheProperIndex() {
        var sut = plistArrayFromStrings(["p0", "p1"])
        sut[0] = Plist(plistObject:"NEW")
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
        let p = Plist(plistObject: "new")
        sut["k"] = p
        if let pStr = sut.dictionary!["k"], result = pStr.string {
            XCTAssertEqual(result, "new", "")
        } else { XCTFail("") }
    }
    
    func test_givenDictionaryPlist_whenWriteSubscriptKeyInDic_thenOverrideExistingKey() {
        var sut = plistDicFromKeysValues([("key", "p")])
        sut["key"] =  Plist(plistObject: "NEW")
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
    
    //MARK:- Subscripting Chaining
    func test_givenDicArrayDicPlist_whenWriteOnExistingSubscript_theValueIsUpdated() {
        let raw = [ "ar" : [["key" : "value"]] ]
        var sut = Plist(plistObject: raw)
        sut["ar"]?[0]["key"] = Plist(plistObject: "NEW")
        if let val = sut["ar"]?[0]["key"]?.string {
            XCTAssertEqual(val, "NEW", "")
        } else { XCTFail("") }
    }
    
    
}
