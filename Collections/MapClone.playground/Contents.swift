/*:
 # Overview
 Write an extension for all collections that reimplements the map() method.
 */

/*:
 # Code
 */

extension Collection {
    func _map<T>(_ transform: @escaping (Element) throws -> T) rethrows -> [T] {
        var result = [T]()
        for element in self {
            result.append(try transform(element))
        }
        return result
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testMap() {
        XCTAssertEqual([1,2,3].map { String($0) }, ["1", "2", "3"])
        XCTAssertEqual(["1","2","3"].map { Int($0) ?? 0 }, [1,2,3])
    }
}

runTests(Tests())
