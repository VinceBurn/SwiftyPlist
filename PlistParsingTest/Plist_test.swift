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
    
    //MARK:- Entity Creation Asserts
    func assert_givenStringInput_whenCreation_thenCanGetTheValueBack(creation: (Any) -> Plist) {
        let sut = creation("hello")
        XCTAssertEqual(sut.string!, "hello", "string is the provieded one")
        XCTAssertTrue(sut.number == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    func assert_givenIntInput_whenCreation_thenCanGetTheValueBack(creation: (Any) -> Plist) {
        let sut = creation(1)
        XCTAssertEqual((sut.number as! Int), 1, "")
        XCTAssertTrue(sut.string == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    func assert_givenFloatInput_whenCreation_thenCanGetTheValueBack(creation: (Any) -> Plist) {
        let sut = creation(Float(1.3))
        XCTAssertEqual((sut.number as! Float), 1.3, "")
        XCTAssertTrue(sut.string == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    func assert_givenDoubleInput_whenCreation_thenCanGetTheValueBack(creation: (Any) -> Plist) {
        let sut = creation(Double(1.3))
        XCTAssertEqual((sut.number as! Float), 1.3, "")
        XCTAssertTrue(sut.string == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    func assert_givenBoolInput_whenCreation_thenCanGetTheValueBack(creation: (Any) -> Plist) {
        let sut = creation(true)
        XCTAssertEqual((sut.number as! Bool), true, "")
        XCTAssertTrue(sut.string == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    func assert_givenDateInput_whenCreation_thenCanGetTheValueBack(creation: (Any) -> Plist) {
        let date = NSDate()
        let sut = creation(date)
        if let result = sut.date {
            XCTAssertTrue(date.isEqualToDate(result), "")
        } else { XCTFail("Date is not nil") }
        XCTAssertTrue(sut.string == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.number == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.data == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    func assert_givenDataInput_whenCreation_thenCanGetTheValueBack(creation: (Any) -> Plist) {
        let data = "allo".dataUsingEncoding(NSUTF8StringEncoding)!
        let sut = creation(data)
        if let result = sut.data {
            XCTAssertTrue(data.isEqualToData(result), "")
        } else { XCTFail("Data is not nil") }
        XCTAssertTrue(sut.string == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.number == nil, "Only the provied input is given back")
        XCTAssertTrue(sut.date == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.array == nil, "Only the provided input is given back")
        XCTAssertTrue(sut.dictionary == nil, "Only the provided input is given back")
    }
    func assert_givenEmptyNotCastedArrayInput_whenCreation_thenCanGetTheValueBack(creation: (Any) -> Plist) {
        let sut = creation([])
        if let result = sut.array {
            XCTAssertEqual(result.count, 0, "")
        } else { XCTFail("") }
    }
    func assert_givenNotCastedArrayInput_whenCreation_thenCanGetTheValuesBack(creation: (Any) -> Plist) {
        let ar = ["bob", 1, true]
        let sut = creation(ar)
        if let result = sut.array, p0 = result[0].string, p1 = result[1].number as? Int, p2 = result[2].number as? Bool {
            XCTAssertEqual(result.count, 3, "")
            XCTAssertEqual(p0, "bob", "")
            XCTAssertEqual(p1, 1, "")
            XCTAssertEqual(p2, true, "")
        } else { XCTFail("") }
    }
    func assert_givenEmptyNSDictionaryInput_whenCreation_thenCanGetTheValueBack(creation: (Any) -> Plist) {
        let dic = NSDictionary()
        let sut = creation(dic)
        if let result = sut.dictionary {
            XCTAssertEqual(result.count, 0, "")
        } else { XCTFail("") }
    }
    func assert_givenNSDictionaryInput_whenCreation_thenCeanGetTheValueBack(creation: (Any) -> Plist) {
        let date = NSDate()
        let dic : [ String : AnyObject ] = [ "str" : "p", "int" : 1, "date" : date  ]
        let sut = creation(dic)
        if let r = sut.dictionary, ps = r["str"]?.string, pi = r["int"]?.number as? Int, pd = r["date"]?.date {
            XCTAssertEqual(r.count, 3, "")
            XCTAssertEqual(ps, "p", "")
            XCTAssertEqual(pi, 1, "")
            XCTAssertTrue(pd.isEqualToDate(date), "")
        } else { XCTFail("") }
    }
    func assert_givenDictionaryStringInt_whenCreation_thenCanGetTheValueBack(creation: (Any) -> Plist) {
        let inputDic = [ "val0" : 0, "val1" : 1]
        let sut = creation(inputDic)
        if let dic = sut.dictionary, num0 = dic["val0"]?.number as? Int, num1 = dic["val1"]?.number as? Int {
            XCTAssertEqual(dic.count, 2, "")
            XCTAssertEqual(num0, 0, "")
            XCTAssertEqual(num1, 1, "")
        } else { XCTFail("") }
    }
    
    //MARK:- Entity Creation & Accessing Values
    func creation(any: Any) -> Plist {
        return Plist(plistObject: any)
    }
    
    func test_givenStringInput_whenCreation_thenCanGetTheValueBack() {
        assert_givenStringInput_whenCreation_thenCanGetTheValueBack(creation)
    }
    
    func test_givenIntInput_whenCreation_thenCanGetTheValueBack() {
        assert_givenIntInput_whenCreation_thenCanGetTheValueBack(creation)
    }
    
    func test_givenFloatInput_whenCreation_thenCanGetTheValueBack() {
        assert_givenFloatInput_whenCreation_thenCanGetTheValueBack(creation)
    }
    
    func test_givenDoubleInput_whenCreation_thenCanGetTheValueBack() {
        assert_givenDoubleInput_whenCreation_thenCanGetTheValueBack(creation)
    }
    
    func test_givenBoolInput_whenCreation_thenCanGetTheValueBack() {
        assert_givenBoolInput_whenCreation_thenCanGetTheValueBack(creation)
    }
    
    func test_givenDateInput_whenCreation_thenCanGetTheValueBack() {
        assert_givenDateInput_whenCreation_thenCanGetTheValueBack(creation)
    }
    
    func test_givenDataInput_whenCreation_thenCanGetTheValueBack() {
        assert_givenDataInput_whenCreation_thenCanGetTheValueBack(creation)
    }
    
    func test_givenEmptyNotCastedArrayInput_whenCreation_thenCanGetTheValueBack() {
        assert_givenEmptyNotCastedArrayInput_whenCreation_thenCanGetTheValueBack(creation)
    }
    
    func test_givenNotCastedArrayInput_whenCreation_thenCanGetTheValuesBack() {
        assert_givenNotCastedArrayInput_whenCreation_thenCanGetTheValuesBack(creation)
    }
    
    func test_givenEmptyNSDictionaryInput_whenCreation_thenCanGetTheValueBack() {
        assert_givenEmptyNSDictionaryInput_whenCreation_thenCanGetTheValueBack(creation)
    }
    
    func test_givenNSDictionaryInput_whenCreation_thenCeanGetTheValueBack() {
        assert_givenNSDictionaryInput_whenCreation_thenCeanGetTheValueBack(creation)
    }
    
    func test_givenDictionaryStringInt_whenCreation_thenCanGetTheValueBack() {
        assert_givenDictionaryStringInt_whenCreation_thenCanGetTheValueBack(creation)
    }
    
    //MARK: Plist passed in the input somewhere
    func test_givenPlistInput_whenCreation_thenGetSamePlistValueBack() {
        let p = Plist(plistObject: "p")
        let sut = Plist(plistObject: p)
        if let result = sut.string {
            XCTAssertEqual(result, "p", "")
        } else { XCTFail("") }
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
    
    //MARK:- RawRepresentable [init]
    func rawCreation(any: Any) -> Plist {
        return Plist(rawValue: any)!
    }
    func newRawCreation(any: Any) -> Plist {
        return Plist.newWithRawValue(any)
    }
    
    func test_givenStringInput_whenRawCreation_thenCanGetTheValueBack() {
        assert_givenStringInput_whenCreation_thenCanGetTheValueBack(rawCreation)
        assert_givenStringInput_whenCreation_thenCanGetTheValueBack(newRawCreation)
    }
    
    func test_givenIntInput_whenRawCreation_thenCanGetTheValueBack() {
        assert_givenIntInput_whenCreation_thenCanGetTheValueBack(rawCreation)
        assert_givenIntInput_whenCreation_thenCanGetTheValueBack(newRawCreation)
    }
    
    func test_givenFloatInput_whenRawCreation_thenCanGetTheValueBack() {
        assert_givenFloatInput_whenCreation_thenCanGetTheValueBack(rawCreation)
        assert_givenFloatInput_whenCreation_thenCanGetTheValueBack(newRawCreation)
    }
    
    func test_givenDoubleInput_whenRawCreation_thenCanGetTheValueBack() {
        assert_givenDoubleInput_whenCreation_thenCanGetTheValueBack(rawCreation)
        assert_givenDoubleInput_whenCreation_thenCanGetTheValueBack(newRawCreation)
    }
    
    func test_givenBoolInput_whenRawCreation_thenCanGetTheValueBack() {
        assert_givenBoolInput_whenCreation_thenCanGetTheValueBack(rawCreation)
        assert_givenBoolInput_whenCreation_thenCanGetTheValueBack(newRawCreation)
    }
    
    func test_givenDateInput_whenRawCreation_thenCanGetTheValueBack() {
        assert_givenDateInput_whenCreation_thenCanGetTheValueBack(rawCreation)
        assert_givenDateInput_whenCreation_thenCanGetTheValueBack(newRawCreation)
    }
    
    func test_givenDataInput_whenRawCreation_thenCanGetTheValueBack() {
        assert_givenDataInput_whenCreation_thenCanGetTheValueBack(rawCreation)
        assert_givenDataInput_whenCreation_thenCanGetTheValueBack(newRawCreation)
    }
    
    func test_givenEmptyNotCastedArrayInput_whenRawCreation_thenCanGetTheValueBack() {
        assert_givenEmptyNotCastedArrayInput_whenCreation_thenCanGetTheValueBack(rawCreation)
        assert_givenEmptyNotCastedArrayInput_whenCreation_thenCanGetTheValueBack(newRawCreation)
    }
    
    func test_givenNotCastedArrayInput_whenRawCreation_thenCanGetTheValuesBack() {
        assert_givenNotCastedArrayInput_whenCreation_thenCanGetTheValuesBack(rawCreation)
        assert_givenNotCastedArrayInput_whenCreation_thenCanGetTheValuesBack(newRawCreation)
    }
    
    func test_givenEmptyNSDictionaryInput_whenRawCreation_thenCanGetTheValueBack() {
        assert_givenEmptyNSDictionaryInput_whenCreation_thenCanGetTheValueBack(rawCreation)
        assert_givenEmptyNSDictionaryInput_whenCreation_thenCanGetTheValueBack(newRawCreation)
    }
    
    func test_givenNSDictionaryInput_whenRawCreation_thenCeanGetTheValueBack() {
        assert_givenNSDictionaryInput_whenCreation_thenCeanGetTheValueBack(rawCreation)
        assert_givenNSDictionaryInput_whenCreation_thenCeanGetTheValueBack(newRawCreation)
    }
    
    func test_givenDictionaryStringInt_whenRawCreation_thenCanGetTheValueBack() {
        assert_givenDictionaryStringInt_whenCreation_thenCanGetTheValueBack(rawCreation)
        assert_givenDictionaryStringInt_whenCreation_thenCanGetTheValueBack(newRawCreation)
    }
    
    //MARK: Failed [init]
    func nonPropertyListItems() -> NSArray {
        return [ NSDateComponents(), NSNull(), NSScanner() ]
    }
    
    func test_givenNonPropertyListIten_whenRawCreation_thenNil() {
        for item in nonPropertyListItems() {
            let sut = Plist(rawValue: item)
            XCTAssertTrue(sut == nil, "")
        }
    }
    
    func test_givenPlistInput_whenRawCreation_thenNil() {
        let p = Plist(rawValue: "str")!
        let sut = Plist(rawValue: p)
        XCTAssertTrue(sut == nil, "Plist is not a Raw type for a Property list")
    }
    
    func test_givenArrayOfNonPropertyListItem_whenRawCreation_thenNil() {
        let sut = Plist(rawValue: nonPropertyListItems())
        XCTAssertTrue(sut == nil, "")
    }
    
    func test_givenArrayOfArrayOfNonPropertyList_whenRawCreation_thenNil() {
        let rootAr = [ 1, 2.3, nonPropertyListItems(), "String"]
        let sut = Plist(rawValue: rootAr)
        XCTAssertTrue(sut == nil)
    }
    
    func test_givenArrayOfPlistArray_whenRawCreation_thenNil() {
        let ar = [plistArrayFromStrings(["1", "2"])]
        let sut = Plist(rawValue: ar)
        XCTAssertTrue(sut == nil, "")
    }
    
    func test_givenDictionaryOfNonPropertyListItem_whenRawCreation_thenNil() {
        let dic = [ "key0" : NSDateComponents(), "null" : NSNull(), "scan" : NSScanner()]
        let sut = Plist(rawValue: dic)
        XCTAssertTrue(sut == nil, "")
    }
    
    func test_givenDictionaryWithNonStringKey_whenRawCreation_thenNil() {
        let dic = [ "valid" : "bonjour", 1 : "not valid key for this value" ]
        let sut = Plist(rawValue: dic)
        XCTAssertTrue(sut == nil, "")
    }
    
    func test_givenDictionaryOfDicOfNonPropertyList_whenRawCreation_thenNil() {
        let innerDic = [ "key0" : NSDateComponents(), "null" : NSNull(), "scan" : NSScanner()]
        let dic = [ "key" : 1, "not plist complient dic" : innerDic, "k" : "v" ]
        let sut = Plist(rawValue: dic)
        XCTAssertTrue(sut == nil, "")
    }
    
    func test_givenDicOfDicWithNonStringKey_whenRawCreation_thenNil() {
        let innerDic = [ "good" : "ok", 1 : "NOT Good", "ok" : "ok"]
        let dic = [ "good" : "ok", "innerDic" : innerDic]
        let sut = Plist(rawValue: dic)
        XCTAssertTrue(sut == nil, "")
    }
    
    func test_givenDicOfPlist_whenRawCreation_thenNil() {
        let dic = ["key" : plistDicFromKeysValues([("key", "value")])]
        let sut = Plist(rawValue: dic)
        XCTAssertTrue(sut == nil, "Plist is not a raw type")
    }
    
    //MARK:- RawRepresentable [rawValue]
    func test_givenStringPlist_whenRawValue_thenString() {
        let p = Plist.newWithRawValue("s")
        if let sut = p.rawValue as? String {
            XCTAssertEqual(sut, "s", "")
        } else { XCTFail("") }
    }
    
    func test_givenNumberPlist_whenRawValue_thenNumber() {
        let num = NSNumber(integer: 3)
        let p = Plist.newWithRawValue(num)
        if let sut = p.rawValue as? NSNumber {
            let i = sut as Int, f = sut as Float, b = sut as Bool
            XCTAssertTrue(sut.isEqualToNumber(num), "")
            XCTAssertEqual(i, 3, "")
            XCTAssertEqual(f, Float(3), "")
            XCTAssertEqual(b, Bool(3), "")
            XCTAssertTrue(b, "")
        } else { XCTFail("") }
    }
    
    func test_givenDatePlist_whenRawValue_thenDate() {
        let date = NSDate()
        let p = Plist.newWithRawValue(date)
        if let sut = p.rawValue as? NSDate {
            XCTAssertTrue(sut.isEqualToDate(date), "")
        } else { XCTFail("") }
    }
    
    func test_givenDataPlist_whenRawValue_thenData() {
        let data = "allo".dataUsingEncoding(NSUTF8StringEncoding)!
        let p = Plist.newWithRawValue(data)
        if let sut = p.rawValue as? NSData {
            XCTAssertTrue(sut.isEqualToData(data), "")
        } else { XCTFail("") }
    }
    
    func test_givenEmptyArrayPlist_whenRawValue_thenNSArray() {
        let p = Plist.newWithRawValue([])
        if let sut = p.rawValue as? NSArray {
            XCTAssertEqual(sut.count, 0, "")
        } else { XCTFail("") }
    }
    
    func test_givenFilledArrayPlist_whenRawValue_thenNSArray() {
        let date = NSDate()
        let ar = ["str", 1, date]
        let p = Plist.newWithRawValue(ar)
        if let sut = p.rawValue as? NSArray, str = sut[0] as? String, i = sut[1] as? Int, d = sut[2] as? NSDate {
            XCTAssertEqual(str, "str", "")
            XCTAssertEqual(i, 1, "")
            XCTAssertTrue(d.isEqualToDate(date), "")
        } else { XCTFail("") }
    }
    
    func test_givenEmptyDicPlist_whenRawValue_thenNSDictionary() {
        let p = Plist.newWithRawValue([:])
        if let sut = p.rawValue as? NSDictionary {
            XCTAssertEqual(sut.count, 0, "")
        } else { XCTFail("") }
    }
    
    func test_givenFilledDicPlist_whenRawValue_thenNSDictionary() {
        let date = NSDate()
        let ar = ["in ar"];
        let dic = [ "date" : date, "int" : 1, "ar" : ar, "str" : "allo!"]
        let p = Plist.newWithRawValue(dic)
        if let sut = p.rawValue as? NSDictionary, d = sut["date"] as? NSDate, a = sut["ar"] as? NSArray {
            XCTAssertTrue(d.isEqualToDate(date), "")
            XCTAssertEqual(a.count, 1, "")
            XCTAssertEqual(sut.count, 4, "")
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
    func test_givenDicArrayDicPlist_whenWriteOnExistingSubscript_thenValueIsUpdated() {
        let raw = [ "ar" : [["key" : "value"]] ]
        var sut = Plist(plistObject: raw)
        sut["ar"]?[0]["key"] = Plist(plistObject: "NEW")
        if let val = sut["ar"]?[0]["key"]?.string {
            XCTAssertEqual(val, "NEW", "")
        } else { XCTFail("") }
    }
    
    //MARK:- Equatable
    func assert_equalityFalseWithRawValues(left left: Any, right: Any, message: String) {
        let lp = Plist.newWithRawValue(left)
        let rp = Plist.newWithRawValue(right)
        XCTAssertNotEqual(lp, rp, message)
    }
    
    func assert_eqaulityTrueRawValue(left left: Any, right: Any, message: String) {
        let lp = Plist.newWithRawValue(left)
        let rp = Plist.newWithRawValue(right)
        
        XCTAssertEqual(lp, rp, message)
    }
    
    func test_givenStringAndNumber_whenEqual_thenFalse() {
        assert_equalityFalseWithRawValues(left: "s", right: 1, message: "string and int")
    }
    
    func test_givenSameStringValue_whenEqual_thenTrue() {
        assert_eqaulityTrueRawValue(left: "s", right: "s", message: "string and string")
    }
    
    func test_givenDifferentStringValue_whenEqual_thenFalse() {
        assert_equalityFalseWithRawValues(left: "a", right: "b", message: "string and string")
    }
    
    func test_givenSameIntValue_whenEqual_thenTrue() {
        assert_eqaulityTrueRawValue(left: 5, right: 5, message: "Int and Int")
    }
    
    func test_givenDifferentIntValue_whenEqual_thenFalse() {
        assert_equalityFalseWithRawValues(left: 2, right: 3, message: "Int and Int")
    }
    
    func test_givenSameFloatValue_whenEqual_thenTrue() {
        assert_eqaulityTrueRawValue(left: Float(2.2), right:Float(2.2) , message: "Float and Float")
    }
    
    func test_givenDifferentFloatValue_whenEqual_thenFalse() {
        assert_equalityFalseWithRawValues(left: Float(2.2), right: Float(2.1), message: "Float and Float")
    }
    
    func test_givenSameBoolValue_whenEqual_thenTrue() {
        assert_eqaulityTrueRawValue(left: true, right: true, message: "bool and bool")
        assert_eqaulityTrueRawValue(left: false, right: false, message: "bool and bool")
    }
    
    func test_givenDifferentBoolValue_whenEqual_thenFalse() {
        assert_equalityFalseWithRawValues(left: true, right: false, message: "bool and bool")
        assert_equalityFalseWithRawValues(left: false, right: true, message: "bool and bool")
    }
    
    func test_givenSameDateValue_whenEqual_thenTrue() {
        assert_eqaulityTrueRawValue(left: NSDate(timeIntervalSince1970: 3), right: NSDate(timeIntervalSince1970: 3), message: "date and date")
    }
    
    func test_giventDifferentDate_whenEqual_thenFalse() {
        assert_equalityFalseWithRawValues(left: NSDate(timeIntervalSince1970: 3), right: NSDate(timeIntervalSince1970: 4), message: "Date and Date")
    }
    
    func test_givenSameDataValue_whenEqual_thenTrue() {
        let data = "allo".dataUsingEncoding(NSUTF8StringEncoding)!
        assert_eqaulityTrueRawValue(left: data, right: data, message: "data and data")
    }
    
    func test_givenDifferentDataValue_whenEqual_thenFalse() {
        let left = "allo".dataUsingEncoding(NSUTF8StringEncoding)!
        let right = "alloa".dataUsingEncoding(NSUTF8StringEncoding)!
        assert_equalityFalseWithRawValues(left: left, right: right, message: "data and data")
    }
    
    func test_givenSameDeepArray_whenEqual_thenTrue() {
        assert_eqaulityTrueRawValue(left: ["0", "1"], right: ["0", "1"], message: "Array and Array[String]")
        assert_eqaulityTrueRawValue(left: [0, 1], right: [0, 1], message: "Array and Array[Int]")
        assert_eqaulityTrueRawValue(left: [true, false, false], right: [true, false, false], message: "Array and Array[bool]")
        assert_eqaulityTrueRawValue(left: [5, "8", false], right: [5, "8", false], message: "")
        assert_eqaulityTrueRawValue(left: [5, ["8", false]], right: [5, ["8", false]], message: "")
    }
    
    func test_givenDifferentDeepArray_whenEqual_thenFalse() {
        assert_equalityFalseWithRawValues(left: [1, 2], right: [0, 1], message: "")
        assert_equalityFalseWithRawValues(left: [true, false], right: [false, false], message: "")
        assert_equalityFalseWithRawValues(left: [1, 2, [3, ""], []], right: [], message: "")
        assert_equalityFalseWithRawValues(left: [1, 2, [3, ""], []], right: [1, 2, [3, "BOB"], []], message: "")
    }
    
    func test_givenSameDeepDictionary_whenEqual_thenTrue() {
        let date = NSDate()
        assert_eqaulityTrueRawValue(left: [ "0" : 0, "1" : "bob", "date" : date], right: [ "0" : 0, "1" : "bob", "date" : date], message: "")
        // ADD MORE TEST
    }
    
    func test_givenDifferentDeepDictionary_whenEqyal_thenFalse() {
        let date = NSDate()
        assert_equalityFalseWithRawValues(left: [ "0" : 0, "1" : "bob", "date" : date], right: [ "0" : 0, "1" : "bob!", "date" : date], message: "")
        //  ADD MORE TEST
    }
    
    //MARK:- For in support [SequenceType]
    //MARK: No Iteration
    func assert_givenPlist_whenGenerate_thenNoIteration(p: Plist, message: String) {
        let gen = p.generate()
        var counter = 0
        for _ in p {
            ++counter
        }
        XCTAssertEqual(counter, 0, message)
        XCTAssertTrue(gen.next() == nil, message)
    }
    
    func assert_givenNonSequencePlist_whenGenerate_thenNoIteration(p: Plist) {
        let message = "\(p.rawValue) is not a SequenceType to iterate over"
        assert_givenPlist_whenGenerate_thenNoIteration(p, message: message)
    }
    
    func assert_givenEmptySequencePlist_whenGenerate_thenNoIteration(p: Plist) {
        let message = "\(p.rawValue) : empty collection won't have iteration"
        assert_givenPlist_whenGenerate_thenNoIteration(p, message: message)
    }
    
    func test_givenStringPlist_whenGenerate_thenGeneratorReturnNil() {
        assert_givenNonSequencePlist_whenGenerate_thenNoIteration(Plist.newWithRawValue("0"))
    }
    
    func test_givenDatePlist_whenGenerate_thenNoIteration() {
        assert_givenNonSequencePlist_whenGenerate_thenNoIteration(Plist.newWithRawValue(NSDate()))
    }
    
    func test_givenDataPlist_whenGenerate_thenNoIteration() {
        let data = "a".dataUsingEncoding(NSUTF8StringEncoding)!
        assert_givenNonSequencePlist_whenGenerate_thenNoIteration(Plist.newWithRawValue(data))
    }
    
    func test_givenIntPlist_whenGenerate_thenNoIteration() {
        assert_givenNonSequencePlist_whenGenerate_thenNoIteration(Plist.newWithRawValue(44))
    }
    
    func test_givenFloatPlist_whenGenerate_thenNoIteration() {
        assert_givenNonSequencePlist_whenGenerate_thenNoIteration(Plist.newWithRawValue(Float(44.4)))
        assert_givenNonSequencePlist_whenGenerate_thenNoIteration(Plist.newWithRawValue(Double(44.4)))
    }
    
    func test_givenBoolPlist_whenGenerate_thenNoIteration() {
        assert_givenNonSequencePlist_whenGenerate_thenNoIteration(Plist.newWithRawValue(true))
        assert_givenNonSequencePlist_whenGenerate_thenNoIteration(Plist.newWithRawValue(false))
    }
    
    func test_givenEmptyArray_whenGenerate_thenNoIteration() {
        assert_givenNonSequencePlist_whenGenerate_thenNoIteration(Plist.newWithRawValue([]))
    }
    
    //MARK: Iteration
    func test_givenPopulatedArray_whenGenerate_thenIteration() {
        let ar = [ "0", "1", "2"]
        let p = Plist.newWithRawValue(ar)
        
        let gen = p.generate()
        var counter = 0
        for (key, plist) in p {
            XCTAssertEqual(plist.string!, ar[counter], "Plist are retreive in the array's order")
            let str = "\(counter)"
            XCTAssertEqual(key, str, "The key is a string representation of the index")
            gen.next()
            ++counter
        }
        
        let message = "The count of items at the output match the input count"
        XCTAssertEqual(counter, ar.count, message)
        XCTAssertTrue(gen.next() == nil, message)
    }
    
    func test_givenPopulatedDictionary_whenGenerate_thenIteration() {
        let dic = ["1" : 1, "3" : 3]
        let p = Plist.newWithRawValue(dic)
        
        let gen = p.generate()
        var values = [String : Int]()
        for (key, plist) in p {
            let str = "\(plist.number as! Int)"
            values[key] = (plist.number as! Int)
            XCTAssertEqual(key, str, "")
            gen.next()
        }
        
        XCTAssertEqual(dic, values, "")
    }
    
}
