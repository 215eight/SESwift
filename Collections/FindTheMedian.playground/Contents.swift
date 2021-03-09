/*:
 # Overview
 Write an extension to collections that accepts an array of Int and returns the median average, or nil if there are no values.
 Tip: The mean average is the sum of some numbers divided by how many there are. The median average is the middle of a sorted list. If there is no single middle value – e.g. if there are eight numbers - then the median is the mean of the two middle values.

 */

/*:
 # Code
 */

extension Collection where Element == Int {

    func median() -> Double? {
        guard count > 0 else { return nil }
        let medianIndex = count / 2
        let sortedArray = sorted()
        if count % 2 == 0 {
            return Double(sortedArray[medianIndex - 1] + sortedArray[medianIndex]) / 2.0
        } else {
            return Double(sortedArray[medianIndex])
        }
    }
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testMedian() {
        XCTAssertEqual([1,2,3].median(), 2)
        XCTAssertEqual([1,2,9].median(), 2)
        XCTAssertEqual([1,3,5,7,9].median(), 5)
        XCTAssertEqual([1,2,3,4].median(), 2.5)
        XCTAssertEqual([Int]().median(), nil)
    }
}

runTests(Tests())
