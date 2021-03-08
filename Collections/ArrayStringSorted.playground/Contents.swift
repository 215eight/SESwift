/*:
 # Overview
 Extend collections with a function that returns an array of strings sorted by their lengths, longest first.
 */

/*:
 # Code
 */

extension Collection where Element == String {
    func sortedByLength() -> [Element] {
        sorted {
            if $0.count == $1.count {
                return $0 < $1
            } else {
                return $0.count > $1.count
            }
        }
    }
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testSortedByLength() {
        XCTAssertEqual(["a", "abc", "ab"].sortedByLength(), ["abc", "ab", "a"])
        XCTAssertEqual(["paul", "taylor", "adele"].sortedByLength(), ["taylor", "adele", "paul"])
        XCTAssertEqual(["cccc", "aaaa", "bbbb"].sortedByLength(), ["aaaa", "bbbb", "cccc"])
        XCTAssertEqual([String]().sortedByLength(), [])
    }
}

runTests(Tests())
