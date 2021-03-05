/*:
 # Overview
 Write a function that accepts a string of words with a similar prefix, separated by spaces, and returns the longest substring that prefixes all words.
 */

/*:
 # Code
 */

func longestPrefix(_ str: String) -> String {

    func prefix(length: Int, words: [String]) -> String? {
        let initialResult = (tempPrefix: String?.none, prefix: String?.none)
        let result = words.map { $0.prefix(length) }
            .reduce(initialResult) { (acc, wordPrefix) in
                guard let tempPrefix = acc.tempPrefix else {
                    return (tempPrefix: String(wordPrefix), prefix: nil)
                }
                if tempPrefix == wordPrefix {
                    return (tempPrefix: tempPrefix, prefix: tempPrefix)
                } else {
                    return (tempPrefix: tempPrefix, prefix: nil)
                }
            }
        return result.prefix
    }

    let words = str.components(separatedBy: " ")
    var length = 0
    var prefixResult: String? = nil
    while let tempPrefix = prefix(length: length, words: words) {
        prefixResult = tempPrefix
        length += 1
    }
    return prefixResult ?? ""
}

func longestPrefix2(_ str: String) -> String {
    let words = str.components(separatedBy: " ")
    guard let firstWord = words.first else { return "" }

    var prefix = ""
    var tempPrefix = ""

    for char in firstWord {
        tempPrefix.append(char)
        for word in words {
            if !word.hasPrefix(tempPrefix) {
                return prefix
            }
        }
        prefix = tempPrefix
    }
    return prefix
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testLongestPrefix() {
        XCTAssertEqual(longestPrefix("swift switch swill swim"), "swi")
        XCTAssertEqual(longestPrefix("s switch swill swim"), "s")
        XCTAssertEqual(longestPrefix("flip flap flop"), "fl")
    }
    func testLongestPrefix2() {
        XCTAssertEqual(longestPrefix2("swift switch swill swim"), "swi")
        XCTAssertEqual(longestPrefix2("s switch swill swim"), "s")
        XCTAssertEqual(longestPrefix2("flip flap flop"), "fl")
    }
}

runTests(Tests())
