/*:
 # Overview
 */

/*:
 # Code
 */
func minimumPasses(m: Int, w: Int, p: Int, n: Int) -> Int {
    var machines = Double(m)
    var workers = Double(w)
    let cost = Double(p)
    let goal = Double(n)
    var minimumPasses = Double.greatestFiniteMagnitude
    var production = Double(0)
    var productionPasses: Double = 0

    guard machines * workers < goal else {
        return 1
    }

    while (true) {
        let remainingProduction = goal - production
        let currentOutput = machines * workers
        let remainingPasses = floor(remainingProduction / currentOutput) +
            (remainingProduction.truncatingRemainder(dividingBy: currentOutput) == 0 ? 0 : 1)
        minimumPasses = min(minimumPasses, productionPasses + remainingPasses)

        if remainingPasses == 1 {
            break
        }

        if (production < cost) {
            let tempProduction = cost - production
            let tempPasses = floor(tempProduction / currentOutput) +
                (tempProduction.truncatingRemainder(dividingBy: currentOutput) == 0 ? 0 : 1)
            productionPasses += tempPasses
            production += tempPasses * machines * workers
            print(production)

            if (production >= goal) {
                minimumPasses = min(minimumPasses, productionPasses)
                break
            }
        }

        production -= cost
        if machines <= workers {
            machines += 1
        } else {
            workers += 1
        }
    }

    return Int(minimumPasses)
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testMinimumPasses() {
        XCTAssertEqual(minimumPasses(m: 3, w: 1, p: 2, n: 12), 3)
        XCTAssertEqual(minimumPasses(m: 1, w: 2, p: 1, n: 60), 4)
        XCTAssertEqual(minimumPasses(m: 1, w: 1, p: 6, n: 45), 16)
        XCTAssertEqual(minimumPasses(m: 5184889632, w: 5184889632, p: 20, n: 10000), 1)
        XCTAssertEqual(minimumPasses(m: 1, w: 100, p: 10000000000, n: 1000000000000), 617737754)
    }
}

runTests(Tests())
