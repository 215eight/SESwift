/*:
 # Overview
 Create a function that accepts an unsigned 8-bit integer and returns its binary reverse, padded so that it holds precisely eight binary digits.
 Tip: When you get the binary representation of a number, Swift will always use as few bits as possible – make sure you pad to eight binary digits before reversing.

 */

/*:
 # Code
 */

func reverseBinary(_ input: UInt8) -> UInt8 {
    var input = input
    var reversedInput: UInt8 = 0
    for _ in (0..<8) {
        let leastSignificantBit = input & 1
        reversedInput <<= 1
        reversedInput |= leastSignificantBit
        input >>= 1
    }
    return reversedInput
}

func reverseBinary2(_ input: UInt8) -> UInt8 {
    let inputBinary = String(input, radix: 2)
    let paddingLength = 8 - inputBinary.count
    let paddedBinary = String(repeating: "0", count: paddingLength) + inputBinary
    let reversedInputBinary = String(paddedBinary.reversed())
    return UInt8(reversedInputBinary, radix: 2)!
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testReveseBinary() {
        XCTAssertEqual(reverseBinary(32), 4)
        XCTAssertEqual(reverseBinary(41), 148)
        XCTAssertEqual(reverseBinary(4), 32)
        XCTAssertEqual(reverseBinary(148), 41)
    }

    func testReveseBinary2() {
        XCTAssertEqual(reverseBinary2(32), 4)
        XCTAssertEqual(reverseBinary2(41), 148)
        XCTAssertEqual(reverseBinary2(4), 32)
        XCTAssertEqual(reverseBinary2(148), 41)
    }
}

runTests(Tests())
