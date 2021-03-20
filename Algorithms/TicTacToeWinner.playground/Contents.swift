/*:
 # Overview
 lCreate a function that detects whether either player has won in a game of Tic-Tac-Toe.
 Tip: A tic-tac-toe board is 3x3, containing single letters that are either X, O, or empty. A win is three Xs or Os in a straight line.
 */

/*:
 # Code
 */

func isWinner(ticTacToe: [[String]]) -> Bool {
    typealias Coordinate = (x: Int, y: Int)

    func value(at coordinate: Coordinate, ticTacToe: [[String]]) -> String {
        let row = ticTacToe[coordinate.y]
        return row[coordinate.x]
    }

    func isWin(ticTacToe: [[String]], coordinates: [[Coordinate]]) -> Bool {
        for coordinateGroup in coordinates {
            print(coordinateGroup)
            var result: String? = nil
            for coordinate in coordinateGroup {
                let coordinateValue = value(at: coordinate, ticTacToe: ticTacToe)
                guard !coordinateValue.isEmpty else {
                    result = nil
                    break
                }
                guard let previousResult = result else {
                    result = coordinateValue
                    continue
                }
                guard coordinateValue == previousResult else {
                    result = nil
                    break
                }
            }
            if result != nil { return true }
        }
        return false
    }

    func isRowWin(_ ticTacToe: [[String]]) -> Bool {
        let winningCoordinates = (0 ..< 3).map { y in
            (0 ..< 3).map { x in
                return (x: x, y: y)
            }
        }
        return isWin(ticTacToe: ticTacToe, coordinates: winningCoordinates)
    }

    func isColumnWin(_ ticTacToe: [[String]]) -> Bool {
        let winningCoordinates = (0 ..< 3).map { x in
            (0 ..< 3).map { y in
                return (x: x, y: y)
            }
        }
        return isWin(ticTacToe: ticTacToe, coordinates: winningCoordinates)
    }

    func isDiagonalWin(_ ticTacToe: [[String]]) -> Bool {
        let winningCoordinates = [
            (0 ..< 3).map { x in
                return (x: x, y: x)
            },
            (0 ..< 3).reversed().map { x in
                return (x: x, y: x)
            }
        ]
        return isWin(ticTacToe: ticTacToe, coordinates: winningCoordinates)
    }


    return isRowWin(ticTacToe) || isColumnWin(ticTacToe) || isDiagonalWin(ticTacToe)
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testTicTacToeWinner() {
        XCTAssertTrue(isWinner(ticTacToe: [["X", "", "O"], ["", "X", "O"], ["", "", "X"]]))
        XCTAssertTrue(isWinner(ticTacToe: [["X", "", "O"], ["X", "", "O"], ["X", "", ""]]))
        XCTAssertTrue(isWinner(ticTacToe: [["", "X", ""], ["O", "X", ""], ["O", "X", ""]]))
        XCTAssertFalse(isWinner(ticTacToe: [["", "X", ""], ["O", "X", ""], ["O", "", "X"]]))
        XCTAssertFalse(isWinner(ticTacToe: [["", "", ""], ["", "", ""], ["", "", ""]]))
    }
}

runTests(Tests())
