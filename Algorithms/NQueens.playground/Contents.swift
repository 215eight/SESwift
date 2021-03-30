/*:
 # Overview
 There are M different ways you can place N queens on an NxN chessboard so that none of them are able to capture others. Write a function that calculates them all and prints them to the screen as a visual board layout, and returns the number of solutions it found.
 Tip: A queen moves in straight lines vertically, horizontally, or diagonally. You need to place all eight queens so that no two share the same row, column, or diagonal.
 Tip: In the more advanced version of this challenge you would be required to return only the fundamental solutions, which means unique positions excluding rotations and reflections. This is not a requirement here.
 */

/*:
 # Code
 */

struct Coordinate: Hashable, CustomStringConvertible, Comparable {

    let x: Int
    let y: Int

    var description: String {
        "(x: \(x) y: \(y))"
    }

    static func < (lhs: Coordinate, rhs: Coordinate) -> Bool {
        if lhs.y < rhs.y {
            return true
        } else if lhs.y > rhs.y {
            return false
        } else {
            return lhs.x < rhs.x
        }
    }
}

struct Grid {
    let size: Int

    var queenCoordinates: Set<Coordinate>
    var takenCoordinates: Set<Coordinate>
    var availableCoordinates: Set<Coordinate>

    init(size: Int) {
        self.size = size
        queenCoordinates = Set<Coordinate>()
        takenCoordinates = Set<Coordinate>()
        let allCoordinates = (0 ..< size).map { x in
            (0 ..< size).map { y in
                Coordinate(x: x, y: y)
            }
        }
        .flatMap { $0 }

        availableCoordinates = Set(allCoordinates)
    }

    mutating func placeNext() -> Bool {
        guard !availableCoordinates.isEmpty else { return false }
        let coordinate = availableCoordinates.removeFirst()
        guard !takenCoordinates.contains(coordinate) else {
            fatalError()
        }

        let removeCoordinates = captureCoordinates(for: coordinate)
        availableCoordinates = availableCoordinates.subtracting(removeCoordinates)

        guard !availableCoordinates.contains(coordinate) else {
            fatalError()
        }

        takenCoordinates = takenCoordinates.union(removeCoordinates)
        queenCoordinates.insert(coordinate)
        return true
    }

    func captureCoordinates(for coordinate: Coordinate) -> Set<Coordinate> {
        var result = Set<Coordinate>()

        let row = (0 ..< size).map { x in
            Coordinate(x: x, y: coordinate.y)
        }

        let column = (0 ..< size).map { y in
            Coordinate(x: coordinate.x, y: y)
        }

        let diagonal = (0 ..< size).compactMap { i -> Coordinate? in
            let x = i - coordinate.y + coordinate.x
            let y = i
            guard (0 ..< size).contains(x), (0 ..< size).contains(y) else { return nil }
            return Coordinate(x: x, y: y)
        }

        let reverseDiagonal = (0 ..< size).compactMap { i -> Coordinate? in
            let x = i + coordinate.x + coordinate.y - size + 1
            let y = size - 1 - i
            guard (0 ..< size).contains(x), (0 ..< size).contains(y) else { return nil }
            return Coordinate(x: x, y: y)
        }

        result.formUnion(row)
        result.formUnion(column)
        result.formUnion(diagonal)
        result.formUnion(reverseDiagonal)

        return result
    }

    var description: String {
        var grid = Array(repeating: Array(repeating: "@", count: size), count: size)

        guard availableCoordinates.intersection(takenCoordinates).isEmpty else {
            fatalError()
        }

        takenCoordinates.forEach { coordinate in
            grid[coordinate.y][coordinate.x] = "X"
        }

        availableCoordinates.forEach { coordinate in
            grid[coordinate.y][coordinate.x] = "."
        }

        queenCoordinates.forEach { coordinate in
            grid[coordinate.y][coordinate.x] = "Q"
        }

        return grid.map { row in
            row.joined(separator: " ")
        }
        .joined(separator: "\n")
    }
}



/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testNQueens() {
        var grid = Grid(size: 8)
        print()
        print(grid.description)
        grid.placeNext()
        print()
        print(grid.description)
        grid.placeNext()
        print()
        print(grid.description)
        grid.placeNext()
        print()
        print(grid.description)
        grid.placeNext()
        print()
        print(grid.description)
        grid.placeNext()
        print()
        print(grid.description)
        grid.placeNext()
        print()
        print(grid.description)
        grid.placeNext()
        print()
        print(grid.description)
        grid.placeNext()
        print()
        print(grid.description)
    }
}

runTests(Tests())
