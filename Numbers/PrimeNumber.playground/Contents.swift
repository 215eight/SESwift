/*:
 # Overview
 Write a function that accepts an integer as its parameter and returns true if the number is prime.
 Tip: A number is considered prime if it is greater than one and has no positive divisors other than 1 and itself.
 */

/*:
 # Code
 */

func isPrime(_ a: Int) -> Bool {
    guard a > 1 else { return false }
    let upperBound = Int(sqrt(Double(a)).rounded(.up))
    var divisor = 2
    while divisor <= upperBound {
        guard a % divisor != 0 else { return false }
        divisor += 1
    }
    return true
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testIsPrimer() {
        XCTAssertTrue(isPrime(11))
        XCTAssertTrue(isPrime(13))
        XCTAssertTrue(isPrime(16777259))
        XCTAssertTrue(isPrime(67280421310721))
        XCTAssertFalse(isPrime(4))
        XCTAssertFalse(isPrime(9))
    }
}

runTests(Tests())
