/*:
 # Overview
 Swap two positive variable integers, a and b, without using a temporary variable.
 */

/*:
 # Code
 */

func swap(_ rhs: inout Int, _ lhs: inout Int) {
    (rhs, lhs) = (lhs, rhs)
}

func swap2(_ rhs: inout Int, _ lhs: inout Int) {
    rhs = rhs + lhs
    lhs = rhs - lhs
    rhs = rhs - lhs
}

func swap3(_ rhs: inout Int, _ lhs: inout Int) {
    rhs = rhs ^ lhs
    lhs = rhs ^ lhs
    rhs = rhs ^ lhs
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testSwap() {
        var a = 0
        var b = 1
        swap(&a, &b)
        XCTAssertEqual(a, 1)
        XCTAssertEqual(b, 0)
    }

    func testSwap2() {
        var a = 0
        var b = 1
        swap2(&a, &b)
        XCTAssertEqual(a, 1)
        XCTAssertEqual(b, 0)
    }

    func testSwap3() {
        var a = 0
        var b = 1
        swap3(&a, &b)
        XCTAssertEqual(a, 1)
        XCTAssertEqual(b, 0)
    }
}

runTests(Tests())
