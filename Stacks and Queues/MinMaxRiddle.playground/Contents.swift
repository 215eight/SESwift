/*:
 # Overview
 */

/*:
 # Code
 */

typealias Index = Int


func findWindows(in arr: [Int]) -> (start: [Int], end: [Int]) {

    typealias Tuple = (index: Index, value: Int)

    var previousSmallerStack = [Tuple]()
    var pendingWindows = [Tuple]()

    var start = Array<Int>(repeating: -1, count: arr.count)
    var end = Array<Int>(repeating: -1, count: arr.count)

    for (index, value) in arr.enumerated() {
        // The previousSmallerStack contains a list of values
        // sorted in incremental order that are smaller than
        // the current value
        // Iterate over this list to either add the current value
        // or remove all the values that are greater
        var optionalStartIndex: Int? = nil
        while let previousSmaller = previousSmallerStack.last {
            if previousSmaller.value < value {
                optionalStartIndex = previousSmaller.index
                break
            }
            previousSmallerStack.removeLast()
        }

        // The last element in the previousSmallerStack will
        // determine the start index of a window.
        // If the list is empty then the starting index is
        // equal to -1
        let startIndex: Int = optionalStartIndex ?? -1

        // Save the start index for item at index
        start[index] = startIndex

        previousSmallerStack.append(Tuple(index: index, value: value))

        // Try to find the end index of any windows that don't have one
        // by comparing it to the current value
        while let pendingWindow = pendingWindows.last {
            if value < pendingWindow.value {
                end[pendingWindow.index] = index
                pendingWindows.removeLast()
            } else {
                break
            }
        }

        pendingWindows.append(Tuple(index: index, value: value))
    }

    // For any pending windows still left then use the size of
    // the array as end index
    while let pendingWindow = pendingWindows.last {
        end[pendingWindow.index] = arr.count
        pendingWindows.removeLast()
    }
    return (start: start, end: end)
}

func riddle(arr: [Int]) -> [Int] {

    let windows = findWindows(in: arr)
    let windowSizes = zip(windows.start, windows.end)
        .map { start, end in
            end - start - 1
        }

    var maxMinWindow = Array(repeating: 0, count: arr.count + 1)
    for (index, windowSize) in windowSizes.enumerated() {
        maxMinWindow[windowSize] = max(maxMinWindow[windowSize], arr[index])
    }


    //  If ans[i] is not filled it means there is no direct element
    // which is minimum of length i and therefore either the element
    // of length ans[i+1], or ans[i+2], and so on is same as ans[i]
    for index in (1 ..< maxMinWindow.count).reversed() {
        maxMinWindow[index-1] = max(maxMinWindow[index], maxMinWindow[index-1])
    }

    // Remove window of size 0
    maxMinWindow.removeFirst()
    return maxMinWindow
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testWindows() {
        var windows = findWindows(in: [10,20,30,50,10,70,30])
        XCTAssertEqual(windows.start, [-1, 0, 1, 2, -1, 4, 4])
        XCTAssertEqual(windows.end, [7,4,4,4,7,6,7])

        windows = findWindows(in: [4,5,2,25])
        XCTAssertEqual(windows.start, [-1, 0, -1, 2])
        XCTAssertEqual(windows.end, [2, 2, 4, 4])
    }

    func testRiddle() {
        XCTAssertEqual(riddle(arr: [2,6,1,12]), [12,2,1,1])
        XCTAssertEqual(riddle(arr: [1,2,3,5,1,13,3]), [13,3,2,1,1,1,1])
        XCTAssertEqual(riddle(arr: [3,5,4,7,6,2]), [7,6,4,4,3,2])
    }
}

runTests(Tests())
