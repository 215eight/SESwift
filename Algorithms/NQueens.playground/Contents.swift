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

struct Grid: Hashable {
    let size: Int

    var queenCoordinates: Set<Coordinate>
    var takenCoordinates: Set<Coordinate>
    var availableCoordinates: Set<Coordinate>

    enum State {
        case partial
        case unsolved
        case solved
    }

    var state: State {
        guard queenCoordinates.count <= size else {
            fatalError()
        }

        if queenCoordinates.count == size {
            return .solved
        } else {
            return availableCoordinates.isEmpty ? .unsolved : .partial
        }
    }

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

    init(size: Int,
         queenCoordinates: Set<Coordinate>,
         takenCoordinates: Set<Coordinate>,
         availableCoordinates: Set<Coordinate>) {
        self.size = size
        self.queenCoordinates = queenCoordinates
        self.takenCoordinates = takenCoordinates
        self.availableCoordinates = availableCoordinates
    }

    func nQueens() -> [Grid] {

        switch self.state {
        case .partial:
//            print("Partial")
//            print(self.description)
            var solutions = [Grid]()
            for availableCoordinate in availableCoordinates {
                let updatedGrid = place(at: availableCoordinate)
                solutions.append(contentsOf: updatedGrid.nQueens())
            }
            return solutions

        case .unsolved:
//            print("Unsolved")
//            print(self.description)
            return []
        case .solved:
//            print("Solved")
//            print(self.description)
            return [self]
        }
    }

    func place(at coordinate: Coordinate) -> Grid {
        guard !takenCoordinates.contains(coordinate) else {
            fatalError()
        }

        let removeCoordinates = captureCoordinates(for: coordinate)
        let newAvailableCoordinates = availableCoordinates.subtracting(removeCoordinates)

        guard !newAvailableCoordinates.contains(coordinate) else {
            fatalError()
        }

        let newTakenCoordinates = takenCoordinates.union(removeCoordinates)
        var newQueenCoordiantes = queenCoordinates
        newQueenCoordiantes.insert(coordinate)

        return Grid(size: size,
                    queenCoordinates: newQueenCoordiantes,
                    takenCoordinates: newTakenCoordinates,
                    availableCoordinates: newAvailableCoordinates)
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

func nQueens2(board: [Int], queen queenNumber: Int) -> Int {
    if queenNumber == board.count {
        print("Solution:", board)
        for row in 0 ..< board.count {
            for col in 0 ..< board.count {
                if board[row] == col {
                    print("Q", terminator: "")
                } else {
                    print(".", terminator: "")
                }
            }
            print("")
        }

        print("")
        return 1
    } else {
        var count = 0
        boardLoop: for column in 0 ..< board.count {
            for row in 0 ..< queenNumber {
                let otherQueenColumn = board[row]
                if otherQueenColumn == column { continue boardLoop }

                let deltaRow = queenNumber - row
                let deltaCol = otherQueenColumn - column
                if deltaRow == deltaCol { continue boardLoop }
                if deltaRow == -deltaCol { continue boardLoop }
            }

            var boardCopy = board
            boardCopy[queenNumber] = column

            count += nQueens2(board: boardCopy, queen: queenNumber + 1)
        }
        return count
    }
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testNQueens() {
        let grid = Grid(size: 5)
        let solutions = grid.nQueens()
//        XCTAssertEqual(Set(solutions).count, 2) // 4
        XCTAssertEqual(Set(solutions).count, 10) // 5
//        XCTAssertEqual(Set(solutions).count, 4) // 6
//        XCTAssertEqual(Set(solutions).count, 40) // 7
//        XCTAssertEqual(Set(solutions).count, 92) // 8
    }

    func testNQueens2() {
        let emptyBoard = [Int](repeating: 0, count: 8)
        let solutionCount = nQueens2(board: emptyBoard, queen: 0)
        print("Found \(solutionCount) solutions")
    }
}

runTests(Tests())
