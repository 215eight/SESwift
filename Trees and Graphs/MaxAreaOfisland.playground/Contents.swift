/*:
 # Overview
 You are given an m x n binary matrix grid. An island is a group of 1's (representing land) connected 4-directionally (horizontal or vertical.) You may assume all four edges of the grid are surrounded by water.

 The area of an island is the number of cells with a value 1 in the island.

 Return the maximum area of an island in grid. If there is no island, return 0.



 Example 1:


 Input: grid = [[0,0,1,0,0,0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,1,1,0,1,0,0,0,0,0,0,0,0],[0,1,0,0,1,1,0,0,1,0,1,0,0],[0,1,0,0,1,1,0,0,1,1,1,0,0],[0,0,0,0,0,0,0,0,0,0,1,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,0,0,0,0,0,0,1,1,0,0,0,0]]
 Output: 6
 Explanation: The answer is not 11, because the island must be connected 4-directionally.
 Example 2:

 Input: grid = [[0,0,0,0,0,0,0,0]]
 Output: 0


 Constraints:

 m == grid.length
 n == grid[i].length
 1 <= m, n <= 50
 grid[i][j] is either 0 or 1.

 */

/*:
 # Code
 */

/*:
 # Tests
 */

func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
    struct Cell: Hashable {
        let x: Int
        let y: Int

        func value(in grid: [[Int]]) -> Int {
            grid[y][x]
        }

        func moveUp() -> Cell? {
            let newY = y - 1
            guard newY >= 0 else { return nil }
            return Cell(x: x, y: newY)
        }

        func moveDown(in grid: [[Int]]) -> Cell? {
            let newY = y + 1
            guard newY < grid.count else { return nil }
            return Cell(x: x, y: newY)
        }

        func moveLeft() -> Cell? {
            let newX = x - 1
            guard newX >= 0 else { return nil }
            return Cell(x: newX, y: y)
        }

        func moveRight(in grid: [[Int]]) -> Cell? {
            let newX = x + 1
            guard let row = grid.first, newX < row.count else { return nil }
            return Cell(x: newX, y: y)
        }
    }

    func dfs(cell: Cell, grid: [[Int]], seen: inout Set<Cell>) -> Int {
        guard !seen.contains(cell) else { return 0 }
        seen.insert(cell)
        let value = cell.value(in: grid)
        guard value == 1 else { return 0 }
        return [
            cell.moveUp(),
            cell.moveDown(in: grid),
            cell.moveLeft(),
            cell.moveRight(in: grid)
        ]
            .compactMap { $0 }
            .reduce(1) { acc, cell in
                return acc + dfs(cell: cell, grid: grid, seen: &seen)
            }
    }

    var seen = Set<Cell>()
    var maxArea = 0
    for yIndex in (0 ..< grid.count) {
        for xIndex in (0 ..< grid[0].count) {
            let cell = Cell(x: xIndex, y: yIndex)
            let area = dfs(cell: cell, grid: grid, seen: &seen)
            maxArea = max(maxArea, area)
        }
    }
    return maxArea
}

import XCTest
class Tests: XCTestCase {
    func testMaxAreaOfIsland() {
        let grid = [[0,0,1,0,0,0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,1,1,0,1,0,0,0,0,0,0,0,0],[0,1,0,0,1,1,0,0,1,0,1,0,0],[0,1,0,0,1,1,0,0,1,1,1,0,0],[0,0,0,0,0,0,0,0,0,0,1,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,0,0,0,0,0,0,1,1,0,0,0,0]]
        XCTAssertEqual(maxAreaOfIsland(grid), 6)
    }
}

runTests(Tests())
