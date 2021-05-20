/*:
 # Overview
 You are given a square grid with some cells open (.) and some blocked (X). Your playing piece can move along any row or column until it reaches the edge of the grid or a blocked cell. Given a grid, a start and a goal, determine the minmum number of moves to get to the goal.
 */

/*:
 # Code
 */

typealias Coordinate = (x: Int, y: Int)
typealias Grid = [[Int]]

func convertGrid(_ input: [String]) -> Grid {
    input.map { row in
        Array(row).map { element in
            element == "." ? 0 : 2
        }
    }
}

func adjacent(at coordinate: Coordinate, in grid: Grid) -> [Coordinate] {
    var result = [Coordinate]()
    for delta in [(x: 1, y: 0), (x: -1, y: 0), (x: 0, y: 1), (x: 0, y: -1)] {
        var newCoordinate = coordinate
        while true {
            newCoordinate = (x: newCoordinate.x + delta.x, y: newCoordinate.y + delta.y)
            guard (0 ..< grid[0].count).contains(newCoordinate.x),
                  (0 ..< grid.count).contains(newCoordinate.y) else {
                break
            }
            if grid[newCoordinate.y][newCoordinate.x] == 1 {
                continue
            }
            if grid[newCoordinate.y][newCoordinate.x] == 2 {
                break
            }
            result.append(newCoordinate)
        }
    }
    return result
}

func areEqual(_ lhs: Coordinate, _ rhs: Coordinate) -> Bool {
    lhs.x == rhs.x && lhs.y == rhs.y
}

func minimumMoves(grid: [String], startX: Int, startY: Int, goalX: Int, goalY: Int) -> Int {
    let convertedGrid = convertGrid(grid)
    var visitedGrid = convertedGrid
    var predecessors = Array(repeating: Array(repeating: (Coordinate(x: -1, y: -1)), count: grid[0].count), count: grid.count)

    let start = Coordinate(x: startY, y: startX)
    let end = Coordinate(x: goalY, y: goalX)

    var acc = [start]
    while !acc.isEmpty {
        let coordinate = acc.removeFirst()
        visitedGrid[coordinate.y][coordinate.x] = 1
        if areEqual(coordinate, end) {
            break
        }
        let adjacentCoordinates = adjacent(at: coordinate, in: visitedGrid)
        adjacentCoordinates.forEach {
            visitedGrid[$0.y][$0.x] = 1
            predecessors[$0.y][$0.x] = coordinate
        }
        acc += adjacentCoordinates
    }

    var moves = [end]
    var acc2 = moves
    while !acc2.isEmpty {
        let first = acc2.removeFirst()
        let predecessor = predecessors[first.y][first.x]
        guard predecessor.x != -1, predecessor.y != -1 else {
            break
        }
        moves.append(predecessor)
        acc2.append(predecessor)
    }
    return moves.count - 1
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testMinimumMoves() {
        XCTAssertEqual(minimumMoves(grid: ["...", ".X.", "..."], startX: 0, startY: 0, goalX: 1, goalY: 2), 2)
        XCTAssertEqual(minimumMoves(grid: [".X.", ".X.", "..."], startX: 0, startY: 0, goalX: 0, goalY: 2), 3)
    }
}

runTests(Tests())
