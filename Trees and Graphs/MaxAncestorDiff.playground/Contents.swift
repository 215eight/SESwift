/*:
 # Overview
 Given the root of a binary tree, find the maximum value v for which there exist different nodes a and b where v = |a.val - b.val| and a is an ancestor of b.

 A node a is an ancestor of b if either: any child of a is equal to b or any child of a is an ancestor of b.



 Example 1:


 Input: root = [8,3,10,1,6,null,14,null,null,4,7,13]
 Output: 7
 Explanation: We have various ancestor-node differences, some of which are given below :
 |8 - 3| = 5
 |3 - 7| = 4
 |8 - 1| = 7
 |10 - 13| = 3
 Among all possible differences, the maximum value of 7 is obtained by |8 - 1| = 7.
 Example 2:


 Input: root = [1,null,2,null,0,3]
 Output: 3


 Constraints:

 The number of nodes in the tree is in the range [2, 5000].
 0 <= Node.val <= 105
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

func maxAncestorDiff(_ root: TreeNode?) -> Int {
    return maxAncestorDifference(root)?.1 ?? -1
}

func maxAncestorDifference(_ root: TreeNode?) -> ([TreeNode], Int)? {
    guard let root = root else {
        return  nil
    }
    let leftRes = maxAncestorDifference(root.left)
    let rightRes = maxAncestorDifference(root.right)

    var maxAbsDiff = max(leftRes?.1 ?? -1, rightRes?.1 ?? -1)

    for value in leftRes?.0 ?? [] {
        let absDiff = abs(root.val - value.val)
        maxAbsDiff = max(maxAbsDiff, absDiff)
    }

    for value in rightRes?.0 ?? [] {
        let absDiff = abs(root.val - value.val)
        maxAbsDiff = max(maxAbsDiff, absDiff)
    }

    return ((leftRes?.0 ?? []) + (rightRes?.0 ?? []) + [root], maxAbsDiff)
}

func maxAncestorDiff2(_ root: TreeNode?) -> Int {
        return maxAncestorDifference2(root, max: Int.min, min: Int.max)
    }

    func maxAncestorDifference2(_ root: TreeNode?, max: Int, min : Int) -> Int {
        guard let root = root else {
            return -1
        }

        if root.left == nil, root.right == nil {
            let val = Swift.max(max, root.val) - Swift.min(min, root.val)
            return val
        }

        let leftRes = maxAncestorDifference2(
            root.left,
            max: Swift.max(max, root.val),
            min: Swift.min(min, root.val)
        )
        let rightRes = maxAncestorDifference2(
            root.right,
            max: Swift.max(max, root.val),
            min: Swift.min(min, root.val)
        )

        let val = Swift.max(leftRes, rightRes)
        return val
    }

import XCTest
class Tests: XCTestCase {
    func testFoo() {
        XCTAssertTrue(true)
    }
}

runTests(Tests())
