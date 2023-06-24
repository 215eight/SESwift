/*:
 # Overview
 Given the root of a binary tree, return the zigzag level order traversal of its nodes' values. (i.e., from left to right, then right to left for the next level and alternate between).



 Example 1:


 Input: root = [3,9,20,null,null,15,7]
 Output: [[3],[20,9],[15,7]]
 Example 2:

 Input: root = [1]
 Output: [[1]]
 Example 3:

 Input: root = []
 Output: []


 Constraints:

 The number of nodes in the tree is in the range [0, 2000].
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

func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else {
        return []
    }
    var answer = [[root.val]]
    var doReverseLevel = true
    var queue =  [root]
    while !queue.isEmpty {
        var tempAnswer = [Int]()

        let queueSize = queue.count
        (0 ..< queueSize)
            .forEach { _ in
                let first = queue.removeFirst()
                if let left = first.left {
                    queue.append(left)
                    let index = doReverseLevel ? 0 : tempAnswer.count
                    tempAnswer.insert(left.val, at: index)
                }
                if let right = first.right {
                    queue.append(right)
                    let index = doReverseLevel ? 0 : tempAnswer.count
                    tempAnswer.insert(right.val, at: index)
                }
            }
        if !tempAnswer.isEmpty {
            answer.append(tempAnswer)
        }
        doReverseLevel = !doReverseLevel
    }
    return answer
}

import XCTest
class Tests: XCTestCase {
    func testFoo() {
        XCTAssertTrue(true)
    }
}

runTests(Tests())
