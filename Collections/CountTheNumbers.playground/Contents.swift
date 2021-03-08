/*:
 # Overview
 Write an extension for collections of integers that returns the number of times a specific digit appears in any of its numbers.
 */

/*:
 # Code
 */
extension Collection where Element == Int {
    func count(digit: Character) -> Int {
        reduce(0) { acc, element in
            acc + String(element).reduce(0) { elementAcc, elementDigit in
                elementDigit == digit ? elementAcc + 1 : elementAcc
            }
        }
    }
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testCount() {
        XCTAssertEqual([5,15,55,515].count(digit: "5"), 6)
        XCTAssertEqual([5,15,55,515].count(digit: "1"), 2)
    }
}

runTests(Tests())
