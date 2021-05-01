/*:
 # Overview
 */

/*:
 # Code
 */


func largestRectangle(h: [Int]) -> Int {
    var heightIndexes = [Int]()
    var heightValues = [Int]()
    var h = h
    h.append(0)

    var maxArea = 0
    for (index, height) in h.enumerated() {
        guard let lastHeight = heightValues.last else {
            heightIndexes.append(index)
            heightValues.append(height)
            continue
        }

        if height == lastHeight {
            continue
        } else if height > lastHeight {
            heightValues.append(height)
            heightIndexes.append(index)
            continue
        } else {
            while let lastHeight = heightValues.last,
                  let lastHeightIndex = heightIndexes.last,
                    height < lastHeight {
                let area = lastHeight * (index - lastHeightIndex)
                if area > maxArea {
                    maxArea = area
                }
                heightValues.removeLast()
                heightIndexes.removeLast()
            }
            let heightIndex = heightIndexes.last ?? 0
            heightIndexes.append(heightIndex)
            heightValues.append(height)
        }
    }
    return maxArea
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testLargestRectangle() {
        XCTAssertEqual(largestRectangle(h: [1,2,3,4,5]), 9)
        XCTAssertEqual(largestRectangle(h: [2,2,1,1,1]), 5)
    }
}

runTests(Tests())

runTestCases(inputOffset: 2,
             inputBuilder: { lines -> [Int] in
                return lines[1]
                    .components(separatedBy: .whitespaces)
                    .map { Int($0)! }
             },
             outputOffset: 1,
             outputBuilder: { lines -> Int in
                return Int(lines[0])!
             }) { (input, _) in
    return largestRectangle(h: input)
}
