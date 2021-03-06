/*:
 # Overview
 Write a function that accepts positive minimum and maximum integers, and returns a random number between those two bounds, inclusive.
 */

/*:
 # Code
 */
func random(min: Int, max: Int) -> Int {
    guard min > 0, max > 0, min >= max else { return 0 }
    return Int.random(in: min...max)
}

func random2(min: Int, max: Int) -> Int {
    guard min > 0, max > 0, min >= max else { return 0 }
    return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testRandom() {
        XCTAssertTrue((0...10).contains(random(min: 0, max: 10)))
        XCTAssertTrue((0...0).contains(random(min: 0, max: 0)))
        XCTAssertTrue((10...10).contains(random(min: 10, max: 10)))
        XCTAssertTrue((0...0).contains(random(min: 10, max: 0)))
    }
    func testRandom2() {
        XCTAssertTrue((0...10).contains(random2(min: 0, max: 10)))
        XCTAssertTrue((0...0).contains(random2(min: 0, max: 0)))
        XCTAssertTrue((10...10).contains(random2(min: 10, max: 10)))
        XCTAssertTrue((0...0).contains(random2(min: 10, max: 0)))
    }
}

runTests(Tests())
