/*:
 # Overview
 Example 1: 875. Koko Eating Bananas

 Koko loves to eat bananas. There are n piles of bananas, the ith pile has piles[i] bananas. Koko can decide her bananas-per-hour eating speed of k. Each hour, she chooses a pile and eats k bananas from that pile. If the pile has less than k bananas, she eats all of them and will not eat any more bananas during the hour. Return the minimum integer k such that she can eat all the bananas within h hours.
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func kokoEatsBananas(_ bananas: [Int], hours: Int) -> Int {
    var minSpeed = 1
    var maxSpeed = bananas.max() ?? 1

    while minSpeed <= maxSpeed {
        let speed = minSpeed + ((maxSpeed - minSpeed) / 2)
        let totalHours = bananas.reduce(0) { partialResult, count in
            Int((Double(count) / Double(speed)).rounded(.up)) + partialResult
        }
        print("Speed \(speed) - Total Hours \(totalHours)")

        if totalHours > hours {
            minSpeed = speed + 1
        } else {
            maxSpeed = speed - 1
        }
    }
    return minSpeed
}


import XCTest
class Tests: XCTestCase {
    func testKokoEatsBananas() {
        XCTAssertEqual(kokoEatsBananas([3,6,7,11], hours: 8), 4)
    }
}

runTests(Tests())
