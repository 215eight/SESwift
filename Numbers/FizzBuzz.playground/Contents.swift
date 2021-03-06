/*:
 # Overview
 Write a function that counts from 1 through 100, and prints “Fizz” if the counter is evenly divisible by 3, “Buzz” if it’s evenly divisible by 5, “Fizz Buzz” if it’s even divisible by three and five, or the counter number for all other cases.
 */

/*:
 # Code
 */

func fizzBizz(start: Int = 1, end: Int = 100) -> [String] {
    return (start...end).map {
        switch $0 {
        case _ where ($0 % 3 == 0 && $0 % 5 == 0):
            return "Fizz Buzz"
        case _ where $0 % 3 == 0:
            return "Fizz"
        case _ where $0 % 5 == 0:
            return "Buzz"
        default:
            return "\($0)"
        }
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testFizzBizz() {
        XCTAssertEqual(fizzBizz(start: 1, end: 15), ["1", "2", "Fizz", "4", "Buzz", "Fizz", "7", "8", "Fizz", "Buzz", "11", "Fizz", "13", "14", "Fizz Buzz"])
    }
}

runTests(Tests())
