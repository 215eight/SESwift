/*:
 # Overview
 Write a function that accepts a string, and returns how many times a specific character appears,
 taking case into account.
 Tip: If you can solve this without using a for-in loop, you can consider it a Tricky challenge.
*/

/*:
 # Code
 */
func count(_ character: Character, in str: String) -> Int {
    return str.reduce(0) { acc, currentCharacter in
        return currentCharacter == character ? acc + 1 : acc
    }
}

func count2(_ character: Character, in str: String) -> Int {
    var str = str
    var count = 0
    while !str.isEmpty {
        let current = str.removeFirst()
        if character == current { count += 1 }
    }
    return count
}

func count3(_ character: Character, in str: String) -> Int {
    let updatedString = str.replacingOccurrences(of: "\(character)", with: "")
    return str.count - updatedString.count
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testCountCharacter() {
        XCTAssertEqual(count("a", in: "The rain in Spain"), 2)
        XCTAssertEqual(count("i", in: "Mississippi"), 4)
        XCTAssertEqual(count("S", in: "Swift coding exercises"), 1)
        XCTAssertEqual(count("s", in: "Swift coding exercises"), 2)
    }

    func testCountCharacter2() {
        XCTAssertEqual(count2("a", in: "The rain in Spain"), 2)
        XCTAssertEqual(count2("i", in: "Mississippi"), 4)
        XCTAssertEqual(count2("S", in: "Swift coding exercises"), 1)
        XCTAssertEqual(count2("s", in: "Swift coding exercises"), 2)
    }

    func testCountCharacter3() {
        XCTAssertEqual(count3("a", in: "The rain in Spain"), 2)
        XCTAssertEqual(count3("i", in: "Mississippi"), 4)
        XCTAssertEqual(count3("S", in: "Swift coding exercises"), 1)
        XCTAssertEqual(count3("s", in: "Swift coding exercises"), 2)
    }
}

runTests(Tests())
