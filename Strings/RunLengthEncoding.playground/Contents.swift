/*:
 # Overview
 Write a function that accepts a string as input, then returns how often each letter is repeated in a single run, taking case into account.

 Tip: This approach is used in a simple lossless compression technique called run-length encoding.
 */

/*:
 # Code
 */
func encode(_ str: String) -> String {
    var result = ""
    var runnerIndex = str.startIndex
    while runnerIndex < str.endIndex {
        let searchChar = Character(String(str[runnerIndex...runnerIndex]))
        guard let range = str.range(of: "\(searchChar)+",
                                    options: .regularExpression,
                                    range: runnerIndex..<str.endIndex,
                                    locale: nil) else { return result }
        let subString = str[range.lowerBound..<range.upperBound]
        let tempResult = "\(searchChar)\(subString.count)"
        result += tempResult
        runnerIndex = range.upperBound
    }
    return result
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testEncode() {
        XCTAssertEqual(encode("aabbcc"), "a2b2c2")
        XCTAssertEqual(encode("aaabaaabaaa"), "a3b1a3b1a3")
        XCTAssertEqual(encode("aaAAaa"), "a2A2a2")
    }
}

runTests(Tests())
