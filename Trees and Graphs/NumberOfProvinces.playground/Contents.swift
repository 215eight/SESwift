/*:
 # Overview
 There are n cities. A province is a group of directly or indirectly connected cities and no other cities outside of the group. You are given an n x n matrix isConnected where isConnected[i][j] = isConnected[j][i] = 1 if the ith city and the jth city are directly connected, and isConnected[i][j] = 0 otherwise. Return the total number of provinces.
 */

/*:
 # Code
 */

/*:
 # Tests
 */


func numberOfProvinces(isConnected: [[Int]]) -> Int {

    var graph = [Int: [Int]]()

    for (rowIndex, row)in isConnected.enumerated() {
        graph[rowIndex] = []
        for (colIndex, isConnectedNode) in row.enumerated() {
            if isConnectedNode == 1 {
                let connectedNodes = graph[rowIndex] ?? []
                graph[rowIndex] = connectedNodes + [colIndex]
            }
        }
    }

    var provincesCount = 0
    var seen = Set<Int>()
    for node in (0 ..< isConnected.count) {
        guard !seen.contains(node) else { continue }
        provincesCount += 1
        seen.insert(node)
        dfs(node: node, graph: graph, seen: &seen)
    }

    return provincesCount
}

func dfs(node: Int, graph: [Int: [Int]], seen: inout Set<Int>) {
    let connectedNodes = graph[node] ?? []
    for neighbor in connectedNodes {
        guard !seen.contains(neighbor) else { continue }
        seen.insert(neighbor)
        dfs(node: neighbor, graph: graph, seen: &seen)
    }
}

import XCTest
class Tests: XCTestCase {
    func testNumberOfProvinces() {
        let cities = [
            [0,1,0,0,0,0,0,0],
            [1,0,0,1,0,0,0,1],
            [0,0,0,0,1,0,0,0],
            [0,1,0,0,0,0,0,0],
            [0,0,1,0,0,0,0,0],
            [0,0,0,0,0,0,1,0],
            [0,0,0,0,0,1,0,0],
            [0,1,0,0,0,0,0,0],
        ]
        XCTAssertEqual(numberOfProvinces(isConnected: cities), 3)
    }

    func testNumberOfProvinces2() {
        let cities = [
            [0,0,0,0,0,0,0,0],
            [0,0,0,1,0,0,0,1],
            [0,0,0,0,1,0,0,0],
            [0,1,0,0,0,0,0,0],
            [0,0,1,0,0,0,0,0],
            [0,0,0,0,0,0,1,0],
            [0,0,0,0,0,1,0,0],
            [0,1,0,0,0,0,0,0],
        ]
        XCTAssertEqual(numberOfProvinces(isConnected: cities), 4)
    }
}

runTests(Tests())
