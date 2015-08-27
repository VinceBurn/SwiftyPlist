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
    
    /** Create a Plist from values that are Plist Convertible or Plist.
    @discussion Accepted input are Plist compatible class and Plist struct
    @note this is similar to init?(rawValue), but will also allow Plist, [Plist] and [String : Plist] as input
        -->(NOTE TO SELF: is this necessary or usefull... Well... It is when you need to add or remove entity from a .Array)
    @warning Will crash if not convertible
    */
    public init(plistObject: Any) {
        switch plistObject {
            
        case let string as String:
            self.entityType = .String(string)
            
        case let num as NSNumber:
            self.entityType = .Number(num)
            
        case let date as NSDate:
            self.entityType = .Date(date)
            
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

//MARK:-  RawRepresentable protocol
extension Plist : RawRepresentable {
    
    /** Designited Creation Method
    @discussion Accepted input are only Property list compatible class. Keys in dictionary must be Strings.
    */
    public init?(rawValue: Any) {
        switch rawValue {
            
        case let string as String:
            self.entityType = .String(string)
            
        case let num as NSNumber:
            self.entityType = .Number(num)
            
        case let date as NSDate:
            self.entityType = .Date(date)
            
        case let data as NSData:
            self.entityType = .Data(data)
            
        case let array as NSArray:
            var pAr : [Plist] = []
            for any in array {
                if let p = Plist(rawValue: any) {
                    pAr.append(p)
                } else {
                    return nil
                }
            }
            self.entityType = .Array(pAr)
            
        case let dictionary as NSDictionary:
            var dic : [String : Plist] = [:]
            for (k, value) in dictionary {
                if let key = k as? String, p = Plist(rawValue: value) {
                    dic[key] = p
                } else {
                    return nil
                }
            }
            self.entityType = .Dictionary(dic)
            
        default:
            return nil
        }
    }
    
    /** Convenience method to unwrap the result of init?(rawValue:)
    @warning Method will crash if an error occure */
    public static func newWithRawValue(rawValue: Any) -> Plist {
        return Plist(rawValue: rawValue)!
    }
    
    /** Convert back a Plist to it's Raw representation */
    public var rawValue: Any {
        //NOTE -->  Consider moving rawValue to AnyObject or to a PlistConvertibleProtocol, for which the possible class need to have extension
        get {
            switch entityType {
            case .String(let value):
                return value
            case .Number(let value):
                return value
            case .Date(let value) :
                return value
            case .Data(let value):
                return value
            case .Array(let value):
                var output = [AnyObject]()
                for p in value {
                    if let raw: AnyObject = p.rawValue as? AnyObject {
                        output.append(raw)
                    }
                }
                return output
            case .Dictionary(let value):
                var output = [String : AnyObject]()
                for (key, val) in value {
                    if let raw: AnyObject = val.rawValue as? AnyObject {
                        output[key] = raw
                    }
                }
                return output
            }
        }
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

//MARK:- Equatable 
extension Plist : Equatable {}

/** Equality is based on the stored value for the Plist element
@Warning Float equality remains Float equality
*/
public func ==(lhs: Plist, rhs: Plist) -> Bool {
    let tuple = (lhs.entityType, rhs.entityType)
    switch tuple {
    case let (.String(left), .String(right)):
        return left == right
    case let (.Number(left), .Number(right)):
        return left.isEqualToNumber(right)
    case let (.Date(left), .Date(right)):
        return left.isEqualToDate(right)
    case let (.Data(left), .Data(right)):
        return left.isEqualToData(right)
    case let (.Array(left), .Array(right)):
        return left == right
    case let (.Dictionary(left), .Dictionary(right)):
        return left == right
    default:
        return false
    }
}

//MARK:- 'for in' support for Plist Dictionary and Array
extension Plist: Swift.SequenceType {

    /** Enable 'for in' support by providing a Generator over SequenceType Plist (Array, and Dictionary)
    @note Calling this method on a non-SequenceType will make 0 iteration in a For in loop */
    public func generate() -> GeneratorOf<(Swift.String, Plist)> {
        switch entityType {
        case .Array(let value):
            var index = 0
            var generator = value.generate()
            return GeneratorOf<(Swift.String, Plist)> {
                if let next = generator.next() {
                    let str = "\(index++)"
                    return (str, next)
                } else {
                    return nil
                }
            }
        case .Dictionary(let value):
            var generator = value.generate()
            return GeneratorOf<(Swift.String, Plist)> { return generator.next() }
        default:
            return GeneratorOf<(Swift.String, Plist)> { return nil }
        }
    }
}

