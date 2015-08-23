//
//  Plist_initegrationTest.swift
//  PlistParsing
//
//  Created by Vincent Bernier on 22-08-2015.
//  Copyright (c) 2015 Vincent Bernier. All rights reserved.
//

import Cocoa
import XCTest
import PlistParsing

class Plist_initegrationTest: XCTestCase {
    
    func plistDictionaryFromFile() -> NSDictionary {
        let bundle = NSBundle(forClass: self.dynamicType)
        let url = bundle.URLForResource("PListRootDic", withExtension: "plist")
        let plistDic = NSDictionary(contentsOfURL: url!)
        if plistDic == nil {
            println("ERROR while loading file from disk")
        }
        
        return plistDic!
    }
    
    func controlDateInFile() -> NSDate {
        let components = NSDateComponents()
        components.year = 2015
        components.month = 08
        components.day = 22
        components.hour = 20
        components.minute = 32
        components.second = 09
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let controlDate = cal?.dateFromComponents(components)
        
        return controlDate!
    }
    
    func test_parsingAPlistDictionryDataFromPlistFile_givePlistObjectBySubscript() {
        let inputDic = plistDictionaryFromFile()
        let p = Plist(plistObject: inputDic)
        if let dic = p.dictionary,
            str = p["string"]?.string,
            int = p["int"]?.number as? Int,
            float = p["float"]?.number as? Float,
            bool = p["boolean"]?.number as? Bool,
            date = p["date"]?.date,
            array = p["array"]?.array,
            str0 = p["array"]?[0].string,
            str1 = p["array"]?[1].string {
                XCTAssertEqual(dic.count, 6, "")
                XCTAssertEqual(str, "string", "")
                XCTAssertEqual(int, 1, "")
                XCTAssertEqual(float, 1.1, "")
                XCTAssertEqual(bool, true, "")
                XCTAssertTrue(date.isEqualToDate(controlDateInFile()), "")
                XCTAssertEqual(array.count, 2, "")
                XCTAssertEqual(str0, "string0", "")
                XCTAssertEqual(str1, "string1", "")
        } else { XCTFail("") }
    }
    
}
