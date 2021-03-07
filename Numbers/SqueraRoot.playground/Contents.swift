/*:
 # Overview
 Write a function that returns the square root of a positive integer, rounded down to the nearest integer, without using sqrt().
 */

/*:
 # Code
 */

func squareRoot(_ input: Int) -> Int {
    return 0
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testSquareRoot() {
        XCTAssertEqual(squareRoot(9), 3)
        XCTAssertEqual(squareRoot(16777216), 4096)
        XCTAssertEqual(squareRoot(16), 4)
        XCTAssertEqual(squareRoot(15), 3)
    }
}

runTests(Tests())
