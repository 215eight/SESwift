import Foundation

/*:
 # Strings
 */

// Find the range of a sub-string in a string.
// Search options support case insensitive and regex format
"Hello, world".range(of: "wOrLd", options: .caseInsensitive, range: nil, locale: nil)

// Inverse regex using capital identifier
"aa10bb20cc30##40".replacingOccurrences(of: "\\D+", with: "-",options: .regularExpression)


// Replace occurrences of a string. Search options support case insensitive and regex format
let replacingOcurrences = "Hello, world".replacingOccurrences(of: "o", with: "0", options: .caseInsensitive, range: nil)
replacingOcurrences

// Split a string using a character set or another string
let stringComponents = " a bcd e ".components(separatedBy: .whitespacesAndNewlines)
stringComponents

// Check if a string starts with a certain prefix
let startsWithFoo = "Hello, world".starts(with: "Foo")
startsWithFoo

// Reverse a string
let reversed = "Hello, world".reversed()
String(reversed)

// Determine if a prefix
"Hello, world".hasPrefix("Hello")
"Hello, world".prefix(20)

// Find characters in a CharacterSet
// CharacterSet can be inverted
let characterSet = CharacterSet(charactersIn: "0123456789")
"abcd".rangeOfCharacter(from: characterSet)
"abcd".rangeOfCharacter(from: characterSet.inverted)


// Getting a substring
//
// Always make sure the range is not past the end of the string
// To get a single character just make the range inclusive to a single position *
// String's endIndex is a past the end position. Do not access it or it will error out

let fullString = "Hello, world"
fullString[..<fullString.index(fullString.startIndex, offsetBy: 5)]
fullString[fullString.index(fullString.startIndex, offsetBy: 7)...]
fullString[fullString.startIndex...fullString.startIndex]

// Can instantiate Sets from a String
Set("Hello, world")

// Can instantiate Arrays from a String
Array("Hello, world")

/*:
 # Numbers
 */

// Random number
Int.random(in: 0...100)
arc4random_uniform(101) // upperbound in not inclusive
arc4random_uniform(2) // upperbound in not inclusive

// Swap Numbers
var aSwap = 10
var bSwap = 20
Swift.swap(&aSwap, &bSwap)

// Round up a number
ceil(10.5)
10.5.rounded(.up)

// Convert number base 10 to binary representation
String(16, radix: 2)

// Convert number in binary to base 10
Int("00001111", radix: 2)

// Bitwise AND operator
let AND = 12&4

// Bitwise NOT operator
let NOT = ~15

// BItwise OR operator
let OR = 8 | 4

// BItwise OR operator
let XOR = 8 ^ 4

// Bit shifting
15 >> 1
15 << 2

// Binary represnetation
let binaryRepresentation: UInt8 = 0b00000011

/*:
 # Dictionary
 */

// Update value
var dict = [String: Bool]()
var dictValue = dict.updateValue(true, forKey: "A")
dictValue = dict.updateValue(false, forKey: "A")

/*:
 # Arrays
 */

// Enumerated give you the value and the index
for (offset, element) in ["a", "b", "c", "d"].enumerated() {
    let _ = offset
    let _ = element
}

// Find first index of a element
[0,1,2,3].firstIndex(of: 2)

/*:
 # Functional Programing
 */

//: ### Filter

// Elements will be kept if the filter conditon is true
// Removes odd numbers
let filtered = [0,1,2,3,4].filter { $0 % 2 == 0 }
filtered

/*:
 # Ranges
 */

// Reverse Range
(0 ..< 20).reversed()
