/*:
 # Overview
 Suppose I can type in a string and the app will show me all merchants that match that string.
 I'm lazy, and I want to know how to type the shortest string possible to uniquely match each merchant name.

 Given an input list of names, for each name, find the shortest substring that only appears in that name.

 Example:

 Input: ['cheapair', 'cheapoair', 'peloton', 'pelican']
 Output:
 {
    'cheapair':  'pa',  # every other 1-2 length substring overlaps with 'cheapoair'
    'cheapoair': 'po',  # 'oa' would also be acceptable
    'peloton':   't',   # this single letter doesn't occur in any other name
    'pelican':   'ca',  # 'li', 'ic', or 'an' would also be acceptable
 }
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func shortestSearchTerm(_ input: [String]) -> [String : String] {
    var tracker = [String : [String]]()

    for entry in input {
        var windowSize = entry.count
        while windowSize > 0 {
            var runner = entry.startIndex
            var stop = entry.index(entry.endIndex, offsetBy: -windowSize)
            while runner <= stop {
                defer {
                    runner = entry.index(runner, offsetBy: 1)
                }
                let subString = String(entry[runner ..< entry.index(runner, offsetBy: windowSize)])
                tracker[subString] = (tracker[subString] ?? []) + [entry]
            }
            windowSize -= 1
        }
    }

    var result = [String : String]()
    for tuple in tracker {
        guard tuple.value.count == 1, let word = tuple.value.first else {
            continue
        }
        guard let potentialSubstring = result[word] else {
            result[word] = tuple.key
            continue
        }
        if potentialSubstring.count > tuple.key.count {
            result[word] = tuple.key
        }
    }
    return result
}

import XCTest
class Tests: XCTestCase {

    func testShortestSearchTerm() {
        XCTAssertEqual(shortestSearchTerm([]), [:])
        XCTAssertEqual(shortestSearchTerm(["a"]), ["a":"a"])
        XCTAssertEqual(shortestSearchTerm([""]), [String: String]())
        XCTAssertEqual(shortestSearchTerm(["a", "b"]), ["a":"a", "b":"b"])
        XCTAssertEqual(
            shortestSearchTerm(["abc1", "bca2", "cab3", "abc", "bca", "cab"]),
            ["abc1":"1", "bca2":"2", "cab3": "3"]
        )
        XCTAssertEqual(
            shortestSearchTerm(["abcd", "bcda", "cdab", "dabc"]),
            ["abcd":"abcd", "bcda":"bcda", "cdab": "cdab", "dabc": "dabc"]
        )
        let result = shortestSearchTerm(["cheapair", "cheapoair", "peloton", "pelican"])
        XCTAssertEqual(result["cheapair"],"pa")
        XCTAssertTrue(["po", "oa"].contains(result["cheapoair"] ?? ""))
        XCTAssertTrue(result["peloton"] == "t")
        XCTAssertTrue(["ca", "li", "ic", "an"].contains(result["pelican"] ?? ""))
    }
}

runTests(Tests())
