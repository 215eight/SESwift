/*:
 # Overview
 Write a function that returns the square root of a positive integer, rounded down to the nearest integer, without using sqrt().
 */

/*:
 # Code
 */

func squareRoot(_ input: Int) -> Int {
    guard input != 1 else { return 1 }
    var lowerBound = 1
    var upperBound = input / 2 + 1
    var middle = 0
    while lowerBound <= upperBound {
        middle = lowerBound + ((upperBound - lowerBound) / 2)
        let square = middle * middle
        switch square {
        case _ where square > input:
            upperBound = middle - 1
            break
        case _ where square < input:
            lowerBound = middle + 1
            break
        case _ where square == input:
            return middle
        default:
            return 0
        }
    }
    return middle
}

func squareRoot2(_ input: Int) -> Int {
    guard input != 1 else { return 1 }
    for i in 0 ... input / 2 + 1 {
        if i * i > input {
            return i - 1
        }
    }
    return 0
}

func squareRoot3(_ input: Int) -> Int {
    return Int(pow(Double(input), 0.5).rounded(.down))
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testSquareRoot() {
        XCTAssertEqual(squareRoot(9), 3)
        XCTAssertEqual(squareRoot(16777216), 4096)
        XCTAssertEqual(squareRoot(16), 4)
        XCTAssertEqual(squareRoot(15), 3)
    }

    func testSquareRoot2() {
        XCTAssertEqual(squareRoot2(9), 3)
        XCTAssertEqual(squareRoot2(16777216), 4096)
        XCTAssertEqual(squareRoot2(16), 4)
        XCTAssertEqual(squareRoot2(15), 3)
    }

    func testSquareRoot3() {
        XCTAssertEqual(squareRoot3(9), 3)
        XCTAssertEqual(squareRoot3(16777216), 4096)
        XCTAssertEqual(squareRoot3(16), 4)
        XCTAssertEqual(squareRoot3(15), 3)
    }
}

runTests(Tests())
