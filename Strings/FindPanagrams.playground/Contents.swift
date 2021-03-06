/*:
 # Overview
 Write a function that returns true if it is given a string that is an English pangram, ignoring letter case.
 Tip: A pangram is a string that contains every letter of the alphabet at least once.
 */

/*:
 # Code
 */
func isPanagram(_ str: String) -> Bool {
    var runnerChar: Character = "a"
    var charSet = Set<Character>()

    repeat {
        charSet.insert(runnerChar)
        guard let unicodeValue = runnerChar.unicodeScalars.first?.value,
        let nextUnicodeValue = UnicodeScalar(unicodeValue + 1) else { break }
        runnerChar = Character(nextUnicodeValue)
    } while runnerChar >= "a" && runnerChar <= "z"

    str.lowercased()
        .forEach { charSet.remove($0) }

    return charSet.isEmpty
}

func isPanagram2(_ str: String) -> Bool {
    let set = Set(str.lowercased())
    let letters = set.filter { $0 >= "a" && $0 <= "z" }
    return letters.count == 26
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testIsPanagram() {
        XCTAssertTrue(isPanagram("The quick brown fox jumps over ther lazy dog"))
        XCTAssertFalse(isPanagram("The quick brown fox jumped over ther lazy dog"))
    }

    func testIsPanagram2() {
        XCTAssertTrue(isPanagram2("The quick brown fox jumps over ther lazy dog"))
        XCTAssertFalse(isPanagram2("The quick brown fox jumped over ther lazy dog"))
    }
}

runTests(Tests())
