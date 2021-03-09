/*:
 # Overview
 */

/*:
 # Code
 */
final class LinkedListNode<T: CustomStringConvertible> {
    let value: T
    var nextNode: LinkedListNode<T>? = nil

    init(_ value: T) {
        self.value = value
    }
}

extension LinkedListNode: CustomStringConvertible {
    var description: String {
        if let nextNode = self.nextNode {
            return value.description + " " + nextNode.description
        } else {
            return value.description
        }
    }
}

final class LinkedList<T: CustomStringConvertible> {
    var head: LinkedListNode<T>? = nil

    init(_ element: T) {
        head = LinkedListNode(element)
    }

    init(arrayLiteral: [T]) {
        var optionalPreviousNode: LinkedListNode<T>? = head
        for element in arrayLiteral {
            let newNode = LinkedListNode(element)
            guard let previousNode = optionalPreviousNode else {
                head = newNode
                optionalPreviousNode = newNode
                continue
            }
            previousNode.nextNode = newNode
            optionalPreviousNode = newNode
        }
    }
}

extension LinkedList: CustomStringConvertible {

    var description: String {
        guard let head = head else { return "" }
        return head.description
    }

    var midElement: T? {
        var slowRunner = head
        var fastRunner = head
        while slowRunner != nil && fastRunner != nil {
            guard let fastRunnerNextNode = fastRunner?.nextNode?.nextNode else { break }
            slowRunner = slowRunner?.nextNode
            fastRunner = fastRunnerNextNode
        }
        return slowRunner?.value
    }
}

indirect enum LLNode<T> {
    case empty
    case node(value: T, nextNode: LLNode)

    init(value: T) {
        self = .node(value: value, nextNode: .empty)
    }

    init(arrayLiteral: [T]) {
        var optionalLastNode: LLNode<T>? = nil
        for i in arrayLiteral.reversed() {
            if let lastNode = optionalLastNode {
                let node: LLNode = .node(value: i, nextNode: lastNode)
                optionalLastNode = node
            } else {
                let node: LLNode = .node(value: i, nextNode: .empty)
                optionalLastNode = node
            }
        }

        guard let head = optionalLastNode else {
            self = .empty
            return
        }
        self = head
    }

    var description: String {
        switch self {
        case .empty:
            return ""
        case .node(value: let value, nextNode: let nextNode):
            switch nextNode {
            case .empty:
                return "\(value)"
            case .node:
                return "\(value)" + " " + nextNode.description
            }
        }
    }

    var nextNode: LLNode<T>? {
        guard case .node(value: _, nextNode: let nextNode) = self else {
            return nil
        }
        return nextNode
    }

    var value: T? {
        guard case .node(value: let value, nextNode: _) = self else {
            return nil
        }
        return value
    }


    var midElement: T? {
        var slowRunner: LLNode<T>? = self
        var fastRunner: LLNode<T>? = self
        while slowRunner != nil && fastRunner != nil {
            guard fastRunner?.nextNode?.nextNode?.value != nil else {
                break
            }
            slowRunner = slowRunner?.nextNode
            fastRunner = fastRunner?.nextNode?.nextNode
        }
        return slowRunner?.value
    }
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testLinkedListMidElement() {
        let list1 = LinkedList(arrayLiteral: [1,2,3,4,5])
        XCTAssertEqual(list1.midElement, 3)

        let list2 = LinkedList(arrayLiteral: [1,2,3,4])
        XCTAssertEqual(list2.midElement, 2)

        let alphabet = String("abcdefghijklmnopqrstuvwxyz")
        let list3 = LinkedList(arrayLiteral: Array(alphabet))
        XCTAssertEqual(list3.midElement, "m")

        let list4 = LinkedList(arrayLiteral: [Int]())
        XCTAssertEqual(list4.midElement, nil)
    }

    func testLLMidElement() {
        let list1 = LLNode(arrayLiteral: [1,2,3,4,5])
        XCTAssertEqual(list1.midElement, 3)

        let list2 = LLNode(arrayLiteral: [1,2,3,4])
        XCTAssertEqual(list2.midElement, 2)

        let alphabet = String("abcdefghijklmnopqrstuvwxyz")
        let list3 = LLNode(arrayLiteral: Array(alphabet))
        XCTAssertEqual(list3.midElement, "m")

        let list4 = LLNode(arrayLiteral: [Int]())
        XCTAssertEqual(list4.midElement, nil)
    }
}

runTests(Tests())
