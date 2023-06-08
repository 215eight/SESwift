/*:
 # Overview
 Given the head of a sorted linked list, delete all duplicates such that each element appears only once. Return the linked list sorted as well.



 Example 1:
 Input: head = [1,1,2]
 Output: [1,2]

 Example 2:
 Input: head = [1,1,2,3,3]
 Output: [1,2,3]


 Constraints:

 The number of nodes in the list is in the range [0, 300].
 -100 <= Node.val <= 100
 The list is guaranteed to be sorted in ascending order.
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

func deleteDuplicates(_ head: ListNode?) -> ListNode? {
    var resultHead = head
    var slow = head
    var fast = slow?.next

    while fast != nil {
        if fast?.val == slow?.val {
            while fast?.val == slow?.val {
                fast = fast?.next
            }
            slow?.next = fast
            fast = slow?.next
        } else {
            slow = slow?.next
            fast = slow?.next
        }
    }

    return resultHead
}

import XCTest
class Tests: XCTestCase {
    func testDeleteDuplicates() {
        
    }
}

runTests(Tests())
