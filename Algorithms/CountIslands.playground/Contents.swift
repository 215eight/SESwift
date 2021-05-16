/*:
 # Overview
 Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.

 An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

 Input : mat[][] = {{1, 1, 0, 0, 0},
               {0, 1, 0, 0, 1},
               {1, 0, 0, 1, 1},
               {0, 0, 0, 0, 0},
               {1, 0, 1, 0, 1}
 Output : 5
 */

/*:
 # Code
 */
typealias Grid = [[Int]]
typealias Coordinate = (x: Int, y: Int)
typealias Island = [Coordinate]
typealias VisitedGrid = [[Bool]]


func surrounding(at coordinate: Coordinate, in grid: Grid) -> [Coordinate] {
    let dx = [-1, -1, -1, 0, 0, 1, 1, 1]
    let dy = [-1, 0, 1, -1, 1, -1, 0, 1]
    return zip(dx, dy).compactMap { tuple in
        let coordinate = Coordinate(x: coordinate.x + tuple.0, y: coordinate.y + tuple.1)
        let range = 0 ..< grid.count
        guard (range.contains(coordinate.x) && range.contains(coordinate.y)) else { return nil }
            return coordinate
    }
}


func findIslands(grid: Grid) -> Int {
    var islands = [Island]()
    var visited = Array(repeating: Array(repeating: false, count: grid.count), count: grid.count)
    for y in 0 ..< grid.count {
        for x in 0 ..< grid.count {
            guard visited[y][x] == false else {
                continue
            }

            visited[y][x] = true
            guard grid[y][x] == 1 else {
                continue
            }

            // Find Island
            var island = [Coordinate]()
            var acc = [(x: x, y: y)]
            while let coordinate = acc.popLast() {
                island.append(coordinate)
                visited[coordinate.y][coordinate.x] = true
                let surroundingCoordinates = surrounding(at: coordinate, in: grid)
                let validSurroundingCoordinates = surroundingCoordinates.filter { coor in
                    grid[coor.y][coor.x] == 1 && visited[coor.y][coor.x] == false
                }
                acc += validSurroundingCoordinates
            }

            islands.append(island)
        }
    }
    return islands.count
}

struct Coor: Hashable, CustomStringConvertible {
    let x: Int
    let y: Int

    var description: String {
        return "(x:\(x) y: \(y))"
    }
}

func surrounding2(at coordinate: Coor, in grid: Grid) -> Set<Coor> {
    let dx = [-1, -1, -1, 0, 0, 1, 1, 1]
    let dy = [-1, 0, 1, -1, 1, -1, 0, 1]
    let array = zip(dx, dy)
        .compactMap { tuple -> Coor? in
            let coordinate = Coor(x: coordinate.x + tuple.0, y: coordinate.y + tuple.1)
            let range = 0 ..< grid.count
            guard (range.contains(coordinate.x) && range.contains(coordinate.y)) else { return nil }
            return coordinate
        }
    return Set(array)
}

func findIslands2(grid: Grid) -> Int {
    var allLand = Set<Coor>()
    for y in 0 ..< grid.count {
        for x in 0 ..< grid.count {
            guard grid[y][x] == 1 else { continue }
            allLand.insert(Coor(x: x, y: y))
        }
    }

    var islands = [[Coor]]()
    while !allLand.isEmpty {

        var island = [Coor]()
        var acc = [allLand.removeFirst()]
        while let coordinate = acc.popLast() {
            island.append(coordinate)
            let surroundingCoordinates = surrounding2(at: coordinate, in: grid)
            let newAcc = allLand.intersection(surroundingCoordinates)
            acc.append(contentsOf: newAcc)
            allLand.subtract(newAcc)
        }
        islands.append(island)
    }

    islands.forEach { island in
        print(island)
    }
    return islands.count
}



/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testCountIslands() {
        let grid = [
            [1, 1, 0, 0, 0],
            [0, 1, 0, 0, 1],
            [1, 0, 0, 1, 1],
            [0, 0, 0, 0, 0],
            [1, 0, 1, 0, 1]
        ]
        XCTAssertEqual(findIslands(grid: grid), 5)
    }

    func testCountIslands2() {
        let grid = [
            [1, 1, 0, 0, 0],
            [0, 1, 0, 0, 1],
            [1, 0, 1, 1, 1],
            [1, 0, 0, 0, 1],
            [1, 0, 1, 0, 1]
        ]
        XCTAssertEqual(findIslands2(grid: grid), 2)
    }
}

class Observer: NSObject, XCTestObservation {}
XCTestObservationCenter.shared.addTestObserver(Observer())
Tests.self.defaultTestSuite.run()
