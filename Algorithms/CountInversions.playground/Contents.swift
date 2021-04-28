/*:
 # Overview
 */

func merge<T: Comparable>(array: inout [T], sortedArray: inout [T], lhs: Range<Int>, rhs: Range<Int>) -> Int {
    var inversions = 0
    var index = lhs.lowerBound
    var lhsIndex = lhs.lowerBound
    var rhsIndex = rhs.lowerBound

    while lhs.contains(lhsIndex), rhs.contains(rhsIndex) {
        if array[lhsIndex] <= array[rhsIndex] {
            sortedArray[index] = array[lhsIndex]
            lhsIndex += 1
        } else {
            sortedArray[index] = array[rhsIndex]
            inversions += (lhs.upperBound - lhsIndex)
            rhsIndex += 1
        }
        index += 1
    }

    while lhs.contains(lhsIndex) {
        sortedArray[index] = array[lhsIndex]
        lhsIndex += 1
        index += 1
    }

    while rhsIndex < rhs.count {
        sortedArray[index] = array[rhsIndex]
        rhsIndex += 1
        index += 1
    }

    for i in lhs.lowerBound ..< rhs.upperBound {
        array[i] = sortedArray[i]
    }

    return inversions
}

func mergeSort<T: Comparable>(_ array: inout [T], range: Range<Int>, sortedArray: inout [T], inversions: Int) -> Int {
    guard range.count > 1 else {
        return inversions
    }
    let midPoint = range.count / 2
    let leftRange = (range.lowerBound ..< range.lowerBound + midPoint)
    let rightRange = (range.lowerBound + midPoint ..< range.upperBound)
    let lefttHalf = mergeSort(&array, range: leftRange, sortedArray: &sortedArray, inversions: inversions)
    let rightHalf = mergeSort(&array, range: rightRange, sortedArray: &sortedArray, inversions: inversions)
    let result = merge(array: &array, sortedArray: &sortedArray, lhs: leftRange, rhs: rightRange)
    return (lefttHalf + rightHalf + result)
}

func mergeSort<T: Comparable>(_ array: [T]) -> (sorted: [T], inversions: Int) {
    var array = array
    var sortedArray = array
    let inversions = mergeSort(&array, range: (0 ..< array.count), sortedArray: &sortedArray, inversions: 0)
    return (sortedArray, inversions)
}

runTestCases(inputOffset: 2, inputBuilder: { lines -> [Int] in
    let line = lines[1]
    return line
        .components(separatedBy: .whitespaces)
        .map { Int($0)! }
}, outputOffset: 1,
outputBuilder: { lines in
    return Int(lines[0])!
}) { (input, output) in
    return mergeSort(input).inversions
}

func merge(_ array: inout [Int], sortedArray: inout [Int], lhs: Range<Int>, rhs: Range<Int>) -> Int {
    var inversions = 0
    var index = lhs.lowerBound
    var lhsIndex = lhs.lowerBound
    var rhsIndex = rhs.lowerBound

    while lhs.contains(lhsIndex), rhs.contains(rhsIndex) {
        let lhsValue = array[lhsIndex]
        let rhsValue = array[rhsIndex]

        if lhsValue <= rhsValue {
            sortedArray[index] =  lhsValue
            lhsIndex += 1
        } else {
            inversions += lhs.upperBound - lhsIndex
            sortedArray[index] = rhsValue
            rhsIndex += 1
        }
        index += 1
    }

    while lhs.contains(lhsIndex) {
        sortedArray[index] = array[lhsIndex]
        lhsIndex += 1
        index += 1
    }

    while rhs.contains(rhsIndex) {
        sortedArray[index] = array[rhsIndex]
        rhsIndex += 1
        index += 1
    }

    for i in lhs.lowerBound ..< rhs.upperBound {
        array[i] = sortedArray[i]
    }

    return inversions
}

func mergeSort2(_ array: [Int]) -> ([Int], Int) {
    var inversions = 0
    var array = array
    var sortedArray = array
    var subArrayLength = 1
    while subArrayLength < array.count {
        var subArrayIndex = 0
        while subArrayIndex < array.count {
            let lhsLower = subArrayIndex
            let lhsUpper = lhsLower + subArrayLength
            let lhs = (lhsLower ..< lhsUpper)

            let rhsLower = subArrayIndex + subArrayLength
            var rhsUpper = rhsLower + subArrayLength
            if rhsLower >= array.count {
                break
            }
            if rhsUpper > array.count {
                rhsUpper = array.count
            }
            let rhs = (rhsLower ..< rhsUpper)

            let subInversions = merge(&array, sortedArray: &sortedArray, lhs: lhs, rhs: rhs)
            inversions += subInversions
            subArrayIndex = subArrayIndex + 2 * subArrayLength
        }
        subArrayLength *= 2
    }
    return (sortedArray, inversions)
}


runTestCases(inputOffset: 2, inputBuilder: { lines -> [Int] in
    let line = lines[1]
    return line
        .components(separatedBy: .whitespaces)
        .map { Int($0)! }
}, outputOffset: 1,
outputBuilder: { lines in
    return Int(lines[0])!
}) { (input, output) in
    return mergeSort2(input).1
}
