//
//  Plist.swift
//  PlistParsing
//
//  Created by Vincent Bernier on 21-08-2015.
//  Copyright (c) 2015 Vincent Bernier. All rights reserved.
//

import Foundation

public struct PlistEntity {
    
    public init(int: Int) {
        self.string = nil;
        self.number = int
    }
    
    public init(string: String) {
        self.string = string
        self.number = nil;
    }
    
    let number : NSNumber?
    let string : String?
    
    
}



