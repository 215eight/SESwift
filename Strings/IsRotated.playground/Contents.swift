/*:
 # Overview
 Write a function that accepts two strings, and returns true if one string is rotation of the other,
 taking letter case into account.
 Tip: A string rotation is when you take a string, remove some letters from its end, then append them to the front. For example, “swift” rotated by two characters would be “ftswi”.
 */

/*:
 # Code
 */

func isRotated(_ rhs: String, lhs: String) -> Bool {
    guard rhs.count == lhs.count,
          rhs != lhs else { return false }
    let testStr = rhs + rhs
    return testStr.contains(lhs)
}

func isRotated2(_ rhs: String, lhs: String) -> Bool {
    guard !rhs.isEmpty, !lhs.isEmpty,
          rhs.count == lhs.count,
          rhs != lhs else { return false }
    let rhsArray = Array(rhs)
    let lhsArray = Array(lhs)

    let lhsFirstCharacter = lhsArray[0]
    guard let pivotIndex = rhsArray.firstIndex(of: lhsFirstCharacter) else { return false }
    let firstSlice = rhsArray[..<pivotIndex]
    let secondSlice = rhsArray[pivotIndex...]
    let rotatedArray = Array(secondSlice + firstSlice)
    return rotatedArray == lhsArray
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testIsRotated() {
        XCTAssertTrue(isRotated("swift", lhs: "ftswi"))
        XCTAssertTrue(isRotated("abcde", lhs: "eabcd"))
        XCTAssertTrue(isRotated("abcde", lhs: "cdeab"))
        XCTAssertFalse(isRotated("abcde", lhs: "abcde"))
        XCTAssertFalse(isRotated("abc", lhs: "a"))
    }
    func testIsRotated2() {
        XCTAssertTrue(isRotated2("swift", lhs: "ftswi"))
        XCTAssertTrue(isRotated2("abcde", lhs: "eabcd"))
        XCTAssertTrue(isRotated2("abcde", lhs: "cdeab"))
        XCTAssertFalse(isRotated2("abcde", lhs: "abcde"))
        XCTAssertFalse(isRotated2("abc", lhs: "a"))
    }
}

runTests(Tests())
