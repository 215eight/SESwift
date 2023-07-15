/*:
 # Overview
 Example 3: 2300. Successful Pairs of Spells and Potions

 You are given two positive integer arrays spells and potions, where spells[i] represents the strength of the ith spell and potions[j] represents the strength of the jth potion. You are also given an integer success. A spell and potion pair is considered successful if the product of their strengths is at least success. For each spell, find how many potions it can pair with to be successful. Return an integer array where the ithi element is the answer for the ithi spell.
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func successfulPairs(spells: [Int], potions: [Int], success: Int) -> [Int] {
    let sortedPotions = potions.sorted()
    var result = [Int]()
    for spell in spells {
        let targetPotion = Int(ceil(Double(success) / Double(spell)))
        let index = findPotion(sortedPotions: sortedPotions, target: targetPotion)
        result.append(potions.count - index)
    }
    return result
}

func findPotion(sortedPotions: [Int], target: Int) -> Int {
    var left = 0
    var right = sortedPotions.count - 1

    while left <= right {
        let mid = left + ((right - left) / 2)
        if sortedPotions[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return left
}

import XCTest
class Tests: XCTestCase {
    func testSuccessfulPairs() {
        XCTAssertEqual(successfulPairs(
            spells: [],
            potions: [],
            success: 0
        ), [])
        XCTAssertEqual(successfulPairs(
            spells: [1],
            potions: [1],
            success: 1
        ), [1])
        XCTAssertEqual(successfulPairs(
            spells: [1,2,3],
            potions: [3,2,1],
            success: 6
        ), [0, 1, 2])
        XCTAssertEqual(successfulPairs(
            spells: [1,2,3],
            potions: [3,2,1],
            success: 6
        ), [0, 1, 2])
        XCTAssertEqual(successfulPairs(
            spells: [5,1,3],
            potions: [1,2,3,4,5],
            success: 7
        ), [4, 0, 3])

    }
}

runTests(Tests())
