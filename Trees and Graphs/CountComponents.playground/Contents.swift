/*:
 # Overview
 You have a graph of n nodes. You are given an integer n and an array edges where edges[i] = [ai, bi] indicates that there is an edge between ai and bi in the graph.

 Return the number of connected components in the graph.



 Example 1:


 Input: n = 5, edges = [[0,1],[1,2],[3,4]]
 Output: 2
 Example 2:


 Input: n = 5, edges = [[0,1],[1,2],[2,3],[3,4]]
 Output: 1


 Constraints:

 1 <= n <= 2000
 1 <= edges.length <= 5000
 edges[i].length == 2
 0 <= ai <= bi < n
 ai != bi
 There are no repeated edges.
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func countComponents(_ n: Int, _ edges: [[Int]]) -> Int {
    func dfs(node: Int, graph: [Int: [Int]], seen: inout Set<Int>) {
        let neighbors = graph[node] ?? []
        for neighbor in neighbors {
            guard !seen.contains(neighbor) else { continue }
            seen.insert(neighbor)
            dfs(node: neighbor, graph: graph, seen: &seen)
        }
    }

    var graph = [Int : [Int]]()
    for edge in edges {
        graph[edge[0]] = (graph[edge[0]] ?? []) + [edge[1]]
        graph[edge[1]] = (graph[edge[1]] ?? []) + [edge[0]]

    }

    var count = 0
    var seen = Set<Int>()

    for node in (0 ..< n) {
        guard !seen.contains(node) else { continue }
        count += 1
        seen.insert(node)
        dfs(node: node, graph: graph, seen: &seen)
    }

    return count
}

import XCTest
class Tests: XCTestCase {
    func testFoo() {
        XCTAssertTrue(true)
    }
}

runTests(Tests())
