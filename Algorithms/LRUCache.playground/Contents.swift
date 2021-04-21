/*:
 # Overview
 LRU Cache Implementation
 */

/*:
 # Code
 */

final class Node<T> {
    let value: T
    var parentNode: Node? = nil
    var nextNode: Node? = nil

    init(value: T) {
        self.value = value
    }
}

final class Queue<T: CustomStringConvertible> {

    private let maxCapacity: Int
    var capacity: Int = 0
    private var head: Node<T>?
    private var tail: Node<T>?

    init(maxCapacity: Int) {
        self.maxCapacity = maxCapacity
    }

    var isEmpty: Bool {
        head == nil && tail == nil
    }

    func push(_ node: Node<T>) {
        guard maxCapacity > 0 else {
            return
        }

        defer {
            capacity += 1
        }

        if capacity == maxCapacity {
            pop()
        }

        guard !isEmpty else {
            self.head = node
            self.tail = node
            return
        }

        head?.parentNode = node
        node.nextNode = head
        self.head = node
    }

    func remove(_ node: Node<T>) -> Node<T> {
        defer {
            capacity -= 1
        }
        node.parentNode?.nextNode = node.nextNode
        node.nextNode?.parentNode = node.parentNode

        if head === node {
            head = node.nextNode
        }

        if tail === node {
            tail = node.parentNode
        }

        node.parentNode = nil
        node.nextNode = nil

        return node
    }

    func pop() -> Node<T>? {
        guard !isEmpty else {
            return nil
        }

        defer {
            capacity -= 1
        }

        if head === tail {
            head = nil
        }

        let temp = tail
        tail = tail?.parentNode
        tail?.nextNode = nil
        temp?.parentNode = nil
        temp?.nextNode = nil

        return temp
    }

    var description: String {
        var result = ""
        var optionalRunner = head
        while let runner = optionalRunner {
            if !result.isEmpty {
                result += " "
            }
            result += runner.value.description
            optionalRunner = runner.nextNode
        }
        return result
    }
}

final class LRUCache<K: Hashable, T: CustomStringConvertible> {

    private let queue: Queue<T>
    private var keyValueMap = [K: Node<T>]()

    init(maxCapacity: Int) {
        self.queue = Queue(maxCapacity: maxCapacity)
    }

    func put(value: T, key: K) {
        if let existingValue = keyValueMap[key] {
            queue.remove(existingValue)
        }
        let node = Node(value: value)
        keyValueMap[key] = node
        queue.push(node)
    }

    func get(key: K) -> T? {
        guard let existingValue = keyValueMap[key] else {
            return nil
        }
        queue.remove(existingValue)
        queue.push(existingValue)
        return existingValue.value
    }

    var description: String {
        return queue.description +
            "\n" +
            keyValueMap.reduce("", { (acc, tuple) in
                acc + "(\(tuple.key): \(tuple.value.value))"
            })
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {


    func test_Queue_zeroCapacity() {
        let queue = Queue<Int>(maxCapacity: 0)
        queue.push(Node(value: 1))
        XCTAssertEqual(queue.description, "")
        XCTAssertEqual(queue.capacity, 0)
    }

    func test_Queue_push() {
        let queue = Queue<Int>(maxCapacity: 2)
        queue.push(Node(value: 1))
        queue.push(Node(value: 2))
        XCTAssertEqual(queue.description, "2 1")
        XCTAssertEqual(queue.capacity, 2)
    }

    func test_Queue_pushOverCapacity() {
        let queue = Queue<Int>(maxCapacity: 2)
        queue.push(Node(value: 1))
        queue.push(Node(value: 2))
        queue.push(Node(value: 3))
        queue.push(Node(value: 4))

        XCTAssertEqual(queue.description, "4 3")
        XCTAssertEqual(queue.capacity, 2)
    }

    func test_Queue_remove() {
        let queue = Queue<Int>(maxCapacity: 2)
        let node1 = Node(value: 1)
        let node2 = Node(value: 2)
        queue.push(node1)
        queue.push(node2)
        queue.remove(node1)
        queue.remove(node2)

        XCTAssertEqual(queue.description, "")
        XCTAssertEqual(queue.capacity, 0)
        XCTAssertTrue(queue.isEmpty)
    }

    func test_Queue_remove_single() {
        let queue = Queue<Int>(maxCapacity: 2)
        let node1 = Node(value: 1)
        queue.push(node1)
        queue.remove(node1)

        XCTAssertEqual(queue.description, "")
        XCTAssertEqual(queue.capacity, 0)
        XCTAssertTrue(queue.isEmpty)
    }

    func test_Queue_popEmpty() {
        let queue = Queue<Int>(maxCapacity: 2)
        queue.pop()

        XCTAssertEqual(queue.description, "")
        XCTAssertEqual(queue.capacity, 0)
        XCTAssertTrue(queue.isEmpty)
    }

    func test_Queue_pop() {
        let queue = Queue<Int>(maxCapacity: 2)
        queue.push(Node(value: 1))
        queue.push(Node(value: 2))
        queue.push(Node(value: 3))
        queue.push(Node(value: 4))

        XCTAssertEqual(queue.description, "4 3")
        XCTAssertEqual(queue.capacity, 2)

        queue.pop()
        queue.pop()
        queue.pop()
        queue.pop()

        XCTAssertEqual(queue.description, "")
        XCTAssertEqual(queue.capacity, 0)
        XCTAssertTrue(queue.isEmpty)
    }

    func testLRUCache() {
        let cache = LRUCache<Int, Int>(maxCapacity: 5)
        cache.put(value: 1, key: 1)
        cache.put(value: 1, key: 1)
        cache.put(value: 2, key: 2)
        cache.put(value: 3, key: 3)
        cache.put(value: 4, key: 4)
        cache.put(value: 5, key: 5)
        print(cache.description)
        cache.put(value: 6, key: 6)
        print(cache.description)
        cache.put(value: 7, key: 7)
        print(cache.description)
        cache.put(value: 8, key: 8)
        print(cache.description)
        cache.get(key: 8)
        print(cache.description)
    }
}

runTests(Tests())
