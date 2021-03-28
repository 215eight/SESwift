/*:
 # Overview
 Write a function that accepts a two-dimensional array of integers that are 0 or 1, a new number to place, and a position to start. You should read the existing number at the start position, change it to the new number, then change any surrounding numbers that matched the start number, then change any surrounding those, and so on - like a flood fill algorithm in Photoshop.
 */

/*:
 # Code
 */

typealias Grid = [[Int]]

struct Coordinate: Hashable {
    let x: Int
    let y: Int

    func up(grid: Grid) -> Coordinate? {
        let newY = y - 1
        guard newY >= 0 && newY < grid.count else { return nil }
        return Coordinate(x: x, y: newY)
    }

    func down(grid: Grid) -> Coordinate? {
        let newY = y + 1
        guard newY >= 0 && newY < grid.count else { return nil }
        return Coordinate(x: x, y: newY)
    }

    func left(grid: Grid) -> Coordinate? {
        let newX = x - 1
        guard newX >= 0 && newX < grid.count else { return nil }
        return Coordinate(x: newX, y: y)
    }

    func right(grid: Grid) -> Coordinate? {
        let newX = x + 1
        guard newX >= 0 && newX < grid.count else { return nil }
        return Coordinate(x: newX, y: y)
    }

    func surroundingCoordinates(grid: Grid) -> [Coordinate] {
        return [
            up(grid: grid),
            down(grid: grid),
            right(grid: grid),
            left(grid: grid)
        ]
        .compactMap { $0 }
    }
}


func flood(grid: Grid, with value: Int, at coordinate: Coordinate) -> Grid {
    let oldValue = grid[coordinate.y][coordinate.x]
    return flood(grid: grid, newValue: value, oldValue: oldValue, at: [coordinate], visitedCoordinates: Set())
}

func flood(grid: Grid,
           newValue: Int,
           oldValue: Int,
           at coordinates: [Coordinate],
           visitedCoordinates: Set<Coordinate>) -> Grid {

    var grid = grid

    coordinates.forEach { grid[$0.y][$0.x] = newValue }

    let surroundingCoordinates = coordinates
        .flatMap {
            $0.surroundingCoordinates(grid: grid)
                .filter {
                    grid[$0.y][$0.x] == oldValue && !visitedCoordinates.contains($0)
                }
        }
    guard !surroundingCoordinates.isEmpty else { return grid }

    let newVisitedCoordinates = visitedCoordinates.union(surroundingCoordinates)

    return flood(grid: grid, newValue: newValue, oldValue: oldValue, at: surroundingCoordinates, visitedCoordinates: newVisitedCoordinates)
}

func print(grid: Grid) {
    for row in grid {
        let rowElements = row.map { String($0) }.joined(separator: " ")
        print("[ \(rowElements) ]")
    }
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testFlood() {
        let grid = [
            [0, 0, 0, 0, 0, 1, 0, 0, 1, 1],
            [0, 1, 1, 0, 0, 0, 0, 1, 0, 0],
            [0, 1, 0, 0, 0, 0, 0, 0, 1, 1],
            [1, 0, 1, 0, 0, 1, 1, 0, 0, 0],
            [1, 0, 1, 0, 1, 1, 1, 1, 1, 0],
            [1, 0, 1, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 1, 1, 1, 0, 1, 1],
            [1, 1, 1, 0, 0, 1, 1, 1, 1, 1],
            [1, 1, 0, 1, 1, 1, 1, 0, 0, 0],
            [0, 1, 1, 0, 0, 1, 0, 1, 1, 1]
        ]

        let expectedGrid = [
            [5, 5, 5, 5, 5, 1, 5, 5, 1, 1],
            [5, 1, 1, 5, 5, 5, 5, 1, 0, 0],
            [5, 1, 5, 5, 5, 5, 5, 5, 1, 1],
            [1, 0, 1, 5, 5, 1, 1, 5, 5, 5],
            [1, 0, 1, 5, 1, 1, 1, 1, 1, 5],
            [1, 0, 1, 1, 5, 5, 5, 5, 5, 5],
            [0, 0, 0, 0, 1, 1, 1, 5, 1, 1],
            [1, 1, 1, 0, 0, 1, 1, 1, 1, 1],
            [1, 1, 0, 1, 1, 1, 1, 0, 0, 0],
            [0, 1, 1, 0, 0, 1, 0, 1, 1, 1],
        ]
        let resultGrid = flood(grid: grid, with: 5, at: Coordinate(x: 2, y: 0))
        XCTAssertEqual(resultGrid, expectedGrid)
    }
}

runTests(Tests())
