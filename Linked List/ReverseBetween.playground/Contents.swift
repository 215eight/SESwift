/*:
 # Overview
 Given the head of a singly linked list and two integers left and right where left <= right, reverse the nodes of the list from position left to position right, and return the reversed list.



 Example 1:


 Input: head = [1,2,3,4,5], left = 2, right = 4
 Output: [1,4,3,2,5]
 Example 2:

 Input: head = [5], left = 1, right = 1
 Output: [5]


 Constraints:

 The number of nodes in the list is n.
 1 <= n <= 500
 -500 <= Node.val <= 500
 1 <= left <= right <= n


 Follow up: Could you do it in one pass?
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

func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
    guard head != nil else {
        return nil
    }

    guard (right - left) > 0 else {
        return head
    }

    var beforeStart: ListNode? = nil
    var start = head

    var index = 1
    while index < left {
        beforeStart = start
        start = start?.next
        index += 1
    }

    var previous = beforeStart
    var current = start
    var next = current?.next

    while index <= right {
        next = current?.next
        current?.next = previous
        previous = current
        current = next
        index += 1
    }

    if beforeStart != nil {
        beforeStart?.next?.next = current
        beforeStart?.next = previous
        return head
    } else {
        head?.next = current
        return previous
    }
}

import XCTest
class Tests: XCTestCase {
    func testFoo() {
        XCTAssertTrue(true)
    }
}

runTests(Tests())
