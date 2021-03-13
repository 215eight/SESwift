/*:
 # Overview

 ## Challenge 1

 Create a linked list of lowercase English alphabet letters, along with a method that traverses all nodes and prints their letters on a single line separated by spaces.
 Tip #1: This is several problems in one. First, create a linked list data structure, which itself is really two things. Second, use your linked list to create the alphabet. Third, write a method traverses all nodes and prints their letters.
 Tip #2: You should use a class for this. Yes, really.
 Tip #3: Once you complete your solution, keep a copy of the code – you’ll need it for future challenges!

 ## Challenge 2
 Add a a reversed() method that returns a copy of itself in reverse.

 */

/*:
 # Code
 */

final class LinkedListNode<T: CustomStringConvertible> {
    let element: T
    var nextNode: LinkedListNode<T>? = nil

    init(_ element: T) {
        self.element = element
    }
}

final class LinkedList<T: CustomStringConvertible> {
    var head: LinkedListNode<T>? = nil

    init() {}

    init(arrayLiteral: T...) {
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

    var loopNode: LinkedListNode<T>? {
        var slow: LinkedListNode<T>? = head
        var fast: LinkedListNode<T>? = head

        while fast != nil && fast?.nextNode != nil {
            slow = slow?.nextNode
            fast = fast?.nextNode?.nextNode

            if slow === fast {
                break
            }
        }

        guard fast != nil && fast?.nextNode != nil else {
            return nil
        }

        slow = head

        while slow !== fast {
            fast = fast?.nextNode
            slow = slow?.nextNode
        }
        return slow
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testLinkedListWithLoop() {
        let alphabet = String("abcdefghijklmnopqrstuvwxyz")
        let linkedList = LinkedList(arrayLiteral: Array(alphabet))
        XCTAssertNil(linkedList.loopNode)

        let empty = LinkedList<Int>()
        XCTAssertNil(empty.loopNode)

        let single = LinkedList(arrayLiteral: [1])
        XCTAssertNil(single.loopNode)

        let two = LinkedList(arrayLiteral: [1, 2])
        XCTAssertNil(two.loopNode)


        let loopList = LinkedList<Int>()

        var previousNode: LinkedListNode<Int>? = nil
        var linkBackNode: LinkedListNode<Int>? = nil
        let linkBackPoint = Int(arc4random_uniform(10))

        for i in 0 ..< 10 {
            let node = LinkedListNode(Int(arc4random()))
            if i == linkBackPoint {
                linkBackNode = node
            }
            if let predecessor = previousNode {
                predecessor.nextNode = node
            } else {
                loopList.head = node
            }
            previousNode = node
        }
        previousNode?.nextNode = linkBackNode

        XCTAssertTrue(loopList.loopNode === linkBackNode)
    }
}

runTests(Tests())
