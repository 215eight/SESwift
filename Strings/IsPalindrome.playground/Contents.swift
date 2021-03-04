/*:
 # Overview
 Write a function that accepts a String as its only parameter, and returns true if the string reads
 the same when reversed, ignoring case.
 [Palindrome Wikipedia](https://en.wikipedia.org/wiki/Palindrome)
*/

/*:
 # Code
*/

func isPalindrome(_ str: String) -> Bool {
    let lowerCased = str.lowercased()
    let reversedLowerCased = lowerCased.reversed()
    return lowerCased == String(reversedLowerCased)
}

func isPalindrome2(_ str: String) -> Bool {
    guard !str.isEmpty else { return true }
    let arrayLowerCased = Array(str.lowercased())
    let midPoint = arrayLowerCased.count / 2
    var firstHalf = arrayLowerCased[..<midPoint]
    var secondHalf = arrayLowerCased[midPoint...]

    while !firstHalf.isEmpty, !secondHalf.isEmpty {
        let head = firstHalf.removeFirst()
        let tail = secondHalf.removeLast()
        guard head == tail else { return false }
    }

    return true
}

/*:
 # Tests
*/

import XCTest
class Tests: XCTestCase {
    func testIsPalindrome() {
        XCTAssertTrue(isPalindrome(""))
        XCTAssertTrue(isPalindrome("a"))
        XCTAssertTrue(isPalindrome("rotator"))
        XCTAssertTrue(isPalindrome("Rats live on no evil star"))
        XCTAssertFalse(isPalindrome("Never odd or even"))
        XCTAssertFalse(isPalindrome("Hello, world"))
    }

    func testIsPalindrome2() {
        XCTAssertTrue(isPalindrome2(""))
        XCTAssertTrue(isPalindrome2("a"))
        XCTAssertTrue(isPalindrome2("rotator"))
        XCTAssertTrue(isPalindrome2("Rats live on no evil star"))
        XCTAssertFalse(isPalindrome2("Never odd or even"))
        XCTAssertFalse(isPalindrome2("Hello, world"))
    }
}

runTests(Tests())
