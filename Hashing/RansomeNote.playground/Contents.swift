/*:
 # Overview
 Given two strings ransomNote and magazine, return true if ransomNote can be constructed by using the letters from magazine and false otherwise.

 Each letter in magazine can only be used once in ransomNote.

  

 Example 1:

 Input: ransomNote = "a", magazine = "b"
 Output: false
 Example 2:

 Input: ransomNote = "aa", magazine = "ab"
 Output: false
 Example 3:

 Input: ransomNote = "aa", magazine = "aab"
 Output: true
  

 Constraints:

 1 <= ransomNote.length, magazine.length <= 105
 ransomNote and magazine consist of lowercase English letters.
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
    var ransomNoteMap = [Character: Int]()
    ransomNote.forEach {
        ransomNoteMap[$0] = (ransomNoteMap[$0] ?? 0) + 1
    }
    
    for char in magazine {
        if let count = ransomNoteMap[char] {
            let updatedCount = count - 1
            if updatedCount == 0 {
                ransomNoteMap[char] = nil
            } else {
                ransomNoteMap[char] = count - 1
            }
        }
    }
    return ransomNoteMap.isEmpty
}

import XCTest
class Tests: XCTestCase {
    func testRansomeNote() {
        XCTAssertFalse(canConstruct("a", "b"))
        XCTAssertFalse(canConstruct("aa", "ab"))
        XCTAssertTrue(canConstruct("aa", "aab"))
    }
}

runTests(Tests())
