/*:
 # Overview
 */

/*:
 # Code
 */

class Node<T: Comparable> {
    let value: T
    var left: Node?
    var right: Node?

    init(value: T) {
        self.value = value
    }
}

class BinaryTree<T: Comparable> {

    var root: Node<T>?

    init(value: T) {
        self.root = Node(value: value)
    }

    init(values: [T]) {
        values.forEach(insert(value:))
    }

    func insert(value: T) {
        guard let root = root else {
            self.root = Node(value: value)
            return
        }
        insert(value: value, node: root)
    }

    private func insert(value: T, node: Node<T>) {
        if value < node.value {
            if let left = node.left {
                insert(value: value, node: left)
            } else {
                node.left = Node(value: value)
            }
        } else if value > node.value {
            if let right = node.right {
                insert(value: value, node: right)
            } else {
                node.right = Node(value: value)
            }
        } else {
            return
        }
    }

    var inOrderTraverse: String {
        inOrderTraverse(node: root)
            .map { "\($0)" }
            .joined(separator: " ")
    }

    private func inOrderTraverse(node: Node<T>?) -> [T] {
        guard let node = node else {
            return []
        }
        return inOrderTraverse(node: node.left) + [node.value] + inOrderTraverse(node: node.right)
    }

    var height: Int {
        return height(node: root)
    }

    private func height(node: Node<T>?) -> Int {
        guard let node = node else {
            return 0
        }
        guard node.right != nil || node.left != nil else {
            return 0
        }
        return 1 + max(height(node: node.left), height(node: node.right))
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testInsert() {
        var tree = BinaryTree(values: [3,5,2,1,4,6,7])
        XCTAssertEqual(tree.height, 3)
        tree = BinaryTree(values: [15])
        XCTAssertEqual(tree.height, 0)
        tree = BinaryTree(values: [3,1,7,5,4])
        XCTAssertEqual(tree.height, 3)
    }
}

runTests(Tests())
