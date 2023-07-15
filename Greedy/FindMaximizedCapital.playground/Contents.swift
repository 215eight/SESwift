/*:
 # Overview
 LeetCode would like to work on some projects to increase its capital before IPO. You are given n projects where the ith project has a profit of profits[i] and a minimum capital of capital[i] is needed to start it. Initially, you have w capital. When you finish a project, the profit will be added to your total capital. Return the max capital possible if you are allowed to do up to k projects.
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func findMaximizedCapital(_ k: Int, _ w: Int, profits: [Int], capital: [Int]) -> Int {
    typealias ProfitCapital = (profit: Int, capital: Int)
    var profitsCapital = zip(profits, capital)
        .sorted { lhs, rhs in
            lhs.1 < rhs.1
        }
    var maxHeap = Heap(elements: [ProfitCapital]()) { lhs, rhs in
        lhs.profit > rhs.profit
    }

    var totalCapital = w
    for _ in (0 ..< k) {
    innerLoop: for item in profitsCapital {
        if item.1 <= totalCapital {
            maxHeap.enqueue(item)
        } else {
            break innerLoop
        }
    }
        totalCapital += maxHeap.dequeue()?.profit ?? 0
    }
    return totalCapital
}

import XCTest
class Tests: XCTestCase {
    func testFindMaximizedCapital() {
        let profits = [12,6,20,1,3]
        let capital = [5,2, 7,0,0]
        let totalCapital = findMaximizedCapital(3, 1, profits: profits, capital: capital)
        XCTAssertEqual(totalCapital, 30)
    }
}

runTests(Tests())
