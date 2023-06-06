/*:
 # Overview
 Given a string text, you want to use the characters of text to form as many instances of the word "balloon" as possible.

 You can use each character in text at most once. Return the maximum number of instances that can be formed.

  

 Example 1:
 Input: text = "nlaebolko"
 Output: 1
 
 Example 2:
 Input: text = "loonbalxballpoon"
 Output: 2
 Example 3:

 Input: text = "leetcode"
 Output: 0
  

 Constraints:

 1 <= text.length <= 104
 text consists of lower case English letters only.
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func maxNumberOfBalloons(_ text: String) -> Int {
    var countChar = [Character: Int]()
    "balloon".forEach {
        countChar[$0] = 0
    }
    
    var lCount = 0
    var oCount = 0
    for char in text {
        guard let count = countChar[char] else {
            continue
        }
        if char == "o" {
            oCount += 1
            if oCount == 2 {
                countChar[char] = count + 1
                oCount = 0
            }
        } else if char == "l" {
            lCount += 1
            if lCount == 2 {
                countChar[char] = count + 1
                lCount = 0
            }
        } else {
            countChar[char] = count + 1
        }
    }
    
    return countChar.values.min() ?? -1
}

import XCTest
class Tests: XCTestCase {
    func testMaxNumberOfBalloons() {
        XCTAssertEqual(maxNumberOfBalloons("loonbalxballpoon"), 2)
        XCTAssertEqual(maxNumberOfBalloons("leetcode"), 0)
    }
}

runTests(Tests())
