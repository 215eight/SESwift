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
    return activityNotifications(expenditure: input.0, d: input.1)
}
