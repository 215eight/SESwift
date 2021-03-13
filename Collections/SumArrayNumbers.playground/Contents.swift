/*:
 # Overview
 Write one function that sums an array of numbers. The array might contain all integers, all doubles, or all floats.
 */

/*:
 # Code
 */
extension Collection where Element: AdditiveArithmetic {
    func sum() -> Element {
        return reduce(.zero, +)
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testSum() {
        XCTAssertEqual([1,2,3].sum(), 6)
        XCTAssertEqual([1.0,2.0,3.0].sum(), 6)
        XCTAssertEqual(Array<Float>([1.0,2.0,3.0]).sum(), 6)
    }
}

runTests(Tests())
