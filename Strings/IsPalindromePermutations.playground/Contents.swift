/*
Write a function that checks whether any permutation of an input string is a palindrome.

You can assume the input string only contains lowercase letters.

Examples:

"civic" should return true
"ivicc" should return true
"civil" should return false
"livci" should return false
*/

import Foundation
import XCTest

func isPalindrome(_ str: String) -> Bool {
    var charSet = Set<Character>()
    for element in str {
        guard charSet.contains(element) else {
            charSet.insert(element)
            continue
        }
        charSet.remove(element)
    }
    return charSet.count <= 1
}

final class Tests: XCTestCase {

    func testIsPalindrome() {
        XCTAssertEqual(isPalindrome("civic"), true)
        XCTAssertEqual(isPalindrome("civci"), true)
        XCTAssertEqual(isPalindrome("sugus"), true)
        XCTAssertEqual(isPalindrome("ivicc"), true)
        XCTAssertEqual(isPalindrome("civil"), false)
        XCTAssertEqual(isPalindrome("livci"), false)
    }
}

Tests.self.defaultTestSuite.run()
