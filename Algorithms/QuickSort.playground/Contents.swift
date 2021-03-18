/*:
 # Overview
 Create an extension for arrays that sorts them using the quicksort algorithm.

 Tip #1: The quicksort algorithm picks an item from its array to use as the pivot point, then splits itself into either two parts (less than or greater than) or three (less, greater, or equal). These parts then repeat the pivot and split until the entire array has been split, then it gets rejoined so that less, equal, and greater are in order.

 Tip #2: I can write quicksort from memory, but I cannot write fully optimized quicksort from memory. It’s a complex beast to wrangle, and it requires careful thinking – honestly, I have better things to keep stored in what little space I have up there! So, don’t feel bad if your attempt is far from ideal: there’s no point creating a perfect solution if you struggle to remember it during an interview.

 Tip #3: Quicksort is an algorithm so well known and widely used that you don’t even write a space in its name – it’s “quicksort” rather than “quick sort”.
 */

/*:
 # Code
 */

extension Array where Element: Comparable {

    typealias Pivot = Array.Index

    mutating func quickSort() {
        return quickSort(lowerBound: startIndex, upperBound: endIndex)
    }

    private mutating func quickSort(lowerBound: Array.Index, upperBound: Array.Index) {
        guard lowerBound.distance(to: upperBound) > 1 else { return }

        let sortedElementIndex = upperBound - 1

        var pivot = lowerBound
        for index in (lowerBound ..< sortedElementIndex) {
            if self[index] < self[sortedElementIndex] {
                (self[pivot], self[index]) = (self[index], self[pivot])
                pivot += 1
            }
        }

        (self[pivot], self[sortedElementIndex]) = (self[sortedElementIndex], self[pivot])

        quickSort(lowerBound: lowerBound, upperBound: pivot)
        quickSort(lowerBound: pivot + 1, upperBound: upperBound)
    }

    func quickSorted() -> [Element] {
        var copy = self
        copy.quickSort()
        return copy
    }

    func quickSorted2() -> [Element] {
        guard count > 1 else { return self }

        let pivot = self.count / 2
        let pivotElement = self[pivot]
        var left = [Element]()
        var center = [Element]()
        var right = [Element]()

        for element in self {
            if element < pivotElement {
                left.append(element)
            } else if element == pivotElement {
                center.append(element)
            } else {
                right.append(element)
            }
        }
        return left.quickSorted2() + center + right.quickSorted2()
    }

    mutating func quickSort3(left: Int, right: Int) {
        guard left < right else { return }
        let pivot = self[right]
        var splitPoint = left

        for i in left ..< right {
            if self[i] < pivot {
                (self[i], self[splitPoint]) = (self[splitPoint], self[i])
                splitPoint += 1
            }
        }
        (self[right], self[splitPoint]) = (self[splitPoint], self[right])
        quickSort3(left: left, right: splitPoint - 1)
        quickSort3(left: splitPoint + 1, right: right)
    }

    func quickSorted3() -> [Element] {
        var copy = self
        copy.quickSort3(left: self.startIndex, right: self.endIndex - 1)
        return copy
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testQuickSort() {
        XCTAssertEqual([Int]().quickSorted(), [])
        XCTAssertEqual([1].quickSorted(), [1])
        XCTAssertEqual([1,2].quickSorted(), [1,2])
        XCTAssertEqual([2,1].quickSorted(), [1,2])
        XCTAssertEqual([3,2,1].quickSorted(), [1,2,3])
        XCTAssertEqual([2,1,3].quickSorted(), [1,2,3])
        XCTAssertEqual([12,5,4,9,3,2,1].quickSorted(), [1,2,3,4,5,9,12])
        XCTAssertEqual(["f","a","b"].quickSorted(), ["a","b","f"])
    }

    func testQuickSort2() {
        XCTAssertEqual([Int]().quickSorted2(), [])
        XCTAssertEqual([1].quickSorted2(), [1])
        XCTAssertEqual([1,2].quickSorted2(), [1,2])
        XCTAssertEqual([2,1].quickSorted2(), [1,2])
        XCTAssertEqual([3,2,1].quickSorted2(), [1,2,3])
        XCTAssertEqual([2,1,3].quickSorted2(), [1,2,3])
        XCTAssertEqual([12,5,4,9,3,2,1].quickSorted2(), [1,2,3,4,5,9,12])
        XCTAssertEqual(["f","a","b"].quickSorted2(), ["a","b","f"])
    }

    let input = (0 ..< 500).map { _ in Int(arc4random_uniform(100)) }

    func testPerformance() {
        measure {
            _ = input.quickSorted()
        }
    }

    func testPerformance2() {
        measure {
            _ = input.quickSorted2()
        }
    }

    func testPerformance3() {
        measure {
            _ = input.quickSorted3()
        }
    }

    func testQuickSortAllEqual() {
        let inputSorted = input.sorted()
        XCTAssertEqual(inputSorted, input.quickSorted())
        XCTAssertEqual(inputSorted, input.quickSorted2())
        XCTAssertEqual(inputSorted, input.quickSorted3())
    }
}

runTests(Tests())
