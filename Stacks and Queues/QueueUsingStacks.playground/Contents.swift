/*:
 # Overview
 */

/*:
 # Code
 */

class Node<T> {
    let value: T
    var previous: Node?
    var next: Node?

    var isHead: Bool {
        return previous == nil
    }

    var isTail: Bool {
        return next == nil
    }

    init(value: T) {
        self.value = value
    }
}

class Stack<T> {

    private var head: Node<T>? = nil

    var isEmpty: Bool {
        return head == nil
    }

    func push(_ element: T) {
        let newNode = Node(value: element)
        guard let head = head else {
            self.head = newNode
            return
        }
        head.next = newNode
        newNode.previous = head
        self.head = newNode
    }

    func pop() -> T? {
        guard let head = head else {
            return nil
        }
        let temp = head
        self.head = head.previous
        self.head?.next = nil
        temp.previous = nil
        return temp.value
    }

    var top: T? {
        return head?.value
    }
}


final class Queue<T> {

    private var head: Node<T>? = nil
    private var tail: Node<T>? = nil

    var isEmpty: Bool {
        return head == nil && tail == nil
    }

    func enqueue(_ element: T) {
        let newNode = Node(value: element)
        guard !isEmpty else {
            self.head = newNode
            self.tail = newNode
            return
        }

        newNode.next = tail
        tail?.previous = newNode

        self.tail = newNode
    }

    func dequeue() -> T? {
        guard !isEmpty else {
            return nil
        }
        let temp = head
        head = head?.previous
        head?.next = nil

        if tail === temp {
            tail = nil
        }
        temp?.previous = nil
        temp?.next = nil
        return temp?.value
    }

    func front() -> T? {
        return head?.value
    }
}


/*:

 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testQueue() {
        "".components(separatedBy: .whitespaces)
        var queue = Queue<Int>()
        queue.enqueue(42)
        XCTAssertEqual(queue.dequeue(), 42)
        queue.enqueue(14)
        XCTAssertEqual(queue.front(), 14)
        queue.enqueue(28)
        XCTAssertEqual(queue.front(), 14)
        queue.enqueue(60)
        queue.enqueue(78)
        XCTAssertEqual(queue.dequeue(), 14)
        XCTAssertEqual(queue.dequeue(), 28)
    }
}

runTests(Tests())
