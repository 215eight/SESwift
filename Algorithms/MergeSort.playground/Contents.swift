/*:
 # Overview
 Implement MergeSort algorithm
 */

/*:
 # Code
 */

/*:
 # Tests
 */

extension Array where Element: Comparable {

    func mergeSort() -> Self {
        return mergeSort(self)
    }

    func mergeSort(_ input: Self) -> Self {
        guard input.count > 1 else { return input }

        if input.count == 2  {
            guard let first = input.first,
                  let last = input.last else {
                return input
            }

            return first < last ? [first, last] : [last, first]
        }

        let lhs = mergeSort(Array(input[..<(input.count/2)]))
        let rhs = mergeSort(Array(input[(input.count/2)...]))

        var sorted = [Element]()

        var lhsIndex = 0
        var rhsIndex = 0

        while lhsIndex < lhs.count && rhsIndex < rhs.count {
            let lhsValue = lhs[lhsIndex]
            let rhsValue = rhs[rhsIndex]

            if lhsValue < rhsValue {
                sorted.append(lhsValue)
                lhsIndex += 1
            } else {
                sorted.append(rhsValue)
                rhsIndex += 1
            }
        }

        while lhsIndex < lhs.count {
            let lhsValue = lhs[lhsIndex]
            sorted.append(lhsValue)
            lhsIndex += 1
        }

        while rhsIndex < rhs.count {
            let rhsValue = rhs[rhsIndex]
            sorted.append(rhsValue)
            rhsIndex += 1
        }

        return sorted
    }
}

import XCTest
class Tests: XCTestCase {
    func testFoo() {
        XCTAssertEqual([Int]().mergeSort(), [])
        XCTAssertEqual([1].mergeSort(), [1])
        XCTAssertEqual([1,2].mergeSort(), [1,2])
        XCTAssertEqual([2,1].mergeSort(), [1,2])
        XCTAssertEqual([0,0].mergeSort(), [0,0])
        XCTAssertEqual([2,3,1].mergeSort(), [1,2,3])
        XCTAssertEqual([1,2,3,4,5].mergeSort(), [1,2,3,4,5])
        XCTAssertEqual([5,4,3,2,1].mergeSort(), [1,2,3,4,5])
        XCTAssertEqual([2,1,4,3,5].mergeSort(), [1,2,3,4,5])
    }
}

runTests(Tests())
