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
        case Date(NSDate)
    }
    
    private let entityType : EntityType
    
    public init(bool: Bool) {
        entityType = .Number(bool)
    }
    
    public init(int: Int) {
        entityType = .Number(int)
    }
    
    public init(float: Float) {
        entityType = .Number(float)
    }
    
    public init(string: String) {
        entityType = .String(string)
    }
    
    public init(date: NSDate) {
        entityType = .Date(date)
    }
    
    
}

//  Accessing Values
public extension PlistEntity {
    
    public var string : String? {
        get {
            switch entityType {
            case let .String(value):
                return value
            default:
                return nil;
            }
        }
    }
    public var number : NSNumber? {
        get {
            switch entityType {
            case let .Number(value):
                return value
            default:
                return nil;
            }
        }
    }
    public var date : NSDate? {
        get {
            switch entityType {
            case let .Date(value):
                return value
            default:
                return nil;
            }
        }
    }
}



