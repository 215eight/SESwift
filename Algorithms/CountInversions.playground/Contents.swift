/*:
 # Overview
 */

/*:
 # Code
 */

func merge<T: Comparable>(lhs: [T], rhs: [T]) -> (sorted: [T], inversions: Int) {
    var sortedArray = [T]()
    var (lhsIndex, rhsIndex) = (0,0)
    var inversions = 0
    while lhsIndex < lhs.count || rhsIndex < rhs.count {
        guard lhsIndex < lhs.count, rhsIndex < rhs.count else {
            if lhsIndex < lhs.count {
                sortedArray.append(contentsOf: lhs[lhsIndex...])
                lhsIndex = lhs.count
            } else {
                sortedArray.append(contentsOf: rhs[rhsIndex...])
                rhsIndex = rhs.count
            }
            continue
        }

        if lhs[lhsIndex] <= rhs[rhsIndex] {
            sortedArray.append(lhs[lhsIndex])
            lhsIndex += 1
        } else {
            sortedArray.append(rhs[rhsIndex])
            inversions += (lhs.count - lhsIndex)
            rhsIndex += 1
        }
    }
    return (sortedArray, inversions)
}

func mergeSort<T: Comparable>(_ array: [T], inversions: Int = 0) -> (sorted: [T], inversions: Int) {
    guard array.count > 1 else {
        return (array, inversions)
    }
    let midPoint = array.count / 2
    let lefttHalf = mergeSort(Array(array[..<midPoint]), inversions: inversions)
    let righttHalf = mergeSort(Array(array[midPoint...]), inversions: inversions)
    let result = merge(lhs: lefttHalf.sorted, rhs: righttHalf.sorted)
    return (result.sorted, lefttHalf.inversions + righttHalf.inversions + result.inversions)
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testMergeSort() {
        var result = mergeSort([Int]())
        XCTAssertEqual(result.sorted, [])
        XCTAssertEqual(result.inversions, 0)

        result = mergeSort([1])
        XCTAssertEqual(result.sorted, [1])
        XCTAssertEqual(result.inversions, 0)

        result = mergeSort([1,2])
        XCTAssertEqual(result.sorted, [1,2])
        XCTAssertEqual(result.inversions, 0)

        result = mergeSort([2,1])
        XCTAssertEqual(result.sorted, [1,2])
        XCTAssertEqual(result.inversions, 1)

        result = mergeSort([3,2,1])
        XCTAssertEqual(result.sorted, [1,2,3])
        XCTAssertEqual(result.inversions, 3)

        result = mergeSort([2,0,3])
        XCTAssertEqual(result.sorted, [0,2,3])
        XCTAssertEqual(result.inversions, 1)

        result = mergeSort([2,0,1,3])
        XCTAssertEqual(result.sorted, [0,1,2,3])
        XCTAssertEqual(result.inversions, 2)
    }
}

runTests(Tests())

runTestCases(inputOffset: 2, inputBuilder: { lines -> [Int] in
    let line = lines[1]
    return line
        .components(separatedBy: .whitespaces)
        .map { Int($0)! }
}, outputOffset: 1,
outputBuilder: { lines in
    return Int(lines[0])!
}) { (input, output) in
    return mergeSort(input).inversions
}
