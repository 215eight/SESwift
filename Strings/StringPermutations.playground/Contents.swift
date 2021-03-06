/*:
 # Overview
 Write a function that prints all possible permutations of a given input string.
 Tip: A string permutation is any given rearrangement of its letters, for example “boamtw” is a permutation of “wombat”.
 */

/*:
 # Code
 */
func permutations(_ str: String) -> [String] {
    guard !str.isEmpty else { return [] }
    guard str.count > 1 else { return [str] }

    var result = [String]()
    var runnerIndex = str.startIndex
    while runnerIndex < str.endIndex {
        let char = str[runnerIndex...runnerIndex]
        var filteredStr = str
        filteredStr.remove(at: runnerIndex)
        let filteredStrPermutations = permutations(filteredStr)
        result += filteredStrPermutations.map { "\(char)\($0)" }
        runnerIndex = str.index(runnerIndex, offsetBy: 1)
    }
    return result
}

func permutations2(_ str: String) -> [String] {
    guard !str.isEmpty else { return [] }
    guard str.count > 1 else { return [str] }

    var result = [String]()
    let arrayStr = Array(str)
    for (offset, currentChar) in arrayStr.enumerated() {
        var copyArrayStr = arrayStr
        copyArrayStr.remove(at: offset)
        let filteredStrPermutations = permutations2(String(copyArrayStr))
        result += filteredStrPermutations.map { "\(currentChar)\($0)" }
    }
    return result
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testPermutations() {
        XCTAssertEqual(permutations(""), [])
        XCTAssertEqual(permutations("a"), ["a"])
        XCTAssertEqual(permutations("ab"), ["ab", "ba"])
        XCTAssertEqual(permutations("abc"), ["abc", "acb", "bac", "bca", "cab", "cba"])
        XCTAssertEqual(permutations("wombat").count, 720)
    }
    func testPermutations2() {
        XCTAssertEqual(permutations2(""), [])
        XCTAssertEqual(permutations2("a"), ["a"])
        XCTAssertEqual(permutations2("ab"), ["ab", "ba"])
        XCTAssertEqual(permutations2("abc"), ["abc", "acb", "bac", "bca", "cab", "cba"])
        XCTAssertEqual(permutations2("wombat").count, 720)
    }
}

runTests(Tests())
