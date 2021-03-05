/*:
 # Overview
 Write a function that accepts two strings, and returns true if they are identical in length but have no more than three different letters, taking case and string order into account.
 */

/*:
 # Code
 */

func different(_ rhs: String, lhs: String, by count: Int) -> Bool {
    guard rhs.count == lhs.count else { return false }
    let initialDifferences = 0
    let updatedDifferences = zip(Array(rhs), Array(lhs))
        .reduce(initialDifferences) { (acc, tuple: (rhs: Character, lhs: Character)) in
            tuple.rhs == tuple.lhs ? acc : acc + 1
        }
    return updatedDifferences <= count
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testDifferentBy() {
        XCTAssertTrue(different("Clamp", lhs: "Cramp", by: 3))
        XCTAssertTrue(different("Clamp", lhs: "Crams", by: 3))
        XCTAssertTrue(different("Clamp", lhs: "Grams", by: 3))
        XCTAssertFalse(different("Clamp", lhs: "Grans", by: 3))
        XCTAssertFalse(different("Clamp", lhs: "Clam", by: 3))
        XCTAssertFalse(different("clamp", lhs: "maple", by: 3))
    }
}

runTests(Tests())
