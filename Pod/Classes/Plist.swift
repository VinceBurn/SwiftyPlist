//
//  Plist.swift
//  PlistParsing
//
//  Created by Vincent Bernier on 21-08-2015.
//  Inspired by https://github.com/monyschuk/PropertyList
//  Copyright (c) 2015 Vincent Bernier. Use it as you see fit. No guarantee of support.
//

import Foundation
import Swift

/** Goal : Represent the **node** and **leaf** of a Plist tree */
public struct Plist {
    
    fileprivate var entityType : EntityType
    fileprivate enum EntityType {
        case string(String)
        case number(NSNumber)
        case date(Date)
        case data(Data)
        case array([Plist])
        case dictionary([String : Plist])
    }
    
    //MARK:- Entity Creation
    
    /** Create a Plist from values that are Plist Convertible or Plist.
    - parameter plistObject: Accepted input are Plist compatible classes and Plist structs
    - note: this is similar to init?(rawValue), but will also allow Plist, [Plist] and [String : Plist] as input
        -->(NOTE TO SELF: is this necessary or usefull... Well... It is when you need to add or remove entity from a .Array)
    - warning: Will crash if not convertible
    */
    public init(plistObject: Any) {
        switch plistObject {
            
        case let string as String:
            self.entityType = .string(string)
            
        case let num as NSNumber:
            self.entityType = .number(num)
            
        case let date as Date:
            self.entityType = .date(date)
            
        case let data as Data:
            self.entityType = .data(data)
            
        case let plist as Plist:
            self.entityType = plist.entityType
           
        case let array as NSArray:
            var pAr : [Plist] = []
            for any in array {
                let p = Plist(plistObject: any)
                pAr.append(p)
            }
            self.entityType = .array(pAr)
            
        case let array as [Plist]:
            self.entityType = .array(array)
            
        case let dictionary as [String : Plist]:
            self.entityType = .dictionary(dictionary)
            
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
            self.entityType = .dictionary(dic)
            
        default:
            print("value \(plistObject) is not a valid property list type", terminator: "\n")
            self.entityType = .string("")
            assertionFailure("Use only property list complient class.")
        }
    }
}

//MARK:-  RawRepresentable protocol
/** Convert from and to Cocoa type.
Use to convert from and to Swift and Foundation Plist type (String, NSNumber, NSDate, NSData, NSArray, NSDictionary (Dictionary key must be String)) to a Plist tree. */
extension Plist : RawRepresentable {
    
    /** Designited Creation Method
    :discussion: Take an input of Swift and Foundation Plist type (String, NSNumber, NSDate, NSData, NSArray, NSDictionary (Dictionary key must be String)) and output a Plist tree.
    */
    public init?(rawValue: Any) {
        switch rawValue {
            
        case let string as String:
            self.entityType = .string(string)
            
        case let num as NSNumber:
            self.entityType = .number(num)
            
        case let date as Date:
            self.entityType = .date(date)
            
        case let data as Data:
            self.entityType = .data(data)
            
        case let array as NSArray:
            var pAr : [Plist] = []
            for any in array {
                if let p = Plist(rawValue: any) {
                    pAr.append(p)
                } else {
                    return nil
                }
            }
            self.entityType = .array(pAr)
            
        case let dictionary as NSDictionary:
            var dic : [String : Plist] = [:]
            for (k, value) in dictionary {
                if let key = k as? String, let p = Plist(rawValue: value) {
                    dic[key] = p
                } else {
                    return nil
                }
            }
            self.entityType = .dictionary(dic)
            
        default:
            return nil
        }
    }
    
    /** Convenience method to unwrap the result of init?(rawValue:)
    - warning: Method will crash if an error occure */
    public static func newWithRawValue(_ rawValue: Any) -> Plist {
        return Plist(rawValue: rawValue)!
    }
    
    /** Convert back a Plist to it's Raw representation */
    public var rawValue: Any {
        //NOTE -->  Consider moving rawValue to AnyObject or to a PlistConvertibleProtocol, for which the possible class need to have extension
        get {
            switch entityType {
            case .string(let value):
                return value
            case .number(let value):
                return value
            case .date(let value) :
                return value
            case .data(let value):
                return value
            case .array(let value):
                var output = [Any]()
                for p in value {
                        output.append(p.rawValue)
                }
                return output
            case .dictionary(let value):
                var output = [String : Any]()
                for (key, val) in value {
                    output[key] = val.rawValue
                }
                return output
            }
        }
    }
}

