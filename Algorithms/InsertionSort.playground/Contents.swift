/*:
 # Overview
 Create an extension for arrays that sorts them using the insertion sort algorithm.
 Tip: An insertion sort creates a new, sorted array by removing items individually from the input array and placing them into the correct position in the new array.

 Loop Invariants analysis
 Initialization: It is true prior to the first loop
 Maintenance: It is true before an interation of the loop, it remains true before the next iteration
 Termination: When the loop terminates, the invariant provides a useful property the helps show that the algorithm is correct

 Tip to remember: Insertion loops works like sorting a hand of cards. Inserting each card in the right position, keeping the sub array from start to the current card sorted.

 Arithmetic Series
 Sum = 1 + 2 + 3 + .... n
 Sum = (n (n-1)) / 2
 */

/*:
 # Code
 */
extension Array where Element: Comparable {

    mutating func insertionSort() {
        var current = startIndex
        while current < endIndex {
            var runner = startIndex
            while runner < current {
                if self[runner] > self[current] {
                    let temp = self[current]
                    self.remove(at: current)
                    self.insert(temp, at: runner)
                    break
                }
                runner = runner.advanced(by: 1)
            }
            current = current.advanced(by: 1)
        }
    }

    func insertionSorted() -> Array<Element> {
        var copy = self
        copy.insertionSort()
        return copy
    }

    mutating func insertionSort2() {
        var current = startIndex
        while current < endIndex {
            let currentValue = self[current]
            var runner = current
            while runner > startIndex, currentValue < self[runner.advanced(by: -1) ] {
                self[runner] = self[runner.advanced(by: -1)]
                runner = runner.advanced(by: -1)
            }
            self[runner] = currentValue
            current = current.advanced(by: 1)
        }
    }

    func insertionSorted2() -> Array<Element> {
        var copy = self
        copy.insertionSort2()
        return copy
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testInsertionSorted() {
        XCTAssertEqual([Int]().insertionSorted(), [Int]())
        XCTAssertEqual([1].insertionSorted(), [1])
        XCTAssertEqual([2,1,3].insertionSorted(), [1,2,3])
        XCTAssertEqual([5,2,4,6,1,3].insertionSorted(), [1,2,3,4,5,6])
    }

    func testInsertionSorted2() {
        XCTAssertEqual([Int]().insertionSorted2(), [Int]())
        XCTAssertEqual([1].insertionSorted2(), [1])
        XCTAssertEqual([2,1,3].insertionSorted2(), [1,2,3])
        XCTAssertEqual([5,2,4,6,1,3].insertionSorted2(), [1,2,3,4,5,6])
    }

    let testInstance = (0 ..< 1000).map { _ in Int(arc4random_uniform(100)) }

    func testInsertionSortedPerformance() {
        measure {
            let result = testInstance.insertionSorted()

            XCTAssertTrue(result.reduce((sorted: true, previous: Int?.none)) {
                guard let previous = $0.previous else {
                    return (sorted: true, previous: $1)
                }
                return (sorted: previous <= $1, previous: $1)

            }.sorted)

        }
    }

    func testInsertionSortedPerformance2() {
        measure {
            let result = testInstance.insertionSorted2()

            XCTAssertTrue(result.reduce((sorted: true, previous: Int?.none)) {
                guard let previous = $0.previous else {
                    return (sorted: true, previous: $1)
                }
                return (sorted: previous <= $1, previous: $1)

            }.sorted)
        }
    }
}

runTests(Tests())
