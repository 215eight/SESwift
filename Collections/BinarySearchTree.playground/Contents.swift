/*:
 # Overview
 Create a binary search tree data structure that can be initialized from an unordered array of comparable values, then write a method that returns whether the tree is balanced.
 Tip #1: There is more than one description of a balanced binary tree. For the purpose of this challenge, a binary tree is considered balanced when the height of both subtrees for every node differs by no more than 1.
 Tip #2: Once you complete this challenge, keep your code around because you’ll need it in the next one.
 */

/*:
 # Code
 */

final class Tree<T: Comparable> {
    var root: TreeNode<T>? = nil

    init(elements: [T]) {
        for element in elements {
            insert(element: element)
        }
    }

    var isBalanced: Bool {
        guard let root = self.root else { return true }
        guard root.rightNode?.isBalanced ?? true && root.leftNode?.isBalanced ?? true else {
            return false
        }
        return true
//        let rightSubtreeHeight = root.rightNode?.height ?? 0
//        let leftSubtreeHeight = root.leftNode?.height ?? 0
//        return abs(leftSubtreeHeight - rightSubtreeHeight) <= 1
    }

    var height: Int {
        guard root != nil else { return 0 }
        return 1 + max(root?.rightNode?.height ?? 0, root?.leftNode?.height ?? 0)
    }

    func insert(element: T) {
        guard let root = self.root else {
            self.root = TreeNode(element)
            return
        }
        root.insert(element: element)
    }
}

final class TreeNode<T: Comparable> {
    var element: T
    var rightNode: TreeNode<T>? = nil
    var leftNode: TreeNode<T>? = nil

    init(_ element: T) {
        self.element = element
    }

    var isBalanced: Bool {
        guard rightNode?.isBalanced ?? true && leftNode?.isBalanced ?? true else {
            return false
        }
        let rightSubtreeHeight = rightNode?.height ?? 0
        let leftSubtreeHeight = leftNode?.height ?? 0
        return abs(leftSubtreeHeight - rightSubtreeHeight) <= 1
    }

    var height: Int {
        return 1 + max(rightNode?.height ?? 0, leftNode?.height ?? 0)
    }

    func insert(element: T) {
        switch element {
        case _ where element > self.element:
            guard let rightNode = self.rightNode else {
                self.rightNode = TreeNode(element)
                return
            }
            rightNode.insert(element: element)
        case _ where element < self.element:
            guard let leftNode = self.leftNode else {
                self.leftNode = TreeNode(element)
                return
            }
            leftNode.insert(element: element)
        case _ where element == self.element:
            break
        default:
            break
        }
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testTree() {
        XCTAssertTrue(Tree(elements: [2,1,3]).isBalanced)
        XCTAssertTrue(Tree(elements: [5,1,7,6,2,1,9,1]).isBalanced)
        XCTAssertFalse(Tree(elements: [5,1,7,6,2,1,9,1,3]).isBalanced)
        XCTAssertTrue(Tree(elements: [50,25,100,26,101,24,99]).isBalanced)
        XCTAssertTrue(Tree(elements: ["k", "t", "d", "a", "z", "m", "f"]).isBalanced)
        XCTAssertTrue(Tree(elements: [1]).isBalanced)
        XCTAssertTrue(Tree(elements: [Character]()).isBalanced)
        XCTAssertFalse(Tree(elements: [1,2,3,4,5]).isBalanced)
        XCTAssertFalse(Tree(elements: [10, 5, 4, 3, 2, 1, 11, 12, 13, 14, 15]).isBalanced)
        XCTAssertFalse(Tree(elements: ["f", "d", "c", "e", "a", "b"]).isBalanced)
    }
}

runTests(Tests())
