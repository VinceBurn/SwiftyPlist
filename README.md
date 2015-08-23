# SwiftyPlist

### Note

For now this repo is a personal exercise in implementing in a TDD manner a Plist representation inspired by [PropertyList](https://github.com/monyschuk/PropertyList) which is inspired by [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

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
