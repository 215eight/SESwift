/*:
 # Overview
 Write a function that accepts a string containing the characters (, [, {, <, >, }, ], and ) in any arrangement and frequency. It should return true if the brackets are opened and closed in the correct order, and if all brackets are closed. Any other input should false.
 */

/*:
 # Code
 */

func balancedBrackets(_ input: String) -> Bool {
    let brackets: [Character: Character] = [
        "(" : ")",
        "[" : "]",
        "{" : "}",
        "<" : ">",
    ]
    let closingBrackets = Set(brackets.values)

    var queue = [Character]()
    for element in input {
        if let closingBracket = brackets[element] {
            queue.append(closingBracket)
        } else if closingBrackets.contains(element) {
            guard queue.last == element else { return false }
            queue.removeLast()
        } else {
            return false
        }
    }
    return queue.isEmpty
}

extension Character {
    var isOpenBracket: Bool {
        let characterSet = CharacterSet(charactersIn: "([{<")
        guard let scalar = self.unicodeScalars.first else { return false }
        return characterSet.contains(scalar)
    }

    var isCloseBracket: Bool {
        let characterSet = CharacterSet(charactersIn: ")]}>")
        guard let scalar = self.unicodeScalars.first else { return false }
        return characterSet.contains(scalar)
    }

    func isMatchingCloseBracket(_ bracket: Character) -> Bool {
        let bracketsMap: [Character: Character] = [
            "(" : ")",
            "[" : "]",
            "{" : "}",
            "<" : ">",
        ]

        guard let matchingCloseBaracket = bracketsMap[self] else { return false }
        return bracket == matchingCloseBaracket
    }
}

func balancedBracketsRecursive(openInput: String, input: String) -> Bool {
    guard let firstChar = input.first else {
        return openInput.isEmpty
    }

    var updatedInput = input
    updatedInput.removeFirst()

    if firstChar.isOpenBracket {
        let updatedOpenInput = openInput + "\(firstChar)"
        return balancedBracketsRecursive(openInput: updatedOpenInput, input: updatedInput)
    } else if firstChar.isCloseBracket {
        guard let lastOpenBracket = openInput.last,
              lastOpenBracket.isMatchingCloseBracket(firstChar) else {
            return false
        }
        var updatedOpenInput = openInput
        updatedOpenInput.removeLast()
        return balancedBracketsRecursive(openInput: updatedOpenInput, input: updatedInput)
    } else {
        return false
    }
}

func balancedBrackets2(_ input: String) -> Bool {
    return balancedBracketsRecursive(openInput: "", input: input)
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testBalancedBrackets() {
        XCTAssertTrue(balancedBrackets("()"))
        XCTAssertTrue(balancedBrackets("([])"))
        XCTAssertTrue(balancedBrackets("([])(<{}>)"))
        XCTAssertTrue(balancedBrackets("([]{}<[{}]>)"))
        XCTAssertTrue(balancedBrackets(""))
        XCTAssertFalse(balancedBrackets("}{"))
        XCTAssertFalse(balancedBrackets("([)]"))
        XCTAssertFalse(balancedBrackets("([)"))
        XCTAssertFalse(balancedBrackets("(["))
        XCTAssertFalse(balancedBrackets("[<<<{}>>]"))
        XCTAssertFalse(balancedBrackets("hello"))
    }

    func testIsOpenBracket() {
        let openParenthesis = Character("(")
        XCTAssertTrue(openParenthesis.isOpenBracket)
        let openBracket = Character("[")
        XCTAssertTrue(openBracket.isOpenBracket)
        let openCurlyBrace = Character("{")
        XCTAssertTrue(openCurlyBrace.isOpenBracket)
        let openAngleBracket = Character("<")
        XCTAssertTrue(openAngleBracket.isOpenBracket)
        let randomChar = Character("a")
        XCTAssertFalse(randomChar.isOpenBracket)
    }

    func testIsMatchingCloseBracket() {
        let openParenthesis = Character("(")
        XCTAssertTrue(openParenthesis.isMatchingCloseBracket(")"))
        XCTAssertFalse(openParenthesis.isMatchingCloseBracket("a"))
        let openBracket = Character("[")
        XCTAssertTrue(openBracket.isMatchingCloseBracket("]"))
        XCTAssertFalse(openBracket.isMatchingCloseBracket(")"))
        let openCurlyBrace = Character("{")
        XCTAssertTrue(openCurlyBrace.isMatchingCloseBracket("}"))
        XCTAssertFalse(openCurlyBrace.isMatchingCloseBracket("-"))
        let openAngleBracket = Character("<")
        XCTAssertTrue(openAngleBracket.isMatchingCloseBracket(">"))
        XCTAssertFalse(openAngleBracket.isMatchingCloseBracket("}"))
    }

    func testBalancedBrackets2() {
        XCTAssertTrue(balancedBrackets2("()"))
        XCTAssertTrue(balancedBrackets2("([])"))
        XCTAssertTrue(balancedBrackets2("([])(<{}>)"))
        XCTAssertTrue(balancedBrackets2("([]{}<[{}]>)"))
        XCTAssertTrue(balancedBrackets2(""))
        XCTAssertFalse(balancedBrackets2("}{"))
        XCTAssertFalse(balancedBrackets2("([)]"))
        XCTAssertFalse(balancedBrackets2("([)"))
        XCTAssertFalse(balancedBrackets2("(["))
        XCTAssertFalse(balancedBrackets2("[<<<{}>>]"))
        XCTAssertFalse(balancedBrackets2("hello"))
    }

    func testBalanceBracketsPerformance() {
        let openBrackets = String(repeating: "(", count: 100)
        let closeBrackets = String(repeating: ")", count: 100)
        let testInput = openBrackets + closeBrackets
        XCTAssertTrue(balancedBrackets(testInput))
    }

    func testBalanceBrackets2Performance() {
        let openBrackets = String(repeating: "(", count: 100)
        let closeBrackets = String(repeating: ")", count: 100)
        let testInput = openBrackets + closeBrackets
        XCTAssertTrue(balancedBrackets2(testInput))
    }
}

runTests(Tests())
