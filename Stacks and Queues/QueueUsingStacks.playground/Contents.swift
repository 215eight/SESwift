/*:
 # Overview
 */

/*:
 # Code
 */

struct Stack<T> {

    private var stack = [T]()

    var isEmpty: Bool {
        return stack.isEmpty
    }

    mutating func push(_ element: T) {
        stack.append(element)
    }

    mutating func pop() -> T? {
        guard !stack.isEmpty else {
            return nil
        }
        return stack.removeLast()
    }

    var top: T? {
        return stack.last
    }
}


struct Queue<T> {

    private var stack = Stack<T>()
    private var tempStack = Stack<T>()
    private var isInverted = false

    mutating func enqueue(_ element: T) {
        if isInverted {
            while let element = tempStack.pop() {
                stack.push(element)
            }
            stack.push(element)
            isInverted = false
        } else {
            stack.push(element)
        }

    }

    mutating func dequeue() -> T? {
        if isInverted {
            return tempStack.pop()
        } else {
            while let element = stack.pop() {
                tempStack.push(element)
            }
            isInverted = true
            return tempStack.pop()
        }
    }

    mutating func front() -> T? {
        if isInverted {
            return tempStack.top
        } else {
            while let element = stack.pop() {
                tempStack.push(element)
            }
            isInverted = true
            return tempStack.top
        }
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
