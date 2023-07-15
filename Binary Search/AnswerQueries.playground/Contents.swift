/*:
 # Overview
 You are given an integer array nums of length n, and an integer array queries of length m.

 Return an array answer of length m where answer[i] is the maximum size of a subsequence that you can take from nums such that the sum of its elements is less than or equal to queries[i].

 A subsequence is an array that can be derived from another array by deleting some or no elements without changing the order of the remaining elements.



 Example 1:

 Input: nums = [4,5,2,1], queries = [3,10,21]
 Output: [2,3,4]
 Explanation: We answer the queries as follows:
 - The subsequence [2,1] has a sum less than or equal to 3. It can be proven that 2 is the maximum size of such a subsequence, so answer[0] = 2.
 - The subsequence [4,5,1] has a sum less than or equal to 10. It can be proven that 3 is the maximum size of such a subsequence, so answer[1] = 3.
 - The subsequence [4,5,2,1] has a sum less than or equal to 21. It can be proven that 4 is the maximum size of such a subsequence, so answer[2] = 4.
 Example 2:

 Input: nums = [2,3,4,5], queries = [1]
 Output: [0]
 Explanation: The empty subsequence is the only subsequence that has a sum less than or equal to 1, so answer[0] = 0.


 Constraints:

 n == nums.length
 m == queries.length
 1 <= n, m <= 1000
 1 <= nums[i], queries[i] <= 106
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func answerQueries(_ nums: [Int], _ queries: [Int]) -> [Int] {

    var accSum = 0
    let sortedNumSum = nums
        .sorted { $0 < $1 }
        .map { value in
            let sum = value + accSum
            accSum = sum
            return sum
        }

    var answer = [Int]()
    for query in queries {
        let index = binarySearch(sortedNumSum, query)
        answer.append(index)
    }
    return answer
}

func binarySearch(_ array: [Int], _ target: Int) -> Int {
    var left = 0
    var right = array.count - 1
    while left <= right {
        let mid = left + ((right - left) / 2)
        if array[mid] == target {
            return mid + 1
        } else if array[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return left
}

import XCTest
class Tests: XCTestCase {
    func testAnswerQueriesoo() {
        XCTAssertEqual(answerQueries([4,5,2,1], [3,10,21]), [2,3,4])
        XCTAssertEqual(answerQueries([2,3,4,5], [1]), [0])
    }
}

runTests(Tests())
