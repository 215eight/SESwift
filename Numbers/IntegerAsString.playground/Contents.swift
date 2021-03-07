/*:
 # Overview
 Write a function that accepts a string and returns true if it contains only numbers, i.e. the digits 0 through 9.
 */

/*:
 # Code
 */

func isInteger(_ input: String) -> Bool {
    guard let range = input.range(of: "[0123456789]*", options: .regularExpression, range: nil, locale: nil),
          range.lowerBound == input.startIndex && range.upperBound == input.endIndex else {
        return false
    }
    return true
}

func isInteger2(_ input: String) -> Bool {
    return UInt(input) != nil
}

func isInteger3(_ input: String) -> Bool {
    return input.rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789").inverted) == nil
}

/*:

 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testIsInteger() {
        XCTAssertTrue(isInteger("010101010101"))
        XCTAssertTrue(isInteger("123456789"))
        XCTAssertTrue(isInteger("9223372036854775808"))
        XCTAssertFalse(isInteger("1.01"))
        XCTAssertFalse(isInteger("1a01"))
        XCTAssertFalse(isInteger("abc"))
    }

    func testIsInteger2() {
        XCTAssertTrue(isInteger2("010101010101"))
        XCTAssertTrue(isInteger2("123456789"))
        XCTAssertTrue(isInteger2("9223372036854775808"))
        XCTAssertFalse(isInteger2("1.01"))
        XCTAssertFalse(isInteger2("1a01"))
        XCTAssertFalse(isInteger2("abc"))
    }

    func testIsInteger3() {
        XCTAssertTrue(isInteger3("010101010101"))
        XCTAssertTrue(isInteger3("123456789"))
        XCTAssertTrue(isInteger3("9223372036854775808"))
        XCTAssertFalse(isInteger3("1.01"))
        XCTAssertFalse(isInteger3("1a01"))
        XCTAssertFalse(isInteger3("abc"))
    }
}

runTests(Tests())
