/*:
 # Overview
 Given a stream of integers and a window size, calculate the moving average of all integers in the sliding window.

 Implement the MovingAverage class:

 MovingAverage(int size) Initializes the object with the size of the window size.
 double next(int val) Returns the moving average of the last size values of the stream.


 Example 1:

 Input
 ["MovingAverage", "next", "next", "next", "next"]
 [[3], [1], [10], [3], [5]]
 Output
 [null, 1.0, 5.5, 4.66667, 6.0]

 Explanation
 MovingAverage movingAverage = new MovingAverage(3);
 movingAverage.next(1); // return 1.0 = 1 / 1
 movingAverage.next(10); // return 5.5 = (1 + 10) / 2
 movingAverage.next(3); // return 4.66667 = (1 + 10 + 3) / 3
 movingAverage.next(5); // return 6.0 = (10 + 3 + 5) / 3


 Constraints:

 1 <= size <= 1000
 -105 <= val <= 105
 At most 104 calls will be made to next.
 */

/*:
 # Code
 */

/*:
 # Tests
 */

class MovingAverage {

    private let size: Int
    private var queue = [Int]()
    private var sum: Double = 0

    init(_ size: Int) {
        self.size = size
    }

    func next(_ val: Int) -> Double {
        queue.append(val)
        sum += Double(val)

        while queue.count > size {
            let element = queue.removeFirst()
            sum -= Double(element)
        }

        return sum / Double(queue.count)
    }
}

import XCTest
class Tests: XCTestCase {
    func testMovingAverage() {
        let movingAvg = MovingAverage(3)
        XCTAssertEqual(movingAvg.next(1), 1.0)
        XCTAssertEqual(movingAvg.next(10), 5.5)
        XCTAssertEqual(movingAvg.next(3), 4.6666, accuracy: 0.1)
        XCTAssertEqual(movingAvg.next(5), 6.0)
    }
}

runTests(Tests())
