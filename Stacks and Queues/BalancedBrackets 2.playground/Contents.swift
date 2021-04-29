/*:
 # Overview
 Write a function that accepts a string containing the characters (, [, {, <, >, }, ], and ) in any arrangement and frequency. It should return true if the brackets are opened and closed in the correct order, and if all brackets are closed. Any other input should false.
 */

/*:
 # Code
 */

func balancedBrackets(_ input: String) -> Bool {
    let brackets: [Character: Character] = [
        "(" : ")",
        "[" : "]",
        "{" : "}",
        "<" : ">",
    ]
    let closingBrackets = Set(brackets.values)

    var queue = [Character]()
    for element in input {
        if let closingBracket = brackets[element] {
            queue.append(closingBracket)
        } else if closingBrackets.contains(element) {
            guard queue.last == element else { return false }
            queue.removeLast()
        } else {
            return false
        }
    }
    return queue.isEmpty
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testBalancedBrackets() {
        XCTAssertTrue(balancedBrackets("()"))
        XCTAssertTrue(balancedBrackets("([])"))
        XCTAssertTrue(balancedBrackets("([])(<{}>)"))
        XCTAssertTrue(balancedBrackets("([]{}<[{}]>)"))
        XCTAssertTrue(balancedBrackets(""))
        XCTAssertFalse(balancedBrackets("}{"))
        XCTAssertFalse(balancedBrackets("([)]"))
        XCTAssertFalse(balancedBrackets("([)"))
        XCTAssertFalse(balancedBrackets("(["))
        XCTAssertFalse(balancedBrackets("[<<<{}>>]"))
        XCTAssertFalse(balancedBrackets("hello"))
    }
}

runTests(Tests())
