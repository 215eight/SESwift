/*:
 # Overview
 Given the root of a binary tree, return the sum of values of its deepest leaves.


 Example 1:


 Input: root = [1,2,3,4,5,null,6,7,null,null,null,null,8]
 Output: 15
 Example 2:

 Input: root = [6,7,8,2,7,1,3,9,null,1,4,null,null,null,5]
 Output: 19


 Constraints:

 The number of nodes in the tree is in the range [1, 104].
 1 <= Node.val <= 100
 */

/*:
 # Code
 */

/*:
 # Tests
 */
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}
func deepestLeavesSum(_ root: TreeNode?) -> Int {
    guard let root = root else {
        return 0
    }
    var queue = [root]
    var response = [TreeNode]()
    while !queue.isEmpty {
        let levelSize = queue.count
        response.removeAll()
        (0 ..< levelSize).forEach { _ in
            let first = queue.removeFirst()
            response.append(first)
            if let left = first.left {
                queue.append(left)
            }
            if let right = first.right {
                queue.append(right)
            }
        }
    }
    return response.reduce(0) {$0 + $1.val}
}

import XCTest
class Tests: XCTestCase {
    func testFoo() {
        XCTAssertTrue(true)
    }
}

runTests(Tests())
