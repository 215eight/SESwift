/*:
 # Overview
 Write an extension for all collections that reimplements the firstIndex(of:) method.
 Tip: This is one of the easiest standard library methods to reimplement, so please give it an especially good try before reading any hints.
 */

/*:
 # Code
 */

extension Collection where Element: Equatable {

    func firstIndexOf(_ element: Element) -> Int? {
        for (offset, value) in enumerated() {
            if element == value { return offset }
        }
        return nil
    }
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testFistIndexOf() {
        XCTAssertEqual([1,2,3].firstIndex(of: 1), 0)
        XCTAssertEqual([1,2,3].firstIndex(of: 3), 2)
        XCTAssertEqual([1,2,3].firstIndex(of: 5), nil)
    }
}

runTests(Tests())
