# SwiftyPlist ![License MIT](https://img.shields.io/cocoapods/l/SwiftyPlist.svg)

[![Badge w/ Version](https://img.shields.io/cocoapods/v/SwiftyPlist.svg)](http://cocoadocs.org/docsets/SwiftyPlist/2.3.0/)
[![Badge w/ Platform](https://img.shields.io/cocoapods/p/SwiftyPlist.svg)](http://cocoadocs.org/docsets/SwiftyPlist/)

### Note

For now this repo is a personal exercise in implementing in a TDD manner a Plist representation inspired by [PropertyList](https://github.com/monyschuk/PropertyList) which is inspired by [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)  


Swift 4.0 introduced the **Codable** protocol, that can be use with JSON, but that can also be used with property list. Moving forward you should look into that option.

## Usage
```Swift
let inputDic = plistDictionaryFromFile()
var plist = Plist(plistObject: inputDic)
let str = plist["array"]?[1].string
let float = plist["float"]?.number as? Float
plist["float"] = 1.1
```
## Current Philosophy
**This may change after starting using it in real life situation**
* Avoid all the type casting needed when using the Appel's API alone
* Allow chained subscript access to items in the property list
* Keep the optional nature of dictionary access
* Keep the out of bound crash of array access
* Assume that the plist format is known by the calling code (e.g. what kind of number you are suppose to have for a given key)
* Keep `Plist` a `struct` to have better control over mutability and have value semantic.
* Version number match Swift version. e.g. Version 1.2.x are version written for Swift 1.2.

## Requirements

iOS 8.0 (might work on OSX and iOS 7, but not tested (officially supported) on those system)

## Installation

SwiftyPlist is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftyPlist"
```

## Author

Vincent Bernier
