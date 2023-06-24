/*:
 # Overview
 Given an m x n 2D binary grid which represents a map of 1 (land) and 0 (water), return the number of islands. An island is surrounded by water and is formed by connecting adjacent land cells horizontally or vertically.
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func numberOfIslands(grid: [[Int]]) -> Int {
    struct Cell: Hashable {
        let x: Int
        let y: Int
    }

    func moveUp(cell: Cell, grid: [[Int]]) -> Cell? {
        let newX = cell.x - 1
        guard newX >= 0 else {
            return nil
        }
        return Cell(x: newX, y: cell.y)
    }

    func moveDown(cell: Cell, grid: [[Int]]) -> Cell? {
        let newX = cell.x + 1
        guard newX < grid.count else {
            return nil
        }
        return Cell(x: newX, y: cell.y)

    }

    func moveRight(cell: Cell, grid: [[Int]]) -> Cell? {
        let newY = cell.y + 1
        guard newY < grid.count else {
            return nil
        }
        return Cell(x: cell.x, y: newY)

    }

    func moveLeft(cell: Cell, grid: [[Int]]) -> Cell? {
        let newY = cell.y - 1
        guard newY >= 0  else {
            return nil
        }
        return Cell(x: cell.x, y: newY)
    }

    func dfs(cell: Cell, grid: [[Int]], seen: inout Set<Cell>) {
        [
            moveUp(cell: cell, grid: grid),
            moveDown(cell: cell, grid: grid),
            moveRight(cell: cell, grid: grid),
            moveLeft(cell: cell, grid: grid)
        ]
            .compactMap { $0 }
            .forEach { cell in
                let value = grid[cell.y][cell.x]
                if value == 1, !seen.contains(cell) {
                    seen.insert(cell)
                    dfs(cell: cell, grid: grid, seen: &seen)
                }
            }
    }

    var islands = 0
    var seen = Set<Cell>()
    for rowIndex in (0 ..< grid.count) {
        let row = grid[rowIndex]
        for colIndex in (0 ..< row.count) {
            let value = grid[rowIndex][colIndex]
            let cell = Cell(x: colIndex, y: rowIndex)
            if value == 1, !seen.contains(cell) {
                islands += 1
                dfs(cell: cell, grid: grid, seen: &seen)
            }
        }
    }

    return islands
}

import XCTest
class Tests: XCTestCase {
    func testNumberOfIslands() {
        let grid = [
            [1,1,0,0,0,1],
            [0,1,0,0,0,0],
            [0,1,1,0,1,1],
            [0,0,0,0,0,1],
            [1,1,1,1,0,1],
            [1,1,1,1,0,1]
        ]
        XCTAssertEqual(numberOfIslands(grid: grid), 4)
    }

    func testNumberOfIslands2() {
        let grid = [
            [1,1,0,0,0,0],
            [0,1,0,0,0,0],
            [0,1,1,0,1,1],
            [0,0,0,0,0,1],
            [1,1,1,1,0,1],
            [1,1,1,1,0,1]
        ]
        XCTAssertEqual(numberOfIslands(grid: grid), 3)
    }

    func testNumberOfIslands3() {
        XCTAssertEqual(numberOfIslands(grid: []), 0)
        XCTAssertEqual(numberOfIslands(grid: [[1]]), 1)

    }
}

runTests(Tests())
