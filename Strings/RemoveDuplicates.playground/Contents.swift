/*:
 # Overview
 Write a function that accepts a string as its input, and returns the same string just with
 duplicate letters removed.
 Tip: If you can solve this challenge without a for-in loop, you can consider it “tricky” rather than “easy”.
 */

/*:
 # Code
 */

func removeDuplicates(_ str: String) -> String {
    var unique = Set<Character>()
    let filteredCharacters = str.filter {
        guard !unique.contains($0) else { return false }
        unique.insert($0)
        return true
    }
    return String(filteredCharacters)
}

func removeDuplicates2(_ str: String) -> String {
    var filteredStr = ""
    var str = str
    while !str.isEmpty {
        let character = str.removeFirst()
        if !filteredStr.contains(character) {
            filteredStr += "\(character)"
        }
    }
    return filteredStr
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testRemoveDuplicates() {
        XCTAssertEqual(removeDuplicates("combat"), "combat")
        XCTAssertEqual(removeDuplicates("hello"), "helo")
        XCTAssertEqual(removeDuplicates("Mississippi"), "Misp")
    }

    func testRemoveDuplicates2() {
        XCTAssertEqual(removeDuplicates2("combat"), "combat")
        XCTAssertEqual(removeDuplicates2("hello"), "helo")
        XCTAssertEqual(removeDuplicates2("Mississippi"), "Misp")
    }
}

runTests(Tests())
