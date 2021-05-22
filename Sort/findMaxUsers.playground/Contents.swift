/*:
 # Overview

 Find the point where maximum intervals overlap

 Consider a big party where a log register for guest’s entry and exit times is maintained. Find the time at which there are maximum guests in the party. Note that entries in register are not in any order.


 Input:
 arrl[] = {1, 2, 9, 5, 5}
 exit[] = {4, 5, 12, 9, 12}

 First guest in array arrives at 1 and leaves at 4,
 second guest arrives at 2 and leaves at 5, and so on.

 Output: 5
 There are maximum 3 guests at time 5.
 */

/*:
 # Code
 */
import Combine

struct LogEntry {
    let name: String
    let start: Int
    let end: Int
}

struct GenericError: Error {}

func csvEntryComponents(_ input: String) -> [String] {
    var result = [String]()
    var searchRange = input.startIndex ..< input.endIndex
    while let range = input.range(of: "\".*?\"", options: .regularExpression, range: searchRange, locale: nil) {
        let substring = input[range.lowerBound..<range.upperBound]
            .replacingOccurrences(of: "\"", with: "")
        result += [substring]
        searchRange = range.upperBound ..< input.endIndex
        guard range != searchRange else { break }
    }
    return result
}

func csvLogEntry(_ input: String) -> LogEntry? {
    let components = csvEntryComponents(input)
    guard components.count == 3 else { return nil }
    guard let name = components.first,
          let start = Int(components[1]),
          let end = Int(components[2]) else {
        return nil
    }
    return LogEntry(name: name, start: start, end: end)
}

func fetchLogRecors(at: URL) -> AnyPublisher<[LogEntry], GenericError> {
    URLSession.shared
        .dataTaskPublisher(for: url)
        .map { $0.data }
        .map { String(data: $0, encoding: .ascii) }

}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testFoo() {
        XCTAssertTrue(true)
    }
}

runTests(Tests())
