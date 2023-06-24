/*:
 # Overview
 There is an undirected tree with n nodes labeled from 0 to n - 1 and n - 1 edges.

 You are given a 2D integer array edges of length n - 1 where edges[i] = [ai, bi] indicates that there is an edge between nodes ai and bi in the tree. You are also given an integer array restricted which represents restricted nodes.

 Return the maximum number of nodes you can reach from node 0 without visiting a restricted node.

 Note that node 0 will not be a restricted node.



 Example 1:


 Input: n = 7, edges = [[0,1],[1,2],[3,1],[4,0],[0,5],[5,6]], restricted = [4,5]
 Output: 4
 Explanation: The diagram above shows the tree.
 We have that [0,1,2,3] are the only nodes that can be reached from node 0 without visiting a restricted node.
 Example 2:


 Input: n = 7, edges = [[0,1],[0,2],[0,5],[0,4],[3,2],[6,5]], restricted = [4,2,1]
 Output: 3
 Explanation: The diagram above shows the tree.
 We have that [0,5,6] are the only nodes that can be reached from node 0 without visiting a restricted node.


 Constraints:

 2 <= n <= 105
 edges.length == n - 1
 edges[i].length == 2
 0 <= ai, bi < n
 ai != bi
 edges represents a valid tree.
 1 <= restricted.length < n
 1 <= restricted[i] < n
 All the values of restricted are unique.
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func reachableNodes(_ n: Int, _ edges: [[Int]], _ restricted: [Int]) -> Int {

    var graph = [Int : [Int]]()
    for edge in edges {
        let a = edge[0]
        let b = edge[1]
        graph[a] = (graph[a] ?? []) + [b]
        graph[b] = (graph[b] ?? []) + [a]
    }

    var seen = Set<Int>(restricted)
    var stack = [Int]()
    stack.append(0)

    var count = 0
    while let node = stack.first {
        stack.removeFirst()
        guard !seen.contains(node) else { continue }
        seen.insert(node)
        count += 1
        guard let adjacentNodes = graph[node] else { continue }
        stack.append(contentsOf: adjacentNodes)
    }
    return count
}

import XCTest
class Tests: XCTestCase {
    func testReachableNodes() {
        XCTAssertEqual(reachableNodes(7, [[0,1],[1,2],[3,1],[4,0],[0,5],[5,6]], [4,5]), 4)
        XCTAssertEqual(reachableNodes(7, [[0,1],[0,2],[0,5],[0,4],[3,2],[6,5]], [4,2,1]), 3)
    }
}

runTests(Tests())
