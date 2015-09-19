//: Playground - noun: a place where people can play

import Foundation

//protocol ArrayType {}
//extension Array : ArrayType {}
//extension NSArray : ArrayType {}

struct myStruct {
}

func switchOnAny(any: Any) -> String {
    print("Dynamic Type == \(any.dynamicType)")
    switch any {
//    case let array where reflect(any).disposition == MirrorDisposition.IndexContainer:
//        return "black magic"
//    case let array as ArrayType:
//        return "Stack"
    case let array as [Any]:
        return "Array"
    case let array as NSArray:
        return "NSArray"
    case let array as [myStruct]:
        return "mystruct"
    default:
        return "Default"
    }
}

let emptyStringArray : [String] = []
let stringArray : [String] = ["Bob", "Roger"]
let intArray = [1, 2, 3]
let customStructArray : [myStruct] = []

print("\t\touput : \(switchOnAny([]))")
print("\t\touput : \(switchOnAny(emptyStringArray))")
print("\t\touput : \(switchOnAny(stringArray))")
print("\t\touput : \(switchOnAny(intArray))")
print("\t\touput : \(switchOnAny(customStructArray))")

