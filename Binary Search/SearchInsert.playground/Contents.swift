/*:
 # Overview
 Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

 You must write an algorithm with O(log n) runtime complexity.



 Example 1:

 Input: nums = [1,3,5,6], target = 5
 Output: 2
 Example 2:

 Input: nums = [1,3,5,6], target = 2
 Output: 1
 Example 3:

 Input: nums = [1,3,5,6], target = 7
 Output: 4


 Constraints:

 1 <= nums.length <= 104
 -104 <= nums[i] <= 104
 nums contains distinct values sorted in ascending order.
 -104 <= target <= 104
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    var left = 0
    var right = nums.count - 1

    while left <= right {
        let mid = left + ((right - left) / 2)
        if nums[mid] == target {
            return mid
        } else if nums[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return left
}

import XCTest
class Tests: XCTestCase {
    func testSearchInsert() {
        XCTAssertEqual(searchInsert([1,3,5,6], 5), 2)
        XCTAssertEqual(searchInsert([1,3,5,6], 2), 1)
        XCTAssertEqual(searchInsert([1,3,5,6], 7), 4)
    }
}

runTests(Tests())
