/*:
 # Overview
 Write a function that accepts two String parameters, and returns true if they contain the same
 characters in any order taking into account letter case.
*/

/*:
 # Code
*/

func haveSameCharacters(_ rhs: String, _ lhs: String) -> Bool {
    return Set(rhs) == Set(lhs)
}

func haveSameCharacters2(_ rhs: String, _ lhs: String) -> Bool {
    return rhs.sorted() == lhs.sorted()
}

/*:
 # Tests
*/

import XCTest
class Tests: XCTestCase {
    func testHaveSameCharacters() {
        XCTAssertTrue(haveSameCharacters("abca", "abca"))
        XCTAssertTrue(haveSameCharacters("abc", "cba"))
        XCTAssertTrue(haveSameCharacters("a1 b2", "b1 a2"))
        XCTAssertTrue(haveSameCharacters("aabaa", "aaaab"))
        XCTAssertFalse(haveSameCharacters("abc", "Abc"))
        XCTAssertFalse(haveSameCharacters("abc", "cbAa"))
        XCTAssertFalse(haveSameCharacters("abcc", "cbAa"))
    }

    func testHaveSameCharacters2() {
        XCTAssertTrue(haveSameCharacters2("abca", "abca"))
        XCTAssertTrue(haveSameCharacters2("abc", "cba"))
        XCTAssertTrue(haveSameCharacters2("a1 b2", "b1 a2"))
        XCTAssertTrue(haveSameCharacters2("aabaa", "aaaab"))
        XCTAssertFalse(haveSameCharacters2("abc", "Abc"))
        XCTAssertFalse(haveSameCharacters2("abc", "cbAa"))
        XCTAssertFalse(haveSameCharacters2("abcc", "cbAa"))
    }
}

runTests(Tests())
