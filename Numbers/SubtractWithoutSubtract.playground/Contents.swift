/*:
 # Overview
 Create a function that subtracts one positive integer from another, without using -.
 */

/*:
 # Code
 */

func subtract(_ rhs: Int, from lhs: Int) -> Int {
    return lhs + (~rhs + 1)
}
/*:

 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testSubtract() {
        XCTAssertEqual(subtract(5, from: 9), 4)
        XCTAssertEqual(subtract(10, from: 30), 20)
        XCTAssertEqual(subtract(30, from: 10), -20)
    }
}

runTests(Tests())
