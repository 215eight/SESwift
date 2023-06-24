/*:
 # Overview
 Given an n x n binary matrix grid, return the length of the shortest clear path in the matrix. If there is no clear path, return -1. A clear path is a path from the top-left cell (0, 0) to the bottom-right cell (n - 1, n - 1) such that all visited cells are 0. You may move 8-directionally (up, down, left, right, or diagonally).
 */

/*:
 # Code
 */

/*:
 # Tests
 */

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

    func moveUpLeft() -> Cell? {
        moveUp()?.moveLeft()
    }

    func moveUpRight(in grid: [[Int]]) -> Cell? {
        moveUp()?.moveRight(in: grid)
    }

    func moveDownLeft(in grid: [[Int]] ) -> Cell? {
        moveDown(in: grid)?.moveLeft()
    }

    func moveDownRight(in grid: [[Int]]) -> Cell? {
        moveDown(in: grid)?.moveRight(in: grid)
    }
}

func shortestPathBinaryMatrix(grid: [[Int]]) -> Int {
    guard let row = grid.first,
          let col = row.first,
          col == 0 else {
        return -1
    }

    var steps = 0
    var seen = Set<Cell>()
    let topRightCell = Cell(x: 0, y: 0)
    var queue = [(topRightCell, 1)]
    seen.insert(topRightCell)

    while let (cell, cellSteps) = queue.first {
        queue.removeFirst()

        if cell == Cell(x: grid.count - 1, y: grid.count - 1) {
            return cellSteps
        }

        let validAdjacentCells = [
            cell.moveUp(),
            cell.moveDown(in: grid),
            cell.moveLeft(),
            cell.moveRight(in: grid),
            cell.moveUpLeft(),
            cell.moveUpRight(in: grid),
            cell.moveDownLeft(in: grid),
            cell.moveDownRight(in: grid)
        ]
            .compactMap { optionalCell -> (Cell, Int)? in
                guard let adjacentCell = optionalCell else { return nil }
                guard adjacentCell.value(in: grid) == 0, !seen.contains(adjacentCell)  else { return nil }
                seen.insert(adjacentCell)
                return (adjacentCell, cellSteps + 1)
            }

        queue.append(contentsOf: validAdjacentCells)
    }

    return -1
}

import XCTest
class Tests: XCTestCase {
    func testShortestPathBinaryMatrixEmpty() {
        let grid = [[Int]]()
        XCTAssertEqual(shortestPathBinaryMatrix(grid: grid), -1)
    }

    func testShortestPathBinaryMatrixSingleElement() {
        XCTAssertEqual(shortestPathBinaryMatrix(grid: [[0]]), 1)
        XCTAssertEqual(shortestPathBinaryMatrix(grid: [[1]]), -1)
    }

    func testShortestPathBinaryMatrix2x2() {
        XCTAssertEqual(shortestPathBinaryMatrix(grid: [[0,0], [0,0]]), 2)
        XCTAssertEqual(shortestPathBinaryMatrix(grid: [[1,1], [1,1]]), -1)
        XCTAssertEqual(shortestPathBinaryMatrix(grid: [[0,0], [1,0]]), 2)
    }

    func testShortestPathBinaryMatrix3x3() {
        XCTAssertEqual(shortestPathBinaryMatrix(grid: [
            [0,0,0],
            [0,0,0],
            [0,0,0]
        ]), 3)
        XCTAssertEqual(shortestPathBinaryMatrix(grid: [
            [0,1,0],
            [1,0,0],
            [0,0,0]
        ]), 3)
        XCTAssertEqual(shortestPathBinaryMatrix(grid: [
            [0,0,0],
            [1,1,0],
            [0,0,0]
        ]), 4)
        XCTAssertEqual(shortestPathBinaryMatrix(grid: [
            [0,1,0],
            [1,1,0],
            [0,0,0]
        ]), -1)
    }

    func testShortestPathBinaryMatrix() {
        let grid = [
            [0,0,1,1,1,1],
            [0,1,0,1,1,1],
            [0,1,1,0,1,1],
            [0,0,0,0,0,1],
            [1,1,1,1,0,0],
            [1,1,1,1,1,0]
        ]
        XCTAssertEqual(shortestPathBinaryMatrix(grid: grid), 7)
    }

    func testShortestPathBinaryMatrix2() {
        let grid = [
            [0,1,1,1,1,1],
            [0,1,0,1,1,1],
            [0,1,1,0,1,1],
            [0,0,0,0,0,1],
            [1,1,1,1,0,0],
            [1,1,1,1,1,0]
        ]
        XCTAssertEqual(shortestPathBinaryMatrix(grid: grid), 8)
    }
}

runTests(Tests())
