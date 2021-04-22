/*:
 # Overview
 */

/*:
 # Code
 */

func activityNotifications(expenditure: [Int], lookback days: Int) -> Int {
    return 0
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
             outputBuilder: { lines in
                return (Int(lines[0])!)
             }) { (input, expectedResult) in
    print("foo")
    print(input)
    print(expectedResult)
    return activityNotifications(expenditure: input.0, lookback: input.1)
}
