/*:
 # Overview
 */

/*:
 # Code
 */

struct Stack<T: Comparable> {

    private var stack = [T]()

    var isEmpty: Bool {
        return stack.isEmpty
    }

    var top: T? {
        return stack.last
    }

    mutating func push(_ element: T) {
        return stack.append(element)
    }

    mutating func pop() -> T? {
        guard !stack.isEmpty else {
            return nil
        }
        return stack.removeLast()
    }
}

func isBalanced(s: String) -> String {

    var stack = Stack<Character>()

    let openBrackets: [Character: Character] = [
        "{":"}", "[":"]", "(":")"
    ]

    for char in s {
        guard "{}[]()".contains(char) else {
            continue
        }
        if openBrackets.keys.contains(char) {
            stack.push(char)
            continue
        }

        guard let top = stack.top, openBrackets[top] == char else {
            return "NO"
        }
        stack.pop()
    }

    return stack.isEmpty ? "YES" : "NO"
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testIsBalanced() {
        XCTAssertEqual(isBalanced(s: "{[()]}"), "YES")
        XCTAssertEqual(isBalanced(s: "{[(])}"), "NO")
        XCTAssertEqual(isBalanced(s: "{(([])[])[]]}"), "YES")
        XCTAssertEqual(isBalanced(s: "{{[[(())]]}}"), "YES")
    }
}

runTests(Tests())
