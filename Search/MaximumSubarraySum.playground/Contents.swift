/*:
 # Overview
 */

/*:
 # Code
 */

func maximumSumSlow(a: [Int], m: Int) -> Int {
    var maxSumModulo = -1
    var matrix = Array(repeating: Array(repeating: -1, count: a.count),
                       count: a.count)

    for (x, value) in a.enumerated() {
        for y in 0 ... x {
            if y == 0 {
                let tempMaxSumModulo = value % m
                matrix[y][x] = tempMaxSumModulo
                if tempMaxSumModulo > maxSumModulo {
                    maxSumModulo = tempMaxSumModulo
                }
                continue
            } else {
                let prevX = x - 1
                let prevY = y - 1
                let tempMaxSumModulo = (matrix[prevY][prevX] + value) % m
                matrix[y][x] = tempMaxSumModulo
                if tempMaxSumModulo > maxSumModulo {
                    maxSumModulo = tempMaxSumModulo
                }
            }
        }
    }
    return maxSumModulo
}

func bisect(_ array: [Int], _ value: Int) -> Int {
    guard !array.isEmpty else { return 0 }
    var lhsIndex = 0
    var rhsIndex = array.count

    while lhsIndex < rhsIndex {
        let midPoint = lhsIndex + (rhsIndex - lhsIndex) / 2
        let midPointValue = array[midPoint]
        if midPointValue > value {
            rhsIndex = midPoint
        } else if midPointValue < value {
            lhsIndex = midPoint + 1
        } else {
            return midPoint
        }
    }
    return lhsIndex
}

func maximumSum(a: [Int], m: Int) -> Int {

    var cumulative_sums = [Int]()
    var sum_so_far = 0
    var max_sum = 0

    for index in (0 ..< a.count) {
        let value = a[index]
        sum_so_far = (sum_so_far + value) % m
        let position = bisect(cumulative_sums, sum_so_far)
        let digit = position == index ? 0 : cumulative_sums[position]
        max_sum = max(max_sum, (sum_so_far + m - digit) % m)
        let insertIndex = bisect(cumulative_sums, sum_so_far)
        if insertIndex < cumulative_sums.count {
            cumulative_sums.insert(sum_so_far, at: insertIndex)
        } else {
            cumulative_sums.append(sum_so_far)
        }
    }

    return max_sum
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testMaximumSum() {
        XCTAssertEqual(maximumSum(a: [3, 3, 9, 9, 5], m: 7), 6)
        XCTAssertEqual(maximumSum(a: [1, 2, 3], m: 2), 1)
        XCTAssertEqual(maximumSum(a: [1, 5, 9], m: 5), 4)
    }
}

runTests(Tests())

runTestCases(inputOffset: 2,
             inputBuilder: { lines -> (array: [Int], modulo: Int) in
                let firstLine = lines[0].components(separatedBy: .whitespaces)
                let modulo = Int(firstLine.last!)!

                let array = lines[1].components(separatedBy: .whitespaces)
                    .map { Int($0)! }
                return (array, modulo)
             }, outputOffset: 1,
             outputBuilder: { lines -> Int in
                return Int(lines[0])!
             }) { (input, output) -> Int in
    maximumSum(a: input.array, m: input.modulo)
}
