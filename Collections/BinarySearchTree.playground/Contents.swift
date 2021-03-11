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
    }

    var height: Int {
        return root?.height ?? 0 + max(root?.rightNode?.height ?? 0, root?.leftNode?.height ?? 0)
    }

    func insert(element: T) {
        guard let root = self.root else {
            self.root = TreeNode(element)
            return
        }
        root.insert(element: element)
    }

    var description: String {
        guard let root = self.root else { return "" }
        print("Root height: \(root.height)")

        var result = ""
        var nodesQueue = [(node: TreeNode<T>?, height: Int)]()
        var nodesAtCurrentLevel: [(node: TreeNode<T>?, height: Int)] = [(node: root, height: root.height)]

        while !nodesAtCurrentLevel.isEmpty {
            nodesQueue.removeAll()

            result += nodesAtCurrentLevel.map { tuple -> String in
                nodesQueue.append((node: tuple.node?.rightNode, height: tuple.height - 1))
                nodesQueue.append((node: tuple.node?.leftNode, height: tuple.height - 1))
                return description(node: tuple.node, height: tuple.height)
            }
            .joined(separator: " ")
            .appending("\n")

            nodesAtCurrentLevel.removeAll()

            nodesQueue.map {
                guard $0.height > 0 else { return }
                nodesAtCurrentLevel.append($0)
            }
        }
        return result
    }

    func description(node: TreeNode<T>?, height: Int) -> String {
        guard height > 0 else {
            return "\(node != nil ? "\(node!.element)" : "_")"
        }
        let paddingCount = (Int(pow(2,Double(height - 1))) / 2)
        let padding = String(repeating: " ", count: max(((paddingCount * 2) - 1), 0))
        return padding + "\(node != nil ? "\(node!.element)" : "_")" + padding
    }
}

// 2
//1 3
//
//   2
// 1   3
//4 5 6 7

//           3
//      /         \
//     2           2
//   /   \       /   \
//  1     3     1     3
// / \   / \   / \   / \
//4   5 6   7 4   5 6   7

//                       1
//            /                     \
//           3                       3
//      /         \             /         \
//     2           2           2           2
//   /   \       /   \       /   \       /   \
//  1     3     1     3     1     3     1     3
// / \   / \   / \   / \   / \   / \   / \   / \
//4   5 6   7 4   5 6   7 4   5 6   7 4   5 6   7

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
        case _ where element < self.element:
            guard let rightNode = self.rightNode else {
                self.rightNode = TreeNode(element)
                return
            }
            rightNode.insert(element: element)
        case _ where element > self.element:
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
        print(Tree(elements: [2,1,3]).description)
        print(Tree(elements: [4,2,1,3,6,5,7]).description)
        print(Tree(elements: [8,4,12,2,6,10,14,1,3,5,7,9,10,11,15]).description)
        print(Tree(elements: [5,1,7,6,2,1,9,1,3]).description)
        print(Tree(elements: [50,25,100,26,101,24,99]).description)
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
