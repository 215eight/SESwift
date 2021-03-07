/*:
 # Overview
 Given a string that contains both letters and numbers, write a function that pulls out all the numbers then returns their sum.
 */

/*:
 # Code
 */

func addNumbers(_ input: String) -> Int {
    let components = input.components(separatedBy: CharacterSet.letters)
    return components.reduce(0) { (acc, strNumber) in
        guard let number = Int(strNumber) else { return acc }
        return acc + number
    }
}

func addNumbers2(_ input: String) -> Int {
    return input
        .replacingOccurrences(of: "\\D+", with: "-",options: .regularExpression)
        .split(separator: "-")
        .reduce(0) { $0 + Int(String($1))! }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testAddNumbers() {
        XCTAssertEqual(addNumbers("a1b2c3"), 6)
        XCTAssertEqual(addNumbers("a10b20c30"), 60)
        XCTAssertEqual(addNumbers("h8ers"), 8)
    }
    func testAddNumbers2() {
        XCTAssertEqual(addNumbers2("a1b2c3"), 6)
        XCTAssertEqual(addNumbers2("a10b20c30"), 60)
        XCTAssertEqual(addNumbers2("h8ers"), 8)
    }
}

runTests(Tests())
