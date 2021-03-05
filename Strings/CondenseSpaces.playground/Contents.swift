/*:
 # Overview
 Write a function that returns a string with any consecutive spaces replaced with a single space.
 */

/*:
 # Code
 */

func condense(_ str: String) -> String {
    let updatedStr = str.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression, range: nil)
    return updatedStr
}

func condense2(_ str: String) -> String {
    let initialResult = (condensed: "", shouldCondense: false)
    let updatedResult = str.reduce(initialResult) { (acc, char) in
        guard " " == "\(char)" else {
            return (condensed: acc.condensed + "\(char)", shouldCondense: false)
        }
        if acc.shouldCondense {
            return acc
        } else {
            return (condensed: acc.condensed + "\(char)", shouldCondense: true)
        }
    }
    return updatedResult.condensed
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testCondense() {
        XCTAssertEqual(condense("a   b   c"), "a b c")
        XCTAssertEqual(condense("   a"), " a")
        XCTAssertEqual(condense("       a"), " a")
        XCTAssertEqual(condense("abc"), "abc")
    }
    func testCondense2() {
        XCTAssertEqual(condense2("a   b   c"), "a b c")
        XCTAssertEqual(condense2("   a"), " a")
        XCTAssertEqual(condense2("       a"), " a")
        XCTAssertEqual(condense2("abc"), "abc")
    }
}

runTests(Tests())
