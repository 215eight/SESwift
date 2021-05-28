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
        return next == nil
    }

    var isTail: Bool {
        return previous == nil
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

final class Queue2Stacks<T> {

    private var inputStack = Stack<T>()
    private var outputStack = Stack<T>()

    var isEmpty: Bool {
        return inputStack.isEmpty && outputStack.isEmpty
    }

    func enqueue(_ element: T) {
        inputStack.push(element)
    }

    func dequeue() -> T? {
        guard !isEmpty else {
            return nil
        }

        if let lastOutput = outputStack.pop() {
            return lastOutput
        }

        while let temp = inputStack.pop() {
            outputStack.push(temp)
        }

        return outputStack.pop()
    }

    func front() -> T? {
        if let lastOutput = outputStack.top {
            return lastOutput
        }
        while let temp = inputStack.pop() {
            outputStack.push(temp)
        }
        return outputStack.top
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
        let queue = Queue<Int>()
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

    func testQueue2Stacks() {
        let queue = Queue2Stacks<Int>()
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
