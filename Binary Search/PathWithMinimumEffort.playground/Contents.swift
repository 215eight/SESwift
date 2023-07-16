/*:
 # Overview
 Example 2: 1631. Path With Minimum Effort

 You are given heights, a positive 2D array of size m x n, where heights[row][col] represents the height of cell (row, col). You can move up, down, left, or right. A path's effort is the largest absolute difference you can have between any two consecutive cells traversed. Return the minimum effort required to get from the top left to the bottom right.
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
}

func moveUp(_ cell: Cell, in grid: [[Int]]) -> Cell? {
    let newY = cell.y - 1
    guard newY >= 0 else { return nil }
    return Cell(x: cell.x, y: newY)
}

func moveDown(_ cell: Cell, in grid: [[Int]]) -> Cell? {
    let newY = cell.y + 1
    guard newY < (grid.count) else { return nil }
    return Cell(x: cell.x, y: newY)
}

func moveLeft(_ cell: Cell, in grid: [[Int]]) -> Cell? {
    let newX = cell.x - 1
    guard newX >= 0 else { return nil }
    return Cell(x: newX, y: cell.y)
}

func moveRight(_ cell: Cell, in grid: [[Int]]) -> Cell? {
    let newX = cell.x + 1
    guard newX < (grid[0].count) else { return nil }
    return Cell(x: newX, y: cell.y)
}

func pathWithMinimumEffort(_ heights: [[Int]]) -> Int  {
    var minEffort = 0
    var maxEffort = -1

    for row in heights {
        let tempMax = row.max() ?? -1
        if tempMax > maxEffort {
            maxEffort = tempMax
        }
    }

    while minEffort <= maxEffort {
        let tempMax = minEffort + ((maxEffort - minEffort) / 2)
        let canTraverse = canTraverse(heights, maxCost: tempMax)
        if canTraverse {
            maxEffort = tempMax - 1
        } else {
            minEffort = tempMax + 1
        }
    }

    return minEffort
}

func canTraverse(_ heights: [[Int]], maxCost: Int) -> Bool {
    let initialCell = Cell(x: 0, y: 0)
    let targetCell = Cell(x: heights[0].count - 1, y: heights.count - 1)

    var queue = [initialCell]
    var visitedCells = Set(queue)

    while let cell = queue.first {
        queue.removeFirst()
        visitedCells.insert(cell)

        if cell == targetCell {
            return true
        }

        [
            moveUp(cell, in: heights),
            moveDown(cell, in: heights),
            moveLeft(cell, in: heights),
            moveRight(cell, in: heights),
        ]
            .forEach { optionalCell in
                guard let _cell = optionalCell else { return }
                guard !visitedCells.contains(_cell) else { return }
                let moveCost = abs(heights[_cell.y][_cell.x] - heights[cell.y][cell.x])
                guard moveCost <= maxCost else {
                    return
                }
                queue.append(_cell)
            }
    }
    return false
}

import XCTest
class Tests: XCTestCase {
    func testFoo() {
        XCTAssertEqual(pathWithMinimumEffort([
            [1,2,2],
            [3,8,2],
            [5,3,5]
        ]), 2)
        XCTAssertEqual(pathWithMinimumEffort([
            [1,1,1],
            [1,1,1],
            [1,1,1]
        ]), 0)
        XCTAssertEqual(pathWithMinimumEffort([
            [1,1,8],
            [1,8,1],
            [8,1,1]
        ]), 7)
        XCTAssertEqual(pathWithMinimumEffort([
            [1,2,2],
            [3,8,2],
            [3,3,1]
        ]), 1)
    }
}

runTests(Tests())
