/*:
 # Overview
 Write your own version of the contains() method on String that ignores letter case, and
 without using the existing contains() method.
*/

/*:
 # Code
*/

extension String {
    func fuzzyContains(_ str: String) -> Bool {
        let lowercased = Array(self.lowercased())
        let strLowercased = str.lowercased()

        guard lowercased.count >= strLowercased.count else { return false }

        for offset in (0 ... (lowercased.count - strLowercased.count)) {
            let slice = lowercased[offset ..< (offset + str.count)]
            if String(slice) == strLowercased { return true }
        }
        return false
    }

    func fuzzyContains2(_ str: String) -> Bool {
        var lowercased = self.lowercased()
        let strLowercased = str.lowercased()

        while lowercased.count >= strLowercased.count {
            if lowercased.starts(with: strLowercased) { return true }
            else {
                lowercased.removeFirst()
            }
        }
        return false
    }

    func fuzzyContains3(_ str: String) -> Bool {
        return range(of: str, options: .caseInsensitive, range: nil, locale: nil) != nil
    }
    
    func naiveFuzzyMatch(_ str: String) -> Bool {
        let regex = str.reduce("") { acc, char in
            return acc.appending("\(char).*")
        }
        return range(of: regex, options: [.regularExpression, .caseInsensitive], range: nil, locale: nil) != nil
    }
}

/*:
 # Tests
*/

import XCTest
class Tests: XCTestCase {
    func testFuzzyContains() {
        XCTAssertTrue("Hello, world".fuzzyContains("Hello"))
        XCTAssertTrue("Hello, world".fuzzyContains("WORLD"))
        XCTAssertFalse("Hello, world".fuzzyContains("Goodbye"))
    }
    func testFuzzyContains2() {
        XCTAssertTrue("Hello, world".fuzzyContains2("Hello"))
        XCTAssertTrue("Hello, world".fuzzyContains2("WORLD"))
        XCTAssertFalse("Hello, world".fuzzyContains2("Goodbye"))
    }
    func testFuzzyContains3() {
        XCTAssertTrue("Hello, world".fuzzyContains3("Hello"))
        XCTAssertTrue("Hello, world".fuzzyContains3("WORLD"))
        XCTAssertFalse("Hello, world".fuzzyContains3("Goodbye"))
    }
    
    func testNaiveFuzzyMatch() {
        XCTAssertTrue("Hello, world".naiveFuzzyMatch("hod"))
        XCTAssertTrue("Hello, world".naiveFuzzyMatch("Hod"))
        XCTAssertTrue("Hello, world".naiveFuzzyMatch("Hw"))
        XCTAssertTrue("Hello, world".naiveFuzzyMatch("hw"))
    }
}

runTests(Tests())
