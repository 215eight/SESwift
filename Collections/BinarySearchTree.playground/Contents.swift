/*:
 # Overview

 ## Challenge 1

 Create a binary search tree data structure that can be initialized from an unordered array of comparable values, then write a method that returns whether the tree is balanced.
 Tip #1: There is more than one description of a balanced binary tree. For the purpose of this challenge, a binary tree is considered balanced when the height of both subtrees for every node differs by no more than 1.
 Tip #2: Once you complete this challenge, keep your code around because you’ll need it in the next one.

 ## Challenge 2

 Write a new method for your binary search tree that traverses the tree in order, running a closure on each node.
 Tip: Traversing a node in order means visiting its left value, then visiting its own value, then visiting its right value.

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
        return root.isBalanced
    }

    func insert(element: T) {
        guard let root = self.root else {
            self.root = TreeNode(element)
            return
        }
        root.insert(element: element)
    }

    var description: String {

        func description(node: TreeNode<T>?, height: Int) -> String {
            let nodeDescription = "\(node != nil ? "\(node!.element)" : "_")"
            guard height > 0 else { return nodeDescription }
            let paddingCount = (Int(pow(2,Double(height))) / 2)
            let padding = String(repeating: " ", count: max(((paddingCount * 2) - 1), 0))
            return padding + nodeDescription + padding
        }

        guard let root = self.root else { return "" }
        print("Root height: \(root.height)")

        var result = ""
        var nodesAtCurrentLevel: [(node: TreeNode<T>?, height: Int)] = [(node: root, height: root.height)]

        while !nodesAtCurrentLevel.isEmpty {
            var nodesQueue = [(node: TreeNode<T>?, height: Int)]()
            result += nodesAtCurrentLevel.map { tuple -> String in
                nodesQueue.append((node: tuple.node?.left, height: tuple.height - 1))
                nodesQueue.append((node: tuple.node?.right, height: tuple.height - 1))
                return description(node: tuple.node, height: tuple.height)
            }
            .joined(separator: " ")
            .appending("\n")

            nodesAtCurrentLevel.removeAll()

            nodesQueue.forEach {
                guard $0.height >= 0 else { return }
                nodesAtCurrentLevel.append($0)
            }
        }
        return result
    }

    var inOrderTraverse: String {
        guard let root = self.root else { return "" }
        return root.inOrderTraverse
    }

    var preOrderTraverse: String {
        guard let root = self.root else { return "" }
        return root.preOrderTraverse
    }

    var postOrderTraverse: String {
        guard let root = self.root else { return "" }
        return root.postOrderTraverse
    }
}

final class TreeNode<T: Comparable> {
    var element: T
    var parent: TreeNode<T>? = nil
    var right: TreeNode<T>? = nil
    var left: TreeNode<T>? = nil

    init(_ element: T) {
        self.element = element
    }

    var isRoot: Bool {
        return parent == nil
    }

    var isLeaf: Bool {
        return right == nil && left == nil
    }

    var isRightChild: Bool {
        return parent?.right?.element == element
    }

    var isLeftChild: Bool {
        return parent?.left?.element == element
    }

    var isBalanced: Bool {
        guard right?.isBalanced ?? true && left?.isBalanced ?? true else {
            return false
        }
        return abs((right?.height ?? 0) - (left?.height ?? 0)) <= 1
    }

    var height: Int {
        guard !isLeaf else { return 0 }
        return 1 + max(right?.height ?? 0, left?.height ?? 0)
    }

    func insert(element: T) {
        switch element {
        case _ where element > self.element:
            guard let right = self.right else {
                self.right = TreeNode(element)
                return
            }
            right.insert(element: element)
        case _ where element < self.element:
            guard let left = self.left else {
                self.left = TreeNode(element)
                return
            }
            left.insert(element: element)
        case _ where element == self.element:
            break
        default:
            break
        }
    }

    var inOrderTraverse: String {
        return [
            left?.inOrderTraverse,
            "\(element)",
            right?.inOrderTraverse
        ]
        .compactMap { $0 }
        .joined(separator: " ")
    }

    var preOrderTraverse: String {
        return [
            "\(element)",
            left?.preOrderTraverse,
            right?.preOrderTraverse
        ]
        .compactMap { $0 }
        .joined(separator: " ")
    }

    var postOrderTraverse: String {
        return [
            left?.postOrderTraverse,
            right?.postOrderTraverse,
            "\(element)",
        ]
        .compactMap { $0 }
        .joined(separator: " ")
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
        XCTAssertTrue(Tree(elements: [5,1,7,6,2,1,9,1,3]).isBalanced)
        XCTAssertTrue(Tree(elements: [50,25,100,26,101,24,99]).isBalanced)
        XCTAssertTrue(Tree(elements: ["k", "t", "d", "a", "z", "m", "f"]).isBalanced)
        XCTAssertTrue(Tree(elements: [1]).isBalanced)
        XCTAssertTrue(Tree(elements: [Character]()).isBalanced)
        XCTAssertFalse(Tree(elements: [1,2,3,4,5]).isBalanced)
        XCTAssertFalse(Tree(elements: [10, 5, 4, 3, 2, 1, 11, 12, 13, 14, 15]).isBalanced)
        XCTAssertFalse(Tree(elements: ["f", "d", "c", "e", "a", "b"]).isBalanced)
    }

    func testTraveral() {
        var tree = Tree(elements: [2,1,3])
        XCTAssertEqual(tree.inOrderTraverse, "1 2 3")
        XCTAssertEqual(tree.preOrderTraverse, "2 1 3")
        XCTAssertEqual(tree.postOrderTraverse, "1 3 2")
        tree = Tree(elements: [4,2,1,3,6,5,7])
        XCTAssertEqual(tree.inOrderTraverse, "1 2 3 4 5 6 7")
        XCTAssertEqual(tree.preOrderTraverse, "4 2 1 3 6 5 7")
        XCTAssertEqual(tree.postOrderTraverse, "1 3 2 5 7 6 4")
        tree = Tree(elements: [8,4,12,2,6,10,14,1,3,5,7,9,10,11,13,15])
        XCTAssertEqual(tree.inOrderTraverse, "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15")
        XCTAssertEqual(tree.preOrderTraverse, "8 4 2 1 3 6 5 7 12 10 9 11 14 13 15")
        XCTAssertEqual(tree.postOrderTraverse, "1 3 2 5 7 6 4 9 11 10 13 15 14 12 8")
    }

    func testTreeDescription() {
        print(Tree(elements: [2,1,3]).description)
        print(Tree(elements: [4,2,1,3,6,5,7]).description)
        print(Tree(elements: [8,4,12,2,6,10,14,1,3,5,7,9,10,11,13,15]).description)
        print(Tree(elements: [5,1,7,6,2,1,9,1,3]).description)
        print(Tree(elements: [50,25,100,26,101,24,99]).description)
        print(Tree(elements: [10, 5, 4, 3, 2, 1, 11, 12, 13, 14, 15]).description)
    }
}

runTests(Tests())
