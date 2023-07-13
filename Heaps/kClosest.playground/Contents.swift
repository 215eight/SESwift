/*:
 # Overview
 Given an integer array nums and an integer k, return the kth largest element in the array.

 Note that it is the kth largest element in the sorted order, not the kth distinct element.

 Can you solve it without sorting?



 Example 1:

 Input: nums = [3,2,1,5,6,4], k = 2
 Output: 5
 Example 2:

 Input: nums = [3,2,3,1,2,4,5,5,6], k = 4
 Output: 4


 Constraints:

 1 <= k <= nums.length <= 105
 -104 <= nums[i] <= 104
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func kClosest(_ points: [[Int]], _ k: Int) -> [[Int]] {
    typealias Point = [Int]
    typealias DistancePoint = (distance: Double, point: Point)
    var minHeap = Heap(elements: [DistancePoint](),
                       priorityFunction: { (lhs: DistancePoint, rhs: DistancePoint) -> Bool in
        lhs.distance > rhs.distance
    })

    for point in points {
        let distance = distanceToOrigin(point: point)
        minHeap.enqueue((distance, point))

        if minHeap.count > k {
            minHeap.dequeue()
        }
    }

    var result = [Point]()
    while let distancePoint = minHeap.dequeue() {
        result.append(distancePoint.point)
    }
    return result
}

func distanceToOrigin(point: [Int]) -> Double {
    let x = point[0]
    let y = point[1]

    return sqrt(Double((x*x)+(y*y)))
}

import XCTest
class Tests: XCTestCase {
    func testKClosest() {
        XCTAssertEqual(kClosest([[1,3],[-2,2]], 1), [[-2,2]])
        XCTAssertEqual(kClosest([[3,3],[5,-1],[-2,4]], 2), [[-2,4], [3,3]])
    }
}

runTests(Tests())
