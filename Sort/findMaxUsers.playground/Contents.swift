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

enum EntryType: Comparable {
    case start(year: Int)
    case end(year: Int)

    var year: Int {
        switch self {
        case .start(year: let year),
             .end(year: let year):
            return year
        }
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.start(year: let lYear), .start(year: let rYear)),
             (.end(year: let lYear), .end(year: let rYear)):
            return lYear == rYear
        default:
            return false

        }
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.start(year: let lYear), .end(year: let rYear)):
            return lYear <= rYear
        case (.end(year: let lYear), .start(year: let rYear)):
            return lYear < rYear
        case (.start(year: let lYear), .start(year: let rYear)):
            return lYear < rYear
        case (.end(year: let lYear), .end(year: let rYear)):
            return lYear < rYear
        }
        
    }
}

struct FlatLogEntry {

    let name: String
    let type: EntryType

    var delta: Int {
        switch type {
        case .start:
            return 1
        case .end:
            return -1
        }
    }
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

func fetchLogRecords(at url: URL) -> AnyPublisher<[LogEntry], GenericError> {
    URLSession.shared
        .dataTaskPublisher(for: url)
        .map { $0.data }
        .compactMap { String(data: $0, encoding: .utf8) }
        .map { $0.components(separatedBy: .newlines) }
        .map { $0.compactMap(csvLogEntry) }
        .mapError { _ in GenericError() }
        .eraseToAnyPublisher()
}

func buildFlatList(_ input: [LogEntry]) -> [FlatLogEntry] {
    return input.flatMap {
        [
            FlatLogEntry(name: $0.name, type: .start(year: $0.start)),
            FlatLogEntry(name: $0.name, type: .end(year: $0.end))
        ]
    }
//    .sorted { $0.type.year < $1.type.year }
    .sorted { $0.type < $1.type }
}

func findMaxGuests(_ input: [FlatLogEntry]) -> (max: Int, year: Int) {
    typealias CountYear = (count: Int, year: Int)
    let initialResult = (queue: [CountYear](), max: 0, year: 0)
    let result = input.reduce(initialResult) { acc, logEntry in
        guard let last = acc.queue.last else {
            return (
                queue: [(count: 1, year: logEntry.type.year)],
                max: 1,
                year: logEntry.type.year
            )
        }

        if last.year < logEntry.type.year {
            let newCount = last.count + logEntry.delta
            return (
                queue: acc.queue + [(count: newCount, year: logEntry.type.year)],
                max: newCount > acc.max ? newCount : acc.max,
                year: newCount > acc.max ? logEntry.type.year : acc.year
            )
        } else if last.year == logEntry.type.year {
            var queue = acc.queue
            queue.removeLast()

            let newCount = last.count + logEntry.delta
            return (
                queue: queue + [(count: last.count + logEntry.delta, year: logEntry.type.year)],
                max: newCount > acc.max ? newCount : acc.max,
                year: newCount > acc.max ? logEntry.type.year : acc.year
            )
        } else {
            fatalError()
        }
    }

    return (result.max , result.year)
}

let urlString = "https://gist.githubusercontent.com/akhiln/f24909a23731b3d8339e3ba5b66b9543/raw/e69f28fb4b1ad0b7caba591046b40e33d053538a/small-companies-year.csv"

var cancellables = Set<AnyCancellable>()

func foo(at urlString: String) {
    guard let url = URL(string: urlString) else { return }
    fetchLogRecords(at: url)
        .map(buildFlatList)
        .map(findMaxGuests)
        .sink { _ in
        } receiveValue: { result in
            print(result)
        }
        .store(in: &cancellables)
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testEntyTypeComparable() {
        XCTAssertTrue(EntryType.start(year: 2000) < EntryType.end(year: 2000))
        XCTAssertTrue(EntryType.start(year: 2000) < EntryType.end(year: 2001))
        XCTAssertTrue(EntryType.start(year: 2000) == EntryType.start(year: 2000))
        XCTAssertFalse(EntryType.start(year: 2000) < EntryType.start(year: 2000))
    }

    func testFindMatGuests() {
        let log = [
            LogEntry(name: "Foo", start: 1, end: 4),
            LogEntry(name: "Foo", start: 2, end: 5),
            LogEntry(name: "Foo", start: 10, end: 12),
            LogEntry(name: "Foo", start: 5, end: 9),
            LogEntry(name: "Foo", start: 5, end: 12)
        ]
        let result = findMaxGuests(buildFlatList(log))
        XCTAssertEqual(result.year, 5)
        XCTAssertEqual(result.max, 3)
    }
}

runTests(Tests())
