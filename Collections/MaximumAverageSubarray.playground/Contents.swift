/*:
 # Overview
 You are given an integer array nums consisting of n elements, and an integer k.

 Find a contiguous subarray whose length is equal to k that has the maximum average value and return this value. Any answer with a calculation error less than 10-5 will be accepted.
 */

/*:
 # Code
 */

/*:
 # Tests
 
 Example 1:

 Input: nums = [1,12,-5,-6,50,3], k = 4
 Output: 12.75000
 Explanation: Maximum average is (12 - 5 - 6 + 50) / 4 = 51 / 4 = 12.75
 Example 2:

 Input: nums = [5], k = 1
 Output: 5.00000
  

 Constraints:

 n == nums.length
 1 <= k <= n <= 105
 -104 <= nums[i] <= 104
 
 */

import XCTest

class Solution {
    func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
        var maxAverage: Double? = nil
        var currentSum: Int? = nil
        var start = 0
        var end = k - 1
        
        while end < nums.count {
            defer {
                start += 1
                end += 1
            }
            guard let sum = currentSum else {
                let sum = nums[start ... end]
                    .reduce(0) { $0 + $1 }
                currentSum = sum
                maxAverage = Double(sum) / Double(k)
                continue
            }
            let updatedSum = sum - nums[start - 1] + nums[end]
            currentSum = updatedSum
            let average = Double(updatedSum) / Double(k)
            maxAverage = max(average, maxAverage ?? average)
        }
        
        return maxAverage ?? 0.0
    }
}

class Tests: XCTestCase {
    func testFindMaxAverage() {
        let solution = Solution()
        var result: Double = 0.0

        result = solution.findMaxAverage([1,12,-5,-6,50,3], 4)
        XCTAssertEqual(result, 12.75)
        
        result = solution.findMaxAverage([-1], 1)
        XCTAssertEqual(result, -1)
    }
}

runTests(Tests())
