//
//  Plist.swift
//  PlistParsing
//
//  Created by Vincent Bernier on 21-08-2015.
//  Copyright (c) 2015 Vincent Bernier. All rights reserved.
//

import Foundation
import Swift

public struct PlistEntity {
    
    private enum EntityType {
        case String(Swift.String)
        case Number(NSNumber)
    }
    
    private let entityType : EntityType
    
    public init(int: Int) {
        entityType = .Number(int)
    }
    
    public init(float: Float) {
        entityType = .Number(float)
    }
    
    public init(string: String) {
        entityType = .String(string)
    }
    
    
}

//  Accessing Values
public extension PlistEntity {
    
    var string : String? {
        get {
            switch entityType {
            case let .String(value):
                return value
            default:
                return nil;
            }
        }
    }
    var number : NSNumber? {
        get {
            switch entityType {
            case let .Number(value):
                return value
            default:
                return nil;
            }
        }
    }
}



