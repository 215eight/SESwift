/*:
 # Overview
 */

func merge<T: Comparable>(lhs: [T], rhs: [T]) -> (sorted: [T], inversions: Int) {
    var lhsIndex = 0
    var rhsIndex = 0

    var sorted = [T]()
    var inversions = 0

    while lhsIndex < lhs.count && rhsIndex < rhs.count {
        if lhs[lhsIndex] <= rhs[rhsIndex] {
            sorted.append(lhs[lhsIndex])
            lhsIndex += 1
        } else {
            sorted.append(rhs[rhsIndex])
            inversions += lhs.count - lhsIndex
            rhsIndex += 1
        }
    }

    while lhsIndex < lhs.count {
        sorted.append(lhs[lhsIndex])
        lhsIndex += 1
    }

    while rhsIndex < rhs.count {
        sorted.append(rhs[rhsIndex])
        rhsIndex += 1
    }

    return (sorted, inversions)
}

func mergeSort<T: Comparable>(_ array: [T], inversions: Int = 0) -> (sorted: [T], inversions: Int) {
    guard array.count > 1 else {
        return (array, inversions)
    }
    let midPoint = array.count / 2
    let lhs = mergeSort(Array(array[0 ..< midPoint]), inversions: inversions)
    let rhs = mergeSort(Array(array[midPoint ..< array.count]), inversions: inversions)
    let sorted = merge(lhs: lhs.sorted, rhs: rhs.sorted)
    return (sorted.sorted, rhs.inversions + lhs.inversions + sorted.inversions)
}

import XCTest

final class Test: XCTestCase {
    func testMergeSort() {
        XCTAssertEqual(mergeSort([1,2,3]).sorted, [1,2,3])
        XCTAssertEqual(mergeSort([3,2,1]).sorted, [1,2,3])
        XCTAssertEqual(mergeSort([Int]()).sorted, [])
        XCTAssertEqual(mergeSort([1]).sorted, [1])
        XCTAssertEqual(mergeSort([2,1,3,1,2]).sorted, [1,1,2,2,3])
    }
}

//runTests(Test())


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

func merge(_ array: inout [Int], sortedArray: inout [Int], lhs: Range<Int>, rhs: Range<Int>) -> Int {
    var inversions = 0
    var index = lhs.lowerBound
    var lhsIndex = lhs.lowerBound
    var rhsIndex = rhs.lowerBound

    while lhs.contains(lhsIndex), rhs.contains(rhsIndex) {
        let lhsValue = array[lhsIndex]
        let rhsValue = array[rhsIndex]

        if lhsValue <= rhsValue {
            sortedArray[index] =  lhsValue
            lhsIndex += 1
        } else {
            inversions += lhs.upperBound - lhsIndex
            sortedArray[index] = rhsValue
            rhsIndex += 1
        }
        index += 1
    }

    while lhs.contains(lhsIndex) {
        sortedArray[index] = array[lhsIndex]
        lhsIndex += 1
        index += 1
    }

    while rhs.contains(rhsIndex) {
        sortedArray[index] = array[rhsIndex]
        rhsIndex += 1
        index += 1
    }

    for i in lhs.lowerBound ..< rhs.upperBound {
        array[i] = sortedArray[i]
    }

    return inversions
}

func mergeSort2(_ array: [Int]) -> ([Int], Int) {
    var inversions = 0
    var array = array
    var sortedArray = array
    var subArrayLength = 1
    while subArrayLength < array.count {
        var subArrayIndex = 0
        while subArrayIndex < array.count {
            let lhsLower = subArrayIndex
            let lhsUpper = lhsLower + subArrayLength
            let lhs = (lhsLower ..< lhsUpper)

            let rhsLower = subArrayIndex + subArrayLength
            var rhsUpper = rhsLower + subArrayLength
            if rhsLower >= array.count {
                break
            }
            if rhsUpper > array.count {
                rhsUpper = array.count
            }
            let rhs = (rhsLower ..< rhsUpper)

            let subInversions = merge(&array, sortedArray: &sortedArray, lhs: lhs, rhs: rhs)
            inversions += subInversions
            subArrayIndex = subArrayIndex + 2 * subArrayLength
        }
        subArrayLength *= 2
    }
    return (sortedArray, inversions)
}


runTestCases(inputOffset: 2, inputBuilder: { lines -> [Int] in
    let line = lines[1]
    return line
        .components(separatedBy: .whitespaces)
        .map { Int($0)! }
}, outputOffset: 1,
outputBuilder: { lines in
    return Int(lines[0])!
}) { (input, output) in
    return mergeSort2(input).1
}
