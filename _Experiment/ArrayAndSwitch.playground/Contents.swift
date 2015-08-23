//: Playground - noun: a place where people can play

import Foundation

//protocol ArrayType {}
//extension Array : ArrayType {}
//extension NSArray : ArrayType {}

struct myStruct {
}

func switchOnAny(any: Any) -> String {
    println("Dynamic Type == \(any.dynamicType)")
    switch any {
//    case let array as ArrayType:
//        return "Stack"
    case let array as [Any]:
        return "Array"
    case let array as NSArray:
        return "NSArray"
    default:
        return "Default"
    }
}

let emptyStringArray : [String] = []
let stringArray : [String] = ["Bob", "Roger"]
let intArray = [1, 2, 3]
let customStructArray : [myStruct] = []

println("\t\touput : \(switchOnAny([]))")
println("\t\touput : \(switchOnAny(emptyStringArray))")
println("\t\touput : \(switchOnAny(stringArray))")
println("\t\touput : \(switchOnAny(intArray))")
println("\t\touput : \(switchOnAny(customStructArray))")

