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
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "PListRootDic", withExtension: "plist")
        let plistDic = NSDictionary(contentsOf: url!)
        if plistDic == nil {
            print("ERROR while loading file from disk")
        }
        
        return plistDic!
    }
    
    func controlDateInFile() -> Date {
        var components = DateComponents()
        components.year = 2015
        components.month = 08
        components.day = 22
        components.hour = 20
        components.minute = 32
        components.second = 09
        let cal = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let controlDate = cal?.date(from: components)
        
        return controlDate!
    }
    
    func test_parsingAPlistDictionryDataFromPlistFile_givePlistObjectBySubscript() {
        let inputDic = plistDictionaryFromFile()
        let p = Plist(plistObject: inputDic)
        if let dic = p.dictionary,
            let str = p["string"]?.string,
            let int = p["int"]?.number as? Int,
            let float = p["float"]?.number as? Float,
            let bool = p["boolean"]?.number as? Bool,
            let date = p["date"]?.date,
            let array = p["array"]?.array,
            let str0 = p["array"]?[0].string,
            let str1 = p["array"]?[1].string {
                XCTAssertEqual(dic.count, 6, "")
                XCTAssertEqual(str, "string", "")
                XCTAssertEqual(int, 1, "")
                XCTAssertEqual(float, 1.1, "")
                XCTAssertEqual(bool, true, "")
                XCTAssertTrue(date as Date == controlDateInFile(), "")
                XCTAssertEqual(array.count, 2, "")
                XCTAssertEqual(str0, "string0", "")
                XCTAssertEqual(str1, "string1", "")
        } else { XCTFail("") }
    }
    
}
