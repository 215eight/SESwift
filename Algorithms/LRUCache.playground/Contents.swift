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
        defer {
            capacity += 1
        }
        guard !isEmpty else {
            self.head = node
            self.tail = node
            return
        }

        if capacity == maxCapacity {
            pop()
        }

        head?.parentNode = node
        node.nextNode = head
        self.head = node
    }

    func remove(_ node: Node<T>) -> Node<T> {
        node.parentNode?.nextNode = node.nextNode
        node.nextNode?.parentNode = node.parentNode

        node.parentNode = nil
        node.nextNode = nil

        capacity -= 1

        return node
    }

    func pop() -> Node<T>? {
        defer {
            capacity -= 1
        }
        guard !isEmpty else {
            return nil
        }

        let temp = tail
        tail?.parentNode?.nextNode = nil
        tail = tail?.parentNode
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
    func testQueue() {
        let queue = Queue<Int>(maxCapacity: 5)
        let node0 = Node(value: 0)
        queue.push(node0)
        XCTAssertEqual(queue.description, "0")
        queue.remove(node0)
        XCTAssertEqual(queue.description, "")
        queue.push(node0)
        queue.push(node0)
        XCTAssertEqual(queue.description, "0 0")
        queue.remove(node0)
        XCTAssertEqual(queue.description, "0")

        queue.push(Node(value: 1))
        queue.push(Node(value: 2))
        queue.push(Node(value: 3))
        let node4 = Node(value: 4)
        queue.push(node4)

        XCTAssertEqual(queue.description, "4 3 2 1 0")
        XCTAssertEqual(queue.capacity, 5)

        queue.pop()
        XCTAssertEqual(queue.description, "4 3 2 1")
        XCTAssertEqual(queue.capacity, 4)

        queue.pop()
        XCTAssertEqual(queue.description, "4 3 2")
        XCTAssertEqual(queue.capacity, 3)

        queue.push(Node(value: 5))
        queue.push(Node(value: 6))
        XCTAssertEqual(queue.description, "6 5 4 3 2")
        XCTAssertEqual(queue.capacity, 5)

        queue.remove(node4)
        XCTAssertEqual(queue.description, "6 5 3 2")
        XCTAssertEqual(queue.capacity, 4)

        queue.push(Node(value: 7))
        XCTAssertEqual(queue.description, "7 6 5 3 2")
        XCTAssertEqual(queue.capacity, 5)

        queue.push(Node(value: 8))
        XCTAssertEqual(queue.description, "8 7 6 5 3")
        XCTAssertEqual(queue.capacity, 5)
    }

    func testLRUCache() {
        let cache = LRUCache<Int, Int>(maxCapacity: 5)
        cache.put(value: 1, key: 1)
        print(cache.description)
        cache.put(value: 1, key: 1)
        print(cache.description)
        cache.put(value: 1, key: 1)
        print(cache.description)
    }
}

runTests(Tests())
