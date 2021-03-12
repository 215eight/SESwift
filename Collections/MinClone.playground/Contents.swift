/*:
 # Overview
 Write an extension for all collections that reimplements the min() method.
 */

/*:
 # Code
 */

extension Collection where Element: Comparable {

    func min() -> Element? {
        guard let tempMin = self.first else { return nil }
        return reduce(tempMin) { $1 < $0 ? $1 : $0 }
    }
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testMin() {
        XCTAssertEqual([1,2,3].min(), 1)
        XCTAssertEqual(["q", "f", "k"].min(), "f")
        XCTAssertEqual([4096, 256, 16].min(), 16)
        XCTAssertEqual([String]().min(), nil)
        XCTAssertEqual([10, -10].min(), -10)
    }
}

runTests(Tests())
