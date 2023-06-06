/*:
 # Overview
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func largestUniqueNumber(_ nums: [Int]) -> Int {
    var largestCountMap = [Int : Int]()
    
    for num in nums {
        largestCountMap[num] = (largestCountMap[num] ?? 0) + 1
    }
    let result = largestCountMap
        .filter { $0.value == 1 }
        .sorted { lhs, rhs in
            lhs.key > rhs.key
        }
    print(largestCountMap)
    print(result)
    return result.first?.key ?? -1
}

import XCTest
class Tests: XCTestCase {
    func testLargestUniqueNumber() {
        XCTAssertEqual(largestUniqueNumber([5,7,3,9,4,9,8,3,1]), 8)
    }
}

runTests(Tests())
