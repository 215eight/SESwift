/*:
 # Overview
 Given the root of a binary search tree and a target value, return the value in the BST that is closest to the target. If there are multiple answers, print the smallest.

 Example 1:


 Input: root = [4,2,5,1,3], target = 3.714286
 Output: 4
 Example 2:

 Input: root = [1], target = 4.428571
 Output: 1


 Constraints:

 The number of nodes in the tree is in the range [1, 104].
 0 <= Node.val <= 10^9
 -10^9 <= target <= 10^9
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

func closestValue(_ root: TreeNode?, _ target: Double) -> Int {
    guard let root = root else { return -1 }
    let values = inorderTraversal(root)

    var index = 0
    while index < values.count && Double(values[index]) < target  {
        index += 1
    }

    return values.min { (lhs, rhs) in
        return abs(Double(lhs) - target) < abs(Double(rhs) - target) ? true : false
    } ?? -1
}

func inorderTraversal(_ root: TreeNode) -> [Int] {
    let leftValues = { () -> [Int] in
        guard let left = root.left else {
            return []
        }
        return inorderTraversal(left)
    }()

    let rightValues = { () -> [Int] in
        guard let right = root.right else {
            return []
        }
        return inorderTraversal(right)
    }()
    return leftValues + [root.val] + rightValues
}

func closestValue2(_ root: TreeNode?, _ target: Double) -> Int {
    return closestNode(root, target)?.val ?? -1
}

func closestNode(_ node: TreeNode?, _ target: Double) ->  TreeNode? {
    guard let node = node else {
        return nil
    }

    let closestLeft = closestNode(node.left, target)
    let closestRight = closestNode(node.right, target)

    let nodeDifference = abs(target - Double(node.val))

    switch (closestLeft, closestRight) {
    case (.some(let left), .some(let right)):


        let leftDifference = abs(target - Double(left.val))
        let rightDifference = abs(target - Double(right.val))

        print("Node: \(node.val) - Left: \(left.val) - Right: \(right.val)")
        print("Difference - Node: \(nodeDifference) - Left: \(leftDifference) - Right: \(rightDifference)")
        if leftDifference < min(nodeDifference, rightDifference) {
            return left
        } else if rightDifference < min(nodeDifference, leftDifference) {
            return right
        } else if nodeDifference < min(rightDifference, leftDifference) {
            return node
        } else {
            if leftDifference == rightDifference {
                return left.val < right.val ? left : right
            } else if leftDifference == nodeDifference {
                return left.val < node.val ? left : node
            } else if rightDifference == nodeDifference {
                return right.val < node.val ? right : node
            } else {
                return node
            }
        }


    case (.some(let left), .none):

        let leftDifference = abs(target - Double(left.val))

        if leftDifference < nodeDifference {
            return left
        } else if nodeDifference < leftDifference {
            return node
        } else {
            return left.val < node.val ? left : node
        }

    case (.none, .some(let right)):

        let rightDifference = abs(target - Double(right.val))

        if rightDifference < nodeDifference {
            return right
        } else if nodeDifference < rightDifference {
            return node
        } else {
            return right.val < node.val ? right : node
        }

    case (.none, .none):
        return node
    }
}

import XCTest
class Tests: XCTestCase {
    func testFoo() {
        XCTAssertTrue(true)
    }
}

runTests(Tests())
