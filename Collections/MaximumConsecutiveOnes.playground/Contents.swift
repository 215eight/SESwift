/*:
 # Overview
 Given a binary array nums and an integer k, return the maximum number of consecutive 1's in the array if you can flip at most k 0's.
 */

/*:
 # Code
 */

/*:
 # Tests
 Example 1:

 Input: nums = [1,1,1,0,0,0,1,1,1,1,0], k = 2
 Output: 6
 Explanation: [1,1,1,0,0,1,1,1,1,1,1]
 Bolded numbers were flipped from 0 to 1. The longest subarray is underlined.
 Example 2:

 Input: nums = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], k = 3
 Output: 10
 Explanation: [0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1]
 Bolded numbers were flipped from 0 to 1. The longest subarray is underlined.
  

 Constraints:

 1 <= nums.length <= 105
 nums[i] is either 0 or 1.
 0 <= k <= nums.length
 */

func longestOnes(_ nums: [Int], _ k: Int) -> Int {
    var maxCount = 0
    var zeroCount = 0
    var start = 0
    var end = start
    
    while end < nums.count {
        if nums[end] == 0 {
            zeroCount += 1
        }
        
        while zeroCount > k  {
            if nums[start] == 0 {
                zeroCount -= 1
            }
            start += 1
        }
        
        maxCount = max(maxCount, end - start + 1)
        end += 1
    }
    
    return maxCount
}

import XCTest
class Tests: XCTestCase {
    func testLongestOnes() {
        XCTAssertEqual(longestOnes([1,1,1,0,0,0,1,1,1,1,0], 2), 6)
        XCTAssertEqual(longestOnes([0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], 3), 10)
    }
}

runTests(Tests())
