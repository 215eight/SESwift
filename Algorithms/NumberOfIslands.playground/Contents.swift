/*:
 # Overview
 Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.

 An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.



 Example 1:

 Input: grid = [
   ["1","1","1","1","0"],
   ["1","1","0","1","0"],
   ["1","1","0","0","0"],
   ["0","0","0","0","0"]
 ]
 Output: 1
 Example 2:

 Input: grid = [
   ["1","1","0","0","0"],
   ["1","1","0","0","0"],
   ["0","0","1","0","0"],
   ["0","0","0","1","1"]
 ]
 Output: 3


 Constraints:

 m == grid.length
 n == grid[i].length
 1 <= m, n <= 300
 grid[i][j] is '0' or '1'.
 */

/*:
 # Code
 */

struct Coordinate: Hashable, CustomStringConvertible {
    let x: Int
    let y: Int

    var description: String {
        "(\(x), \(y))"
    }

    func adjacent() -> [Coordinate] {
        [
            Coordinate(x: x, y: y + 1),
            Coordinate(x: x, y: y - 1),
            Coordinate(x: x + 1, y: y),
            Coordinate(x: x - 1, y: y),
        ]
    }
}

func islands(_ grid: [[Character]]) -> [Set<Coordinate>]{
    let allLand = grid.enumerated().flatMap { y, row in
        row.enumerated().compactMap { x, value in
            value == "1" ? Coordinate(x: x, y: y) : nil
        }
    }
    var land = Set(allLand)

    var islands = [Set<Coordinate>]()
    while let islandStart = land.first {
        let island = getIsland(start: islandStart, land: land)
        if !island.isEmpty {
            islands.append(island)
        }
        land = land.subtracting(island)
    }
    return islands
}

func getIsland(start: Coordinate, land: Set<Coordinate>) -> Set<Coordinate> {
    var islandLand = Set<Coordinate>()
    islandLand.insert(start)
    var adjacentLand = start
        .adjacent()
        .filter { land.contains($0) }
    while !adjacentLand.isEmpty {
        adjacentLand.forEach {
            islandLand.insert($0)
        }
        adjacentLand = adjacentLand
            .flatMap {
                $0.adjacent().filter {
                    !islandLand.contains($0) && land.contains($0)
                }
            }
    }
    return islandLand
}

func numIslands(_ grid: [[Character]]) -> Int {

    var allLand = Set<Coordinate>()
    for (y, row) in grid.enumerated() {
        for (x, value) in row.enumerated() {
            guard value == "1" else { continue }
            allLand.insert(Coordinate(x: x, y: y))
        }
    }

    func up(_ coordinate: Coordinate, in grid: [[Character]]) -> Coordinate? {
        guard (0 ..< grid.count).contains(coordinate.y + 1) else { return nil }
        return Coordinate(x: coordinate.x, y: coordinate.y + 1)
    }

    func down(_ coordinate: Coordinate, in grid: [[Character]]) -> Coordinate? {
        guard (0 ..< grid.count).contains(coordinate.y - 1) else { return nil }
        return Coordinate(x: coordinate.x, y: coordinate.y - 1)
    }

    func left(_ coordinate: Coordinate, in grid: [[Character]]) -> Coordinate? {
        guard (0 ..< grid[0].count).contains(coordinate.x - 1) else { return nil }
        return Coordinate(x: coordinate.x - 1, y: coordinate.y)
    }

    func right(_ coordinate: Coordinate, in grid: [[Character]]) -> Coordinate? {
        guard (0 ..< grid[0].count).contains(coordinate.x + 1) else { return nil }
        return Coordinate(x: coordinate.x + 1, y: coordinate.y)
    }

    func getIsland(at coordinate: Coordinate, allLand: Set<Coordinate>) -> Set<Coordinate> {
        var island = Set<Coordinate>()
        island.insert(coordinate)


        var findAdjacent = [coordinate]

        while !findAdjacent.isEmpty {
            let land = findAdjacent.removeFirst()

            let adjacent = [
                up(land, in: grid),
                down(land, in: grid),
                left(land, in: grid),
                right(land, in: grid)
            ]
            .compactMap { $0 }

            let newLand = Set(adjacent).subtracting(island).intersection(allLand)
            island.formUnion(newLand)
            findAdjacent.append(contentsOf: newLand)
        }

        return island
    }

    var islands = [Set<Coordinate>]()
    while let land = allLand.popFirst() {
        let island  = getIsland(at: land, allLand: allLand)
        allLand.subtract(island)
        islands.append(island)
    }
    return islands.count
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testNumberOfIslands() {
        XCTAssertEqual(
            islands([
                ["1","1","1","1","0"],
                ["1","1","0","1","0"],
                ["1","1","0","0","0"],
                ["0","0","0","0","0"]
            ]).count,
            1)
        XCTAssertEqual(
            islands([
                ["1","1","0","0","0"],
                ["1","1","0","0","0"],
                ["0","0","1","0","0"],
                ["0","0","0","1","1"]
            ]).count,
            3)
    }
    func testNumIslands() {
        XCTAssertEqual(
            numIslands([
                ["1","1","1","1","0"],
                ["1","1","0","1","0"],
                ["1","1","0","0","0"],
                ["0","0","0","0","0"]
            ]),
            1)
        XCTAssertEqual(
            numIslands([
                ["1","1","0","0","0"],
                ["1","1","0","0","0"],
                ["0","0","1","0","0"],
                ["0","0","0","1","1"]
            ]),
            3)
    }
}

runTests(Tests())
