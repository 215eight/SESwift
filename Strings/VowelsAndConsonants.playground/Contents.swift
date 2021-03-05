/*:
 # Overview
 Given a string in English, return a tuple containing the number of vowels and consonants.
 Tip: Vowels are the letters, A, E, I, O, and U; consonants are the letters B, C, D, F, G, H, J, K, L, M, N, P, Q, R, S, T, V, W, X, Y, Z.

 */

/*:
 # Code
 */

func count(_ str: String) -> (vowels: Int, consonants: Int) {
    var charSet = Set<Character>()
    var runnerChar: Character = "a"

    repeat {
        charSet.insert(runnerChar)
        guard let unicodeValue = runnerChar.unicodeScalars.first?.value,
        let nextUnicodeValue = UnicodeScalar(unicodeValue + 1) else { break }
        runnerChar = Character(nextUnicodeValue)
    } while runnerChar >= "a" && runnerChar <= "z"

    let vowelsSet = Set<Character>(arrayLiteral: "a", "e", "i", "o", "u")
    let consonantsSet = charSet.subtracting(vowelsSet)

    let initialResult = (vowels: 0, consonants: 0)
    return str.lowercased()
        .reduce(initialResult) { acc, char in
            (vowels: acc.vowels + (vowelsSet.contains(char) ? 1 : 0),
             consonants: acc.consonants + (consonantsSet.contains(char) ? 1 : 0))
        }

}

func count2(_ str: String) -> (vowels: Int, consonants: Int) {
    let vowelsSet = Set(Array("aeiou"))
    let consonantsSet = Set(Array("bcdfghjklmnpqrstvwxyz"))
    let initialResult = (vowels: 0, consonants: 0)
    return str.lowercased()
        .reduce(initialResult) { acc, char in
            (vowels: acc.vowels + (vowelsSet.contains(char) ? 1 : 0),
             consonants: acc.consonants + (consonantsSet.contains(char) ? 1 : 0))
        }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testCount() {
        XCTAssertEqual(count("Swift Coding Challenges").vowels, 6)
        XCTAssertEqual(count("Swift Coding Challenges").consonants, 15)
        XCTAssertEqual(count("Mississippi").vowels, 4)
        XCTAssertEqual(count("Mississippi").consonants, 7)
    }
    func testCount2() {
        XCTAssertEqual(count2("Swift Coding Challenges").vowels, 6)
        XCTAssertEqual(count2("Swift Coding Challenges").consonants, 15)
        XCTAssertEqual(count2("Mississippi").vowels, 4)
        XCTAssertEqual(count2("Mississippi").consonants, 7)
    }
}

runTests(Tests())
