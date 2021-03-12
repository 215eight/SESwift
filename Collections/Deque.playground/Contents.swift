/*:
 # Overview
 Create a new data type that models a double-ended queue using generics, or deque. You should be able to push items to the front or back, pop them from the front or back, and get the number of items.
 */

/*:
 # Code
 */

final class Deque<T> {

    private var storage = [T]()

    var count: Int {
        return storage.count
    }

    func pushFront(_ element: T) {
        storage.insert(element, at: 0)
    }

    func pushBack(_ element: T) {
        storage.append(element)
    }

    func popFront() -> T? {
        guard !storage.isEmpty else { return nil }
        return storage.removeFirst()
    }

    func popBack() -> T? {
        guard !storage.isEmpty else { return nil }
        return storage.removeLast()
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testDeque() {
        let numbers = Deque<Int>()
        numbers.pushBack(5)
        numbers.pushBack(8)
        numbers.pushBack(3)
        XCTAssertEqual(numbers.count, 3)
        XCTAssertEqual(numbers.popFront(), 5)
        XCTAssertEqual(numbers.popBack(), 3)
        XCTAssertEqual(numbers.popFront(), 8)
        XCTAssertEqual(numbers.popFront(), nil)
    }
}

runTests(Tests())
