/*:
 # Overview
 Create an extension for arrays that sorts them using the bubble sort algorithm.
 Tip: A bubble sort repeatedly loops over the items in an array, comparing items that are next to each other and swapping them if they aren’t sorted. This looping continues until all items are in their correct order.
 */

/*:
 # Code
 */

extension Array where Element: Comparable {

    mutating func bubbleSort() {
        var maxIndex = self.endIndex
        while maxIndex > self.startIndex {
            var lastSwap = self.startIndex
            var aIndex = self.startIndex
            var bIndex = aIndex.advanced(by: 1)
            while bIndex < maxIndex {
                if self[aIndex] > self[bIndex] {
                    self.swapAt(aIndex, bIndex)
                    lastSwap = bIndex
                }
                aIndex = bIndex
                bIndex = bIndex.advanced(by: 1)
            }
            maxIndex = lastSwap
        }
    }

    func bubbleSorted() -> [Element] {
        var copy = self
        copy.bubbleSort()
        return copy
    }

    func bubbleSorted2() -> [Element] {
        guard count > 1 else { return self }

        var sortedArray = self
        var highestSortedIndex = count

        repeat {
            var lastSwapIndex = 0

            for index in 0 ..< highestSortedIndex - 1 {
                let element = sortedArray[index]
                let next = sortedArray[index + 1]
                if (element > next ) {
                    sortedArray.swapAt(index, index + 1)
                    lastSwapIndex = index + 1
                }
            }
            highestSortedIndex = lastSwapIndex
        } while highestSortedIndex != 0

        return sortedArray
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testBubbleSort() {
        XCTAssertEqual([Int]().bubbleSorted(), [Int]())
        XCTAssertEqual([1].bubbleSorted(), [1])
        XCTAssertEqual([2,1].bubbleSorted(), [1,2])
        XCTAssertEqual([2,1,3].bubbleSorted(), [1,2,3])
        XCTAssertEqual([12,5,4,9,3,2,1].bubbleSorted(), [1,2,3,4,5,9,12])
        XCTAssertEqual(["f", "a", "b"].bubbleSorted(), ["a", "b", "f"])
    }

    func testBubbleSort2() {
        XCTAssertEqual([Int]().bubbleSorted2(), [Int]())
        XCTAssertEqual([1].bubbleSorted2(), [1])
        XCTAssertEqual([2,1].bubbleSorted2(), [1,2])
        XCTAssertEqual([2,1,3].bubbleSorted2(), [1,2,3])
        XCTAssertEqual([12,5,4,9,3,2,1].bubbleSorted2(), [1,2,3,4,5,9,12])
        XCTAssertEqual(["f", "a", "b"].bubbleSorted2(), ["a", "b", "f"])
    }

    let unsorterArray = (0 ..< 100).map { _ in
        Int(arc4random_uniform(100))
    }

    func testBubbleSortPerformance() {
        measure {
            _ = unsorterArray.bubbleSorted()
        }
    }

    func testBubbleSort2Performance() {
        measure {
            _ = unsorterArray.bubbleSorted2()
        }
    }
}

runTests(Tests())
