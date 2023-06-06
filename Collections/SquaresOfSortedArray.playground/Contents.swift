/*:
 # Overview
 Given an integer array nums sorted in non-decreasing order, return an array of the squares of each number sorted in non-decreasing order.
 */

/*:
 # Code
 Example 1:

 Input: nums = [-4,-1,0,3,10]
 Output: [0,1,9,16,100]
 Explanation: After squaring, the array becomes [16,1,0,9,100].
 After sorting, it becomes [0,1,9,16,100].
 Example 2:

 Input: nums = [-7,-3,2,3,11]
 Output: [4,9,9,49,121]
  

 Constraints:

 1 <= nums.length <= 104
 -104 <= nums[i] <= 104
 nums is sorted in non-decreasing order.
 
 */

/*:
 # Tests
 */

class Solution {
    func sortedSquares(_ nums: [Int]) -> [Int] {
        var start = 0
        var end = nums.count - 1
        var current = end
        var result = Array(repeating: 0, count: nums.count)
        while start <= end {
            let startAbsValue = abs(nums[start])
            let endAbsValue = abs(nums[end])
            
            let square: Int
            if startAbsValue > endAbsValue {
                square = startAbsValue * startAbsValue
                start += 1
            } else {
                square = endAbsValue * endAbsValue
                end -= 1
            }
            result[current] = square
            current -= 1
        }
        return result
    }
}

import XCTest
class Tests: XCTestCase {
    func testSortedSquares() {
        let solution = Solution()
        let result = solution.sortedSquares([-4, -1, 0, 3, 10])
        XCTAssertEqual(result, [0,1,9,16,100])
    }
}

runTests(Tests())
