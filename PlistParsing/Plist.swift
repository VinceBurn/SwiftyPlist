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
    
    /** Create a Plist from a Raw values that are Plist Convertible or Plist.
    @warning Will crash if not convertible
    */
    public init(plistObject: Any) {
        switch plistObject {
            
        case let string as String:
            self.entityType = .String(string)
            
        case let float as Float:
            self.entityType = .Number(float)
            
        case let double as Double:
            self.entityType = .Number(Float(double))
            
        case let date as NSDate:
            self.entityType = .Date(date)
            
        case let int as Int:
            self.entityType = .Number(int)
            
        case let bool as Bool:
            self.entityType = .Number(bool)
            
        case let data as NSData:
            self.entityType = .Data(data)
            
        case let plist as Plist:
            self.entityType = plist.entityType
           
        case let array as NSArray:
            var pAr : [Plist] = []
            for any in array {
                let p = Plist(plistObject: any)
                pAr.append(p)
            }
            self.entityType = .Array(pAr)
            
        case let array as [Plist]:
            self.entityType = .Array(array)
            
        case let dictionary as [String : Plist]:
            self.entityType = .Dictionary(dictionary)
            
        case let dictionary as NSDictionary:
            var dic : [String : Plist] = [:]
            for (k, value) in dictionary {
                if let key = k as? String {
                    let p = Plist(plistObject: value)
                    dic[key] = p
                } else {
                    assertionFailure("Key of dictionary must be String")
                }
            }
            
            self.entityType = .Dictionary(dic)
            
        default:
            print("value \(plistObject) is not a valid property list type")
            self.entityType = .String("")
            assertionFailure("Use only property list complient class.")
        }
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
//
//  NOTE: after that make a single public init : init(plistValue: AnyObject) // but only accepct plist type
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


