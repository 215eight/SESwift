/*:
 # Overview
 Write a function that accepts a variadic array of integers and return the sum of all numbers that appear an even number of times.
 */

/*:
 # Code
 */

func sumEvenRepeats(_ numbers: Int...) -> Int {
    var mapCount = [Int: Int]()
    numbers.forEach { mapCount[$0] = (mapCount[$0] ?? 0) + 1 }
    return mapCount.reduce(0) { acc, tuple in
        return tuple.value % 2 == 0 ? acc + tuple.key : acc
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testSumEvenRepeats() {
        XCTAssertEqual(sumEvenRepeats(1,2,2,3,3,4), 5)
        XCTAssertEqual(sumEvenRepeats(5,5,5,12,12), 12)
        XCTAssertEqual(sumEvenRepeats(1,1,2,2,3,3,4,4), 10)
        XCTAssertEqual(sumEvenRepeats(1,2,1,2,3,4,3,4), 10)
    }
}

runTests(Tests())
