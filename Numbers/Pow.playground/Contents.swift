/*:
 # Overview
 Create a function that accepts positive two integers, and raises the first to the power of the second.
 */

/*:
 # Code
 */

func pow(_ base: Int, _ exp: Int) -> Int {
    guard base > 0 else { return 0 }
    guard exp > 0 else { return 1 }
    guard exp > 1 else { return base }
    return (1..<exp).reduce(base) { acc, _ in
        (acc * base)
    }
}

func pow2(_ base: Int, _ exp: Int) -> Int {
    guard base > 0 else { return 0 }
    guard exp > 0 else { return 1 }
    guard exp > 1 else { return base }
    return base * pow2(base, exp-1)
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testPow() {
        XCTAssertEqual(pow(4, 0), 1)
        XCTAssertEqual(pow(4, 1), 4)
        XCTAssertEqual(pow(4, 2), 16)
        XCTAssertEqual(pow(4, 3), 64)
        XCTAssertEqual(pow(2, 8), 256)
    }
    func testPow2() {
        XCTAssertEqual(pow2(4, 0), 1)
        XCTAssertEqual(pow2(4, 1), 4)
        XCTAssertEqual(pow2(4, 2), 16)
        XCTAssertEqual(pow2(4, 3), 64)
        XCTAssertEqual(pow2(2, 8), 256)
    }
}

runTests(Tests())
