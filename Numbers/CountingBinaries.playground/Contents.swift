/*:
 # Overview
 Create a function that accepts any positive integer and returns the next highest and next lowest number that has the same number of ones in its binary representation. If either number is not possible, return nil for it.
 */

/*:
 # Code
 */

func findNubmerOfOnes(_ input: Int) -> Int {
    var count = 0
    var input = input
    while input != 0 {
        count += input & 1
        input >>= 1
    }
    return count
}

func countingBinary(_ input: Int) -> (nextHighest: Int, nextLowest: Int) {
    var (nextHighest, nextLowest) = (0, 0)
    let targetNumberOfOnes = findNubmerOfOnes(input)

    for i in (input + 1 ... Int.max) {
        if findNubmerOfOnes(i) == targetNumberOfOnes {
            nextHighest = i
            break
        }
    }
    for i in (0 ..< input).reversed() {
        if findNubmerOfOnes(i) == targetNumberOfOnes {
            nextLowest = i
            break
        }
    }
    return (nextHighest, nextLowest)
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func tetsFindNumberOfOnes() {
        XCTAssertEqual(findNubmerOfOnes(0), 0)
        XCTAssertEqual(findNubmerOfOnes(1), 1)
        XCTAssertEqual(findNubmerOfOnes(2), 1)
        XCTAssertEqual(findNubmerOfOnes(3), 2)
        XCTAssertEqual(findNubmerOfOnes(4), 1)
        XCTAssertEqual(findNubmerOfOnes(5), 2)
        XCTAssertEqual(findNubmerOfOnes(6), 2)
        XCTAssertEqual(findNubmerOfOnes(6), 7)
    }

    func testCountingBinary() {
        var result = countingBinary(12)
        XCTAssertEqual(result.nextLowest, 10)
        XCTAssertEqual(result.nextHighest, 17)
        result = countingBinary(28)
        XCTAssertEqual(result.nextLowest, 26)
        XCTAssertEqual(result.nextHighest, 35)
    }
}

runTests(Tests())
