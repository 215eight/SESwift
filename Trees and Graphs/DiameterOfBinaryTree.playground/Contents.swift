/*:
 # Overview
 Given the root of a binary tree, return the length of the diameter of the tree.

 The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.

 The length of a path between two nodes is represented by the number of edges between them.



 Example 1:


 Input: root = [1,2,3,4,5]
 Output: 3
 Explanation: 3 is the length of the path [4,2,1,3] or [5,2,1,3].
 Example 2:

 Input: root = [1,2]
 Output: 1


 Constraints:

 The number of nodes in the tree is in the range [1, 104].
 -100 <= Node.val <= 100
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

func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
    return findDiameter(root).longestPath
}

func findDiameter(_ root: TreeNode?) -> (height: Int, longestPath: Int) {
    guard let root = root else {
        return (height: -1, longestPath: -1)
    }

    if root.left == nil, root.right == nil {
        return (height: 0, longestPath: 0)
    }

    let left = findDiameter(root.left)
    let right = findDiameter(root.right)

    return (
        height: 1 + max(left.height, right.height),
        longestPath: max(left.height + right.height + 2, max(left.longestPath, right.longestPath))
    )
}

import XCTest
class Tests: XCTestCase {
    func testFoo() {
        XCTAssertTrue(true)
    }
}

runTests(Tests())
