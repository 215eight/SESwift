/*:
 # Overview
 ![Problem Statement](RepeatedString.png)
 */

/*:
 # Code
 ˆ
 */
import XCTest

func countAs(s: String, n: Int) -> Int {
    let count = s.count - s.replacingOccurrences(of: "a", with: "").count
    let quotientCount = n / s.count * count
    let remainderS = String(Array(s)[0..<n % s.count])
    let remainderCount = remainderS.count - remainderS.replacingOccurrences(of: "a", with: "").count
    return quotientCount + remainderCount
}

/*:
 # Tests
 */

runTestCases(inputOffset: 2,
             inputBuilder: { input in
                (s: input[0], n: Int(input[1])!)
             }, outputOffset: 1,
             outputBuilder: { output in
                Int(output[0])!
             }) { (input, output) in
    let result = countAs(s: input.s, n: input.n)
    if result != output {
        print("Input: \(input)")
        print("Output: \(output)")
        assertionFailure("\(result) not equal to \(output)")
    }
}