//MARK:- Accessing Entity Values
/** Provide readonly access to **leaf** and **node** value */
public extension Plist {
    /** - return: a String if Plist **leaf** is a String, nil otherwise */
    public var string : String? {
        get {
            switch entityType {
            case let .string(value):
                return value
            default:
                return nil;
            }
        }
    }
    /** - return: a NSNumber if Plist **leaf** is a number (Bool, Float, Int), nil otherwise */
    public var number : NSNumber? {
        get {
            switch entityType {
            case let .number(value):
                return value
            default:
                return nil;
            }
        }
    }
    //TODO: Add convinience to get Int, Float and Bool
    
    /** - return: a NSDate if Plist **leaf** is a Date, nil otherwise */
    public var date : Date? {
        get {
            switch entityType {
            case let .date(value):
                return value
            default:
                return nil;
            }
        }
    }
    /** - return: a NSData if Plist **leaf** is a Data, nil otherwise */
    public var data : Data? {
        get {
            switch entityType {
            case let .data(value):
                return value
            default:
                return nil;
            }
        }
    }
    /** - return: a [Plist] if Plist **node** is an array, nil otherwise */
    public var array : [Plist]? {
        get {
            switch entityType {
            case let .array(value):
                return value
            default:
                return nil;
            }
        }
    }
    /** - return: a [String:Plist] if Plist **node** is a Dictionary, nil otherwise */
    public var dictionary : [String : Plist]? {
        get {
            switch entityType {
            case let .dictionary(value):
                return value
            default:
                return nil;
            }
        }
    }
}

//MARK:- Subscripting Array
/** Array subscript to get and set Plist at index */
public extension Plist {
    /** Array subscript
    - warning: Numerical subscript on a Plist that is not an array **node** will result in a crash */
    subscript(index: Int) -> Plist {
        get {
            return self.array![index]
        }
        set(newValue) {
            var ar = self.array!
            ar[index] = newValue
            entityType = .array(ar)
        }
    }
}

//MARK:- Subsripting Dictionary
/** Dictionary sucscript to get and set Plist at key */
public extension Plist {
    /** Dictionary subscript
    - warning: String subscript on a Plist that is not a dictionary **node** will result in a crash */
    subscript(key: String) -> Plist? {
        get {
            return self.dictionary![key]
        }
        set(newValue) {
            var dic = self.dictionary!
            dic[key] = newValue
            entityType = .dictionary(dic)
        }
    }
}

//MARK:- Equatable 
/** Conformance to the Equatable protocol */
extension Plist : Equatable {
    /** Equality is based on the stored value for the Plist element
     - warning: Float equality remains Float equality
     */
    public static func ==(lhs: Plist, rhs: Plist) -> Bool {
        let tuple = (lhs.entityType, rhs.entityType)
        switch tuple {
        case let (.string(left), .string(right)):
            return left == right
        case let (.number(left), .number(right)):
            return left.isEqual(to: right)
        case let (.date(left), .date(right)):
            return (left == right)
        case let (.data(left), .data(right)):
            return (left == right)
        case let (.array(left), .array(right)):
            return left == right
        case let (.dictionary(left), .dictionary(right)):
            return left == right
        default:
            return false
        }
    }
}

//MARK:- 'for in' support for Plist Dictionary and Array
/** Support for Plist use in **for in** loop */
extension Plist: Swift.Sequence {

    /** Enable 'for in' support by providing a Generator over SequenceType Plist (Array, and Dictionary)
    - note: Calling this method on a non-SequenceType will make 0 iteration in a For in loop */
    public func makeIterator() -> AnyIterator<(Swift.String, Plist)> {
        switch entityType {
        case .array(let value):
            var index = 0
            var generator = value.makeIterator()
            return AnyIterator {
                if let next = generator.next() {
                    let str = "\(index)"
                    index += 1
                    return (str, next)
                } else {
                    return nil
                }
            }
        case .dictionary(let value):
            var generator = value.makeIterator()
            return AnyIterator { return generator.next() }
        default:
            return AnyIterator { return nil }
        }
    }
}

