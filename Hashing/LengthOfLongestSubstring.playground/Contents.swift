/*:
 # Overview
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func lengthOfLongestSubstring(_ s: String) -> Int {
    guard s.count > 0 else { return 0 }

    var uniqueChars = Set<Character>()
    var longestCount = 0
    var start = 0
    var end = 0
    
    let array = Array(s)
    for index in 0 ..< array.count {
        end = index
        let char = array[end]
        if uniqueChars.contains(char) {
            let length = end - start
            longestCount = max(longestCount, length)
            
            var hasNotFound = true
            while start < end, hasNotFound {
                defer { start += 1 }
                let current = array[start]
                uniqueChars.remove(current)
                if current == char {
                    hasNotFound = false
                }
            }
        }
        uniqueChars.insert(char)
    }
    
    let length = end - start + 1
    longestCount = max(longestCount, length)
    
    return longestCount
}

func lengthOfLongestSubstring2(_ s: String) -> Int {
    guard s.count > 0 else { return 0 }
    
    var charMap = [Character : Int]()
    var longestCount = 0
    var start = 0
    
    let array = Array(s)
    for end in 0 ..< array.count {
        let char = array[end]
        if let newStart = charMap[char] {
            start = max(newStart, start)
        }
        charMap[char] = end + 1
        let length = end - start + 1
        longestCount = max(longestCount, length)
    }
    
    return longestCount
}

import XCTest
class Tests: XCTestCase {
    func testLengthOfLongestSubstring() {
        XCTAssertEqual(lengthOfLongestSubstring("abcabcbb"), 3)
        XCTAssertEqual(lengthOfLongestSubstring("bbbbb"), 1)
        XCTAssertEqual(lengthOfLongestSubstring("pwwkew"), 3)
    }
    
    func testLengthOfLongestSubstring2() {
        XCTAssertEqual(lengthOfLongestSubstring2("abcabcbb"), 3)
        XCTAssertEqual(lengthOfLongestSubstring2("bbbbb"), 1)
        XCTAssertEqual(lengthOfLongestSubstring2("pwwkew"), 3)
    }
}

runTests(Tests())
