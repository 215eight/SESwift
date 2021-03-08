/*:
 # Overview
 Write an extension for all collections that returns the N smallest elements as an array, sorted smallest first, where N is an integer parameter.
 */

/*:
 # Code
 */

extension Collection where Element: Comparable {
    func smallest(maxLength: Int) -> [Element] {
        Array(sorted().prefix(maxLength))
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testSmallest() {
        XCTAssertEqual([1,2,3,4].smallest(maxLength: 3), [1,2,3])
        XCTAssertEqual(["q", "f", "k"].smallest(maxLength: 3), ["f", "k", "q"])
        XCTAssertEqual([256, 16].smallest(maxLength: 3), [16, 256])
        XCTAssertEqual([String]().smallest(maxLength: 3), [])
    }
}

runTests(Tests()) 
