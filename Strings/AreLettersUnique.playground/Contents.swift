/*:
 # Overview
 Write a function that accepts a String as its only parameter, and returns true if the string has only unique letters, taking letter case into account.
*/

/*:
 # Code
*/

func areLettersUnique(_ str: String) -> Bool {
    let uniqueLetters = Set(str)
    return uniqueLetters.count == str.count
}

func areLettersUnique2(_ str: String) -> Bool {
    var uniqueLetters = Set<Character>()
    var areLettersUnique = true
    for char in str {
        guard areLettersUnique else { break }
        if uniqueLetters.contains(char) {
            areLettersUnique = false
        } else {
            uniqueLetters.insert(char)
        }
    }
    return areLettersUnique
}

/*:
 # Tests
*/

import XCTest
class Tests: XCTestCase {
    func testAreTheLettersUnique() {
        XCTAssertTrue(areLettersUnique("No duplicates"))
        XCTAssertTrue(areLettersUnique("abcdefghijklmnopqrstuvwxyz"))
        XCTAssertTrue(areLettersUnique("AaBbCc"))
        XCTAssertFalse(areLettersUnique("Hello, world"))
    }

    func testAreTheLettersUnique2() {
        XCTAssertTrue(areLettersUnique("No duplicates"))
        XCTAssertTrue(areLettersUnique("abcdefghijklmnopqrstuvwxyz"))
        XCTAssertTrue(areLettersUnique("AaBbCc"))
        XCTAssertFalse(areLettersUnique("Hello, world"))
    }
}

runTests(Tests())
