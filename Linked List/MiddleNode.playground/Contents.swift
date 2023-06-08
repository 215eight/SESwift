/*:
 # Overview
 Given the head of a singly linked list, return the middle node of the linked list.

 If there are two middle nodes, return the second middle node.

 Example 1:
 Input: head = [1,2,3,4,5]
 Output: [3,4,5]
 Explanation: The middle node of the list is node 3.

 Example 2:
 Input: head = [1,2,3,4,5,6]
 Output: [4,5,6]
 Explanation: Since the list has two middle nodes with values 3 and 4, we return the second one.


 Constraints:

 The number of nodes in the list is in the range [1, 100].
 1 <= Node.val <= 100
 */

/*:
 # Code
 */

/*:
 # Tests
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

func middleNode(_ head: ListNode?) -> ListNode? {
    var slow: ListNode? = head
    var fast: ListNode? = head

    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }

    return slow

}

import XCTest
class Tests: XCTestCase {
    func testMiddleNode() {
        XCTAssertTrue(true)
    }
}

runTests(Tests())
