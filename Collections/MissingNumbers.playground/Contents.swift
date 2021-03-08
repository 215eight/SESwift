/*:
 # Overview
 Create a function that accepts an array of unsorted numbers from 1 to 100 where zero or more numbers might be missing, and returns a sorte array of the missing numbers.
 */

/*:
 # Code
 */

func missingNumbers(from: Int = 1, to: Int = 100, in input: [Int]) -> [Int] {
    let baselineSet = Set(Array(from...to))
    let inputSet = Set(input)
    return Array(baselineSet.subtracting(inputSet)).sorted()
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testMissingNumbers() {
        var testArray = Array(1...100)
        testArray.remove(at: 25)
        testArray.remove(at: 20)
        testArray.remove(at: 6)
        XCTAssertEqual(missingNumbers(in: testArray), [7,21,26])
    }
}

runTests(Tests())
