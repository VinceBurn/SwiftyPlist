//
//  Plist.swift
//  PlistParsing
//
//  Created by Vincent Bernier on 21-08-2015.
//  Inspired by https://github.com/monyschuk/PropertyList
//  Copyright (c) 2015 Vincent Bernier. Use it a you see fit. No guarantee of support.
//

import Foundation
import Swift

public struct Plist {
    
    private let entityType : EntityType
    private enum EntityType {
        case String(Swift.String)
        case Number(NSNumber)
        case Date(NSDate)
        case Data(NSData)
        case Array([Plist])
        case Dictionary([Swift.String : Plist])
    }
    
    //MARK:- Entity Creation
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
    
    public init(data: NSData) {
        entityType = .Data(data)
    }
    
    public init(array: [Plist]) {
        entityType = .Array(array)
    }
    
    public init(dictionary: [String : Plist]) {
        entityType = .Dictionary(dictionary)
    }
    
}

//MARK:- Accessing Entity Values
public extension Plist {
    
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
    //TODO: Add convinience to get Int, Float and Bool
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
    public var data : NSData? {
        get {
            switch entityType {
            case let .Data(value):
                return value
            default:
                return nil;
            }
        }
    }
    public var array : [Plist]? {
        get {
            switch entityType {
            case let .Array(value):
                return value
            default:
                return nil;
            }
        }
    }
    public var dictionary : [String : Plist]? {
        get {
            switch entityType {
            case let .Dictionary(value):
                return value
            default:
                return nil;
            }
        }
    }
}



