/*:
 # Overview
 You are given an m x n matrix maze (0-indexed) with empty cells (represented as '.') and walls (represented as '+'). You are also given the entrance of the maze, where entrance = [entrancerow, entrancecol] denotes the row and column of the cell you are initially standing at.

 In one step, you can move one cell up, down, left, or right. You cannot step into a cell with a wall, and you cannot step outside the maze. Your goal is to find the nearest exit from the entrance. An exit is defined as an empty cell that is at the border of the maze. The entrance does not count as an exit.

 Return the number of steps in the shortest path from the entrance to the nearest exit, or -1 if no such path exists.



 Example 1:


 Input: maze = [["+","+",".","+"],[".",".",".","+"],["+","+","+","."]], entrance = [1,2]
 Output: 1
 Explanation: There are 3 exits in this maze at [1,0], [0,2], and [2,3].
 Initially, you are at the entrance cell [1,2].
 - You can reach [1,0] by moving 2 steps left.
 - You can reach [0,2] by moving 1 step up.
 It is impossible to reach [2,3] from the entrance.
 Thus, the nearest exit is [0,2], which is 1 step away.
 Example 2:


 Input: maze = [["+","+","+"],[".",".","."],["+","+","+"]], entrance = [1,0]
 Output: 2
 Explanation: There is 1 exit in this maze at [1,2].
 [1,0] does not count as an exit since it is the entrance cell.
 Initially, you are at the entrance cell [1,0].
 - You can reach [1,2] by moving 2 steps right.
 Thus, the nearest exit is [1,2], which is 2 steps away.
 Example 3:


 Input: maze = [[".","+"]], entrance = [0,0]
 Output: -1
 Explanation: There are no exits in this maze.


 Constraints:

 maze.length == m
 maze[i].length == n
 1 <= m, n <= 100
 maze[i][j] is either '.' or '+'.
 entrance.length == 2
 0 <= entrancerow < m
 0 <= entrancecol < n
 entrance will always be an empty cell.
 */

/*:
 # Code
 */

/*:
 # Tests
 */

struct Cell: Equatable {

    let x: Int
    let y: Int

    func value(_ grid: [[Character]]) -> Character {
        let row = grid[y]
        return row[x]
    }

    func moveUp(_ grid: [[Character]]) -> Cell? {
        let newY = y - 1
        guard newY >= 0 else { return nil }
        return Cell(x: x, y: newY)
    }

    func moveDown(_ grid: [[Character]]) -> Cell? {
        let newY = y + 1
        guard newY < grid.count else { return nil }
        return Cell(x: x, y: newY)
    }

    func moveRight(_ grid: [[Character]]) -> Cell? {
        let newX = x + 1
        guard newX < grid[0].count else { return nil }
        return Cell(x: newX, y: y)
    }

    func moveLeft(_ grid: [[Character]]) -> Cell? {
        let newX = x - 1
        guard newX >= 0 else { return nil }
        return Cell(x: newX, y: y)
    }

    func possibleMoves(_ grid: inout [[Character]], _ entrance: Cell) -> [Cell] {
        [
            moveUp(grid),
            moveDown(grid),
            moveLeft(grid),
            moveRight(grid)
        ]
            .compactMap { optionalCell in
                guard let cell = optionalCell,
                      cell.value(grid) == ".",
                      cell != entrance
                else { return nil }
                grid[cell.y][cell.x] = "+"
                return cell
            }
    }

    func isExit(_ grid: [[Character]], _ entrance: Cell) -> Bool {
        (x == 0 || x == grid[0].count - 1 || y == 0 || y == grid.count - 1) && self != entrance
    }
}


func nearestExit(_ maze: [[Character]], _ entrance: [Int]) -> Int {

    var maze = maze
    let entranceCell = Cell(x: entrance[1], y: entrance[0])
    var nextMoves = entranceCell.possibleMoves(&maze, entranceCell)
    var minSteps = 0

    while !nextMoves.isEmpty {
        var moves = [Cell]()
        minSteps += 1
        while !nextMoves.isEmpty {
            var first = nextMoves.removeFirst()
            if first.isExit(maze, entranceCell) {
                return minSteps
            } else {
                maze[first.y][first.x] = "+"
            }
            moves.append(contentsOf: first.possibleMoves(&maze, entranceCell))
        }
        nextMoves += moves
    }

    return -1
}

import XCTest
class Tests: XCTestCase {
    func testNearestExit() {
        let maze: [[Character]]
        maze = [["+","+",".","+"],[".",".",".","+"],["+","+","+","."]]
        XCTAssertEqual(nearestExit(maze, [1,2]), 1)
    }

    func testNearestExit2() {
        let maze: [[Character]]
        maze = [["+","+","+"],[".",".","."],["+","+","+"]]
        XCTAssertEqual(nearestExit(maze, [1,0]), 2)
    }

    func testNearestExit3() {
        let maze: [[Character]]
        maze = [[".","+"]]
        XCTAssertEqual(nearestExit(maze, [0,0]), -1)
    }
}

runTests(Tests())
