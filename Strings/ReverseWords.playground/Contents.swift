/*:
 # Overview
 Write a function that returns a string with each of its words reversed but in the original order, without using a loop.
 */

/*:
 # Code
 */

func reverse(_ str: String) -> String {
    let words = str.components(separatedBy: " ")
    return words
        .map { String($0.reversed()) }
        .joined(separator: " ")
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testReverse() {
        XCTAssertEqual(reverse("Swift Coding Challenges"), "tfiwS gnidoC segnellahC")
        XCTAssertEqual(reverse("The quick brown fox"), "ehT kciuq nworb xof")
    }
}

runTests(Tests())
