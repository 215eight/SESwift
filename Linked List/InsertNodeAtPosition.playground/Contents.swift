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

final class SinglyLinkedListNode {
    let nodeData: Int
    var next: SinglyLinkedListNode?

    init(nodeData: Int) {
        self.nodeData = nodeData
    }
}

func insertNodeAtPosition(llist: SinglyLinkedListNode?, data: Int, position: Int) -> SinglyLinkedListNode? {
    let newNode = SinglyLinkedListNode(nodeData: data)
    guard position > 0 else {
        newNode.next = llist
        return newNode
    }
    var runner = llist
    var currentPosition = 0
    while currentPosition < position - 1, let node = runner {
        runner = node.next
        currentPosition += 1
    }

    guard let node = runner else {
        return llist
    }
    newNode.next = node.next
    node.next = newNode

    return llist
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {

}

runTests(Tests())
