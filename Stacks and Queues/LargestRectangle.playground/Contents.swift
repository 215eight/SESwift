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
        var optionalHeightIndex: Int? = nil
        while let lastHeight = heightValues.last,
              let lastHeightIndex = heightIndexes.last,
              lastHeight > height {
            let lastWidth = index - lastHeightIndex
            let area = lastHeight * lastWidth
            maxArea = max(maxArea, area)
            optionalHeightIndex = heightIndexes.last
            heightValues.removeLast()
            heightIndexes.removeLast()
        }

        if let lastHeight = heightValues.last {
           if lastHeight < height {
            heightValues.append(height)
            heightIndexes.append(min(optionalHeightIndex ?? index, index))
           }
        } else {
            heightValues.append(height)
            heightIndexes.append(optionalHeightIndex ?? index)
        }
    }
    return maxArea
}

func largestRectangle2(h: [Int]) -> Int {
    var maxArea = 0
    for index in (0 ..< h.count) {
        var minHeight: Int? = nil
        for jIndex in (index ..< h.count) {
            let height = h[jIndex]
            minHeight = min(minHeight ?? height, height)
            let width = jIndex - index + 1
            maxArea = max(maxArea, (minHeight ?? 0) * width)
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
        XCTAssertEqual(largestRectangle(h: [2,2,1,3,4,1,2]), 7)
        XCTAssertEqual(largestRectangle2(h: [1,2,3,4,5]), 9)
        XCTAssertEqual(largestRectangle2(h: [2,2,1,1,1]), 5)
        XCTAssertEqual(largestRectangle2(h: [2,2,1,3,4,1,2]), 7)
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
