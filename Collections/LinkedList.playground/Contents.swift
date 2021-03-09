/*:
 # Overview
 Create a linked list of lowercase English alphabet letters, along with a method that traverses all nodes and prints their letters on a single line separated by spaces.
 Tip #1: This is several problems in one. First, create a linked list data structure, which itself is really two things. Second, use your linked list to create the alphabet. Third, write a method traverses all nodes and prints their letters.
 Tip #2: You should use a class for this. Yes, really.
 Tip #3: Once you complete your solution, keep a copy of the code – you’ll need it for future challenges!
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
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testLinkedListClass() {
        let alphabet = String("abcdefghijklmnopqrstuvwxyz")
        let linkedList = LinkedList(arrayLiteral: Array(alphabet))
        XCTAssertEqual(linkedList.description, "a b c d e f g h i j k l m n o p q r s t u v w x y z")
    }
    func testLLEnum() {
        let alphabet = String("abcdefghijklmnopqrstuvwxyz")
        let linkedList = LLNode(arrayLiteral: Array(alphabet))
        XCTAssertEqual(linkedList.description, "a b c d e f g h i j k l m n o p q r s t u v w x y z")
    }
}

runTests(Tests())
