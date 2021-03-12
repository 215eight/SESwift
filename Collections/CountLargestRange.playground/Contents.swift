/*:
 # Overview
 Write a function that accepts an array of positive and negative numbers and returns a closed range containing the position of the contiguous positive numbers that sum to the highest value, or nil if nothing were found.
 */

/*:
 # Code
 */

func countLargestRange(_ input: [Int]) -> ClosedRange<Int>? {
    var runner = input.startIndex
    var tempMaxRange: (sum: Int, range: ClosedRange<Int>)? = nil
    var currentRange: (sum: Int, range: ClosedRange<Int>)? = nil
    while runner < input.endIndex {
        defer {
            runner = runner.advanced(by: 1)
        }
        let element = input[runner]
        if element > 0 {
            guard let nonOptionalCurrentRange = currentRange else {
                currentRange = (sum: element, range: runner ... runner)
                continue
            }
            currentRange = (sum: nonOptionalCurrentRange.sum + element,
                          range: nonOptionalCurrentRange.range.lowerBound ... runner)
        } else {
            guard let nonOptionalCurrentRange = currentRange else {
                continue
            }
            guard let nonOptionalTempMaxRange = tempMaxRange else {
                tempMaxRange = nonOptionalCurrentRange
                currentRange = nil
                continue
            }
            if nonOptionalCurrentRange.sum > nonOptionalTempMaxRange.sum {
                tempMaxRange = nonOptionalCurrentRange
            }
            currentRange = nil
        }
    }
    guard let nonOptionalCurrentRange = currentRange else {
        return tempMaxRange?.range
    }
    guard let nonOptionalTempMaxRange = tempMaxRange else {
        return nonOptionalCurrentRange.range
    }
    if nonOptionalCurrentRange.sum > nonOptionalTempMaxRange.sum {
        return nonOptionalCurrentRange.range
    } else {
        return nonOptionalTempMaxRange.range
    }
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testCountLargestRange() {
        XCTAssertEqual(countLargestRange([0,1,1,-1,2,3,1]), 4...6)
        XCTAssertEqual(countLargestRange([10,20,30,-10,-20,10,20]), 0...2)
        XCTAssertEqual(countLargestRange([1,-1,2,-1]), 2...2)
        XCTAssertEqual(countLargestRange([2,0,2,0,2]), 0...0)
        XCTAssertEqual(countLargestRange([Int]()), nil)
    }
}

runTests(Tests())
