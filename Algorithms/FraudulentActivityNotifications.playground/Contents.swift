/*:
 # Overview
 */

/*:
 # Code
 */

func activityNotifications(expenditure: [Int], d: Int) -> Int {
    var valueCounter = Array(repeating: 0, count: 201)

    let lowerMedianCount: Int
    let upperMedianCount: Int?
    if d % 2 == 0 {
        lowerMedianCount = d / 2
        upperMedianCount = lowerMedianCount + 1
    } else {
        lowerMedianCount = (d / 2) + 1
        upperMedianCount = nil
    }

    var alerts = 0
    for (index, value) in expenditure.enumerated() {
        if index >= d {
            var median: Double = 0.0
            if let upperMedianCount = upperMedianCount {
                // Median equal average of two center elements
                var lowerMedianCountAcc = 0
                var lowerMedianValue = 0
                var upperMedianCountAcc = 0
                var upperMedianValue = 0
                for (value, valueCount) in valueCounter.enumerated() {
                    if lowerMedianCountAcc < lowerMedianCount {
                        lowerMedianValue = value
                        lowerMedianCountAcc += valueCount
                    }
                    if upperMedianCountAcc < upperMedianCount {
                        upperMedianValue = value
                        upperMedianCountAcc += valueCount
                    }

                    if lowerMedianCountAcc >= lowerMedianCount && upperMedianCountAcc >= upperMedianCount {
                        break
                    }
                }
                median = Double(lowerMedianValue + upperMedianValue) / 2.0
            } else {
                // Median equal to center element
                var medianCountAcc = 0
                var medianValue = 0
                for (value, valueCount) in valueCounter.enumerated() {
                    if medianCountAcc < lowerMedianCount {
                        medianValue = value
                        medianCountAcc += valueCount
                    } else {
                        break
                    }
                }
                median = Double(medianValue)
            }
            alerts += Double(value) >= 2.0 * median ? 1 : 0
            valueCounter[expenditure[index-d]] -= 1
        }
        valueCounter[value] += 1
    }
    return alerts
}

final class LinkedListNode<T: CustomStringConvertible> {
    let element: T
    var nextNode: LinkedListNode<T>? = nil

    init(_ element: T) {
        self.element = element
    }
}

extension LinkedListNode: CustomStringConvertible {
    var description: String {
        if let nextNode = self.nextNode {
            return element.description + " " + nextNode.description
        } else {
            return element.description
        }
    }
}

final class LinkedList<T: CustomStringConvertible> {
    var head: LinkedListNode<T>? = nil
    var tail: LinkedListNode<T>? = nil
    var count: Int = 0

    init() {}

    func append(_ value: T) {
        defer {
            count += 1
        }

        let newNode = LinkedListNode(value)

        guard head != nil, tail != nil else {
            head = newNode
            tail = newNode
            return
        }
        tail?.nextNode = newNode
        tail = newNode

    }

    func removeFirst() -> T? {
        defer {
            count = max(0, count - 1)
        }
        if tail === head {
            tail = nil
        }

        let firstValue = head?.element
        head = head?.nextNode
        return firstValue
    }
}

struct MedianCalculator {

    private let valueRange: ClosedRange<Int>
    private let medianSize: Int
    private var valueHistory = LinkedList<Int>()
    private var valueOccurenceCount: [Int]

    init(valueRange: ClosedRange<Int>, medianSize: Int) {
        self.valueRange = valueRange
        self.medianSize = medianSize
        self.valueOccurenceCount = Array(repeating: 0, count: valueRange.count)
    }

    mutating func median(_ value: Int) -> Double? {
        precondition(valueRange.contains(value), "Value must be inside the value range specified at initialization")

        let median = _median

        if valueHistory.count >= medianSize {
            if let value = valueHistory.removeFirst() {
                valueOccurenceCount[value] -= 1
            }
        }
        valueHistory.append(value)
        valueOccurenceCount[value] += 1

        return median
    }

    private var _median: Double? {
        return medianSize % 2 == 0 ? _evenMedianSize : _oddMedianSize
    }

    private var _evenMedianSize: Double? {
        guard valueHistory.count >= medianSize else {
            return nil
        }

        let lowerMedianPoint = medianSize / 2
        let upperMedianPoint = lowerMedianPoint + 1

        var lowerValueCountAccumulator = 0
        var lowerMedianValue = 0
        var upperValueCountAccumulator = 0
        var upperMedianValue = 0

        for (value, valueCount) in valueOccurenceCount.enumerated() {
            if lowerValueCountAccumulator < lowerMedianPoint {
                lowerMedianValue = value
                lowerValueCountAccumulator += valueCount
            }
            if upperValueCountAccumulator < upperMedianPoint {
                upperMedianValue = value
                upperValueCountAccumulator += valueCount
            }

            if lowerValueCountAccumulator >= lowerMedianPoint &&
               upperValueCountAccumulator >= upperMedianPoint {
                break
            }
        }
        return Double(lowerMedianValue + upperMedianValue) / 2.0
    }

    private var _oddMedianSize: Double? {
        guard valueHistory.count >= medianSize else {
            return nil
        }

        let medianMidPoint = (medianSize / 2) + 1
        var valueCountAccumulator = 0
        var median = 0
        for (value, valueCount) in valueOccurenceCount.enumerated() {
            if valueCountAccumulator < medianMidPoint {
                median = value
                valueCountAccumulator += valueCount
            } else {
                break
            }
        }
        return Double(median)
    }
}

func activityNotifications2(expenditure: [Int], d: Int) -> Int {
    var medianCalculator = MedianCalculator(valueRange: 0 ... 200, medianSize: d)

    return expenditure.reduce(0) { alertAccumulator, expense in
        guard let median = medianCalculator.median(expense) else {
            return alertAccumulator
        }
        return Double(expense) >= (2 * median) ? alertAccumulator + 1 : alertAccumulator
    }
}

/*:
 # Tests
 */


runTestCases(inputOffset: 2,
             inputBuilder: { lines -> ([Int], Int) in
                let lookback: Int = Int(lines[0].components(separatedBy: .whitespaces).last!)!
                let expediture: [Int] = lines[1].components(separatedBy: .whitespaces).map { Int($0)! }
                return (expediture, lookback)
             }, outputOffset: 1,
             outputBuilder: { lines -> Int in
                return (Int(lines[0])!)
             }) { (input, expectedResult) in
    return activityNotifications2(expenditure: input.0, d: input.1)
}
