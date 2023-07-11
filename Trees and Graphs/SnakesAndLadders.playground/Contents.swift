/*:
 # Overview
 You are given an n x n integer matrix board where the cells are labeled from 1 to n2 in a Boustrophedon style starting from the bottom left of the board (i.e. board[n - 1][0]) and alternating direction each row.

 You start on square 1 of the board. In each move, starting from square curr, do the following:

 Choose a destination square next with a label in the range [curr + 1, min(curr + 6, n2)].
 This choice simulates the result of a standard 6-sided die roll: i.e., there are always at most 6 destinations, regardless of the size of the board.
 If next has a snake or ladder, you must move to the destination of that snake or ladder. Otherwise, you move to next.
 The game ends when you reach the square n2.
 A board square on row r and column c has a snake or ladder if board[r][c] != -1. The destination of that snake or ladder is board[r][c]. Squares 1 and n2 do not have a snake or ladder.

 Note that you only take a snake or ladder at most once per move. If the destination to a snake or ladder is the start of another snake or ladder, you do not follow the subsequent snake or ladder.

 For example, suppose the board is [[-1,4],[-1,3]], and on the first move, your destination square is 2. You follow the ladder to square 3, but do not follow the subsequent ladder to 4.
 Return the least number of moves required to reach the square n2. If it is not possible to reach the square, return -1.



 Example 1:


 Input: board = [[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,35,-1,-1,13,-1],[-1,-1,-1,-1,-1,-1],[-1,15,-1,-1,-1,-1]]
 Output: 4
 Explanation:
 In the beginning, you start at square 1 (at row 5, column 0).
 You decide to move to square 2 and must take the ladder to square 15.
 You then decide to move to square 17 and must take the snake to square 13.
 You then decide to move to square 14 and must take the ladder to square 35.
 You then decide to move to square 36, ending the game.
 This is the lowest possible number of moves to reach the last square, so return 4.
 Example 2:

 Input: board = [[-1,-1],[-1,3]]
 Output: 1


 Constraints:

 n == board.length == board[i].length
 2 <= n <= 20
 board[i][j] is either -1 or in the range [1, n2].
 The squares labeled 1 and n2 do not have any ladders or snakes.
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
}

func cell(position: Int, in board: [[Int]]) -> Cell {
    guard position < (board.count * board.count) else {
        fatalError()
    }

    let row = board.count - (position / board.count) - 1
    assert(row >= 0 && row < board.count)
    let column = ((row % 2) == (board.count % 2 == 0 ? 1 : 0)) ? position % board.count : (board.count - (position % board.count) - 1)
    assert(column >= 0 && column < board.count)
    return Cell(x: column, y: row)
}

func destination(position: Int, in board: [[Int]]) -> Int {
    guard position < (board.count * board.count) else {
        fatalError()
    }
    guard position != 0 && position != ((board.count * board.count) - 1) else {
        return position
    }

    let cell = cell(position: position, in: board)
    let destination = board[cell.y][cell.x]
    return destination == -1 ? position : (destination - 1)
}

func snakesAndLadders(_ board: [[Int]]) -> Int {
    typealias MoveCount = (destination: Int, count: Int)
    var position = 0
    var moves: [MoveCount] = [(0, 0)]
    var visitedPositions = Set(arrayLiteral: 0)

    while !moves.isEmpty {
        let moveCount = moves.removeFirst()
        for offset in (1...6) {
            let newPosition = moveCount.destination + offset
            guard newPosition < (board.count * board.count)  else {
                continue
            }
            let newDestination = destination(position: moveCount.destination + offset, in: board)
            let newCount = moveCount.count + 1
            guard !visitedPositions.contains(newDestination) else {
                continue
            }
            visitedPositions.insert(newDestination)
            if newDestination == ((board.count * board.count) - 1) {
                print("@@@ Destination: \(newDestination) - Count: \(newCount)")
                return newCount
            } else {
                print("### Destination: \(newDestination) - Count: \(newCount)")
                moves.append(MoveCount(newDestination, newCount))
            }
        }
    }
    return -1
}


import XCTest
class Tests: XCTestCase {
    func testCellAtPosition() {
        let board: [[Int]]
        board = Array(repeating: Array(repeating: 0, count: 6), count: 6)
        XCTAssertEqual(cell(position: 0, in: board), Cell(x: 0, y: 5))
        XCTAssertEqual(cell(position: 1, in: board), Cell(x: 1, y: 5))
        XCTAssertEqual(cell(position: 2, in: board), Cell(x: 2, y: 5))
        XCTAssertEqual(cell(position: 3, in: board), Cell(x: 3, y: 5))
        XCTAssertEqual(cell(position: 4, in: board), Cell(x: 4, y: 5))
        XCTAssertEqual(cell(position: 5, in: board), Cell(x: 5, y: 5))
        XCTAssertEqual(cell(position: 6, in: board), Cell(x: 5, y: 4))
        XCTAssertEqual(cell(position: 11, in: board), Cell(x: 0, y: 4))
        XCTAssertEqual(cell(position: 12, in: board), Cell(x: 0, y: 3))
        XCTAssertEqual(cell(position: 30, in: board), Cell(x: 5, y: 0))
        XCTAssertEqual(cell(position: 35, in: board), Cell(x: 0, y: 0))
    }

    func testValueAtPosition() {
        let board: [[Int]] = (0..<6)
            .reversed()
            .map { value in
                let row = (0..<6).map { innerValue in
                    (value * 6) + innerValue + 1
                }
                return value % 2 == 0 ? row : row.reversed()
            }
        XCTAssertEqual(destination(position: 0, in: board), 0)
        XCTAssertEqual(destination(position: 1, in: board), 1)
        XCTAssertEqual(destination(position: 6, in: board), 6)
        XCTAssertEqual(destination(position: 35, in: board), 35)
    }

    func testSnakeorLadderDestination() {
        let board: [[Int]] = [
            [-1, 1, -1, -1, -1, -1],
            [-1, -1, -1, -1, -1, -1],
            [-1, -1, -1, -1, -1, -1],
            [-1, -1, -1, -1, -1, -1],
            [-1, -1, -1, -1, -1, -1],
            [-1, 35, -1, -1, -1, -1],
        ]
        XCTAssertEqual(destination(position: 0, in: board), 0)
        XCTAssertEqual(destination(position: 1, in: board), 34)
        XCTAssertEqual(destination(position: 35, in: board), 35)
    }

    func testSnakeOrLadderDestination2() {
        let board = [[-1,-1,19,10,-1],[2,-1,-1,6,-1],[-1,17,-1,19,-1],[25,-1,20,-1,-1],[-1,-1,-1,-1,15]]
        XCTAssertEqual(destination(position: 5, in: board), 5)
    }

    func testSnakeAndLadders() {
        let board = [[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,35,-1,-1,13,-1],[-1,-1,-1,-1,-1,-1],[-1,15,-1,-1,-1,-1]]
        XCTAssertEqual(snakesAndLadders(board), 4)
    }

    func testSnakeAndLadders1() {
        let board = [[-1,-1],[-1,3]]
        XCTAssertEqual(snakesAndLadders(board), 1)
    }

    func testSnakeAndLadders2() {
        let board = [[-1,-1,19,10,-1],[2,-1,-1,6,-1],[-1,17,-1,19,-1],[25,-1,20,-1,-1],[-1,-1,-1,-1,15]]
        XCTAssertEqual(snakesAndLadders(board), 2)
    }
}

runTests(Tests())
