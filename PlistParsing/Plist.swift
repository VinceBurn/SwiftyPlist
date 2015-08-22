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
    
    private var entityType : EntityType
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

////  RawRepresentable protocol
//public extension Plist : RawRepresentable {
//    /// A type that can be converted to an associated "raw" type, then
//    /// converted back to produce an instance equivalent to the original.
//    protocol RawRepresentable {
//        
//        /// The "raw" type that can be used to represent all values of `Self`.
//        ///
//        /// Every distinct value of `self` has a corresponding unique
//        /// value of `RawValue`, but `RawValue` may have representations
//        /// that do not correspond to an value of `Self`.
//        typealias RawValue
//        
//        /// Convert from a value of `RawValue`, yielding `nil` iff
//        /// `rawValue` does not correspond to a value of `Self`.
//        init?(rawValue: RawValue)
//        
//        /// The corresponding value of the "raw" type.
//        ///
//        /// `Self(rawValue: self.rawValue)!` is equivalent to `self`.
//        var rawValue: RawValue { get }
//    }
//}

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

//MARK:- Subsripting Array
public extension Plist {
    subscript(index: Int) -> Plist {
        get {
            return self.array![index]
        }
        set(newValue) {
            var ar = self.array!
            ar[index] = newValue
            entityType = .Array(ar)
        }
    }
}

//MARK:- Subsripting Dictionary
public extension Plist {
    subscript(key: String) -> Plist? {
        get {
            return self.dictionary![key]
        }
        set(newValue) {
            var dic = self.dictionary!
            dic[key] = newValue
            entityType = .Dictionary(dic)
        }
    }
}


