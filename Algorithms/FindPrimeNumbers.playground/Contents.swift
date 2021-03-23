/*:
 # Overview
 Write a function that returns an array of prime numbers from 2 up to but excluding N, taking care to be as efficient as possible.
 Tip: Calculating primes is easy. Calculating primes efficiently is not. Take care!
 */

/*:
 # Code
 */

func findPrimes(upTo limit: Int) -> [Int] {
    guard limit > 1 else { return [] }

    var primes = [Int]()

    var value = 2
    while value < limit {
        var isPrime = true

        let checkLimit = Int(ceil(sqrt(Double(value))))
        for prime in primes {
            if prime > checkLimit {
                break
            }

            if value % prime == 0 {
                isPrime = false
                break
            }
        }

        if isPrime {
            primes.append(value)
        }
        value += 1
    }

    return primes
}

func findPrimes2(upTo limit: Int) -> [Int] {
    guard limit > 1 else { return [] }

    var primeIndexes = Array(repeating: true, count: limit)
    primeIndexes[0] = false
    primeIndexes[1] = false

    var runner = 2
    while runner < limit {
        defer {
            runner += 1
        }
        guard primeIndexes[runner] else { continue }

        for multipleIndex in stride(from: runner * runner, to: limit, by: runner) {
            primeIndexes[multipleIndex] = false
        }
    }

    return primeIndexes
        .enumerated()
        .compactMap {
            guard $0.element == true else { return nil }
            return $0.offset
        }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testFindPrimes() {
        XCTAssertEqual(findPrimes(upTo: 10), [2,3,5,7])
        XCTAssertEqual(findPrimes(upTo: 11), [2,3,5,7])
        XCTAssertEqual(findPrimes(upTo: 12), [2,3,5,7,11])
        XCTAssertEqual(findPrimes(upTo: 27), [2,3,5,7,11,13,17,19,23])
    }
    func testFindPrimes2() {
        XCTAssertEqual(findPrimes2(upTo: 10), [2,3,5,7])
        XCTAssertEqual(findPrimes2(upTo: 11), [2,3,5,7])
        XCTAssertEqual(findPrimes2(upTo: 12), [2,3,5,7,11])
        XCTAssertEqual(findPrimes2(upTo: 27), [2,3,5,7,11,13,17,19,23])
    }
}

runTests(Tests())
