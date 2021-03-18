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

        func partition(lowerBound: Array.Index,
                       upperBound: Array.Index) -> Pivot? {
            print("Start \(lowerBound) - \(upperBound)")
            guard lowerBound >= startIndex,
                  upperBound <= endIndex,
                  lowerBound < upperBound else { return nil }

            let sortElementIndex = upperBound.advanced(by: -1)
            guard sortElementIndex >= startIndex else  { return nil }

            let sortElement = self[sortElementIndex]

            var pivot = lowerBound
            for index in (lowerBound ..< sortElementIndex.advanced(by: -1)) {
                if self[index] > self[index] {
                    swapAt(index, index+1 )
                } else {
                    pivot = pivot.advanced(by: 1)
                }
            }
            print("End \(lowerBound) - \(upperBound) - \(pivot)")
            return pivot
        }

        guard let pivot = partition(lowerBound: lowerBound, upperBound: upperBound) else {
            return
        }
        quickSort(lowerBound: lowerBound, upperBound: pivot.advanced(by: -1))
        quickSort(lowerBound: pivot.advanced(by: 1), upperBound: upperBound)
    }

    func quickSorted() -> [Element] {
        var copy = self
        copy.quickSort()
        return self
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testQuickSort() {
//        XCTAssertEqual([Int]().quickSorted(), [])
//        XCTAssertEqual([1].quickSorted(), [1])
//        XCTAssertEqual([1,2].quickSorted(), [1,2])
        XCTAssertEqual([2,1].quickSorted(), [1,2])
//        XCTAssertEqual([3,2,1].quickSorted(), [1,2,3])
    }
}

runTests(Tests())
