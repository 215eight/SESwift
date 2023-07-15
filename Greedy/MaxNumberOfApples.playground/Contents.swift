/*:
 # Overview
 You have some apples and a basket that can carry up to 5000 units of weight.

 Given an integer array weight where weight[i] is the weight of the ith apple, return the maximum number of apples you can put in the basket.



 Example 1:

 Input: weight = [100,200,150,1000]
 Output: 4
 Explanation: All 4 apples can be carried by the basket since their sum of weights is 1450.
 Example 2:

 Input: weight = [900,950,800,1000,700,800]
 Output: 5
 Explanation: The sum of weights of the 6 apples exceeds 5000 so we choose any 5 of them.


 Constraints:

 1 <= weight.length <= 103
 1 <= weight[i] <= 103
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func maxNumberOfApples(_ weight: [Int]) -> Int {
    let sortedWeight = weight.sorted { lhs, rhs in
        lhs < rhs
    }

    var maxWeight = 5000
    var currentWeight = 0
    var appleCount = 0

    for weight in sortedWeight {
        let updatedWeight = currentWeight + weight
        if updatedWeight <= maxWeight {
            currentWeight = updatedWeight
            appleCount += 1
        } else {
            break
        }
    }

    return appleCount
}

import XCTest
class Tests: XCTestCase {
    func testMaxNumberOfApples() {
        XCTAssertEqual(maxNumberOfApples([100,200,150,1000]), 4)
        XCTAssertEqual(maxNumberOfApples([900,950,800,1000,700,800]), 5)
    }
}

runTests(Tests())
