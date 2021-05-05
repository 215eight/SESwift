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
    var count = Double(0)
    var passes = 0

    while count < goal {
        defer {
            let production = machines * workers
            if production <= cost {
                let tempPasses = Int(cost / production)
                passes += tempPasses
                count += Double(tempPasses) * production
            } else {
                passes += 1
                count += production
            }
            print("m: \(machines)\t", "w: \(workers)\t", "$: \(cost)\t", "c: \(count)\t", "g: \(goal)\t", "p: \(passes)")
        }

        guard (machines * workers) + count < goal else {
            break
        }

        let investment = floor(count / cost)
        if investment >= 1.0 {
            let delta = abs(machines - workers)
            let equalizerInvestment = delta == 0 ? 0 : min(investment, delta)
            let remainderInvestment = max(0, investment - equalizerInvestment)
            let maxRemainderInvestment = floor(remainderInvestment / 2.0) + remainderInvestment.truncatingRemainder(dividingBy: 2.0)
            let minRemainderInvestment = floor(remainderInvestment / 2.0)

            if machines < workers {
                machines += equalizerInvestment + maxRemainderInvestment
                workers += minRemainderInvestment
            } else {
                workers += equalizerInvestment + maxRemainderInvestment
                machines += minRemainderInvestment
            }
            count -= investment * cost
        }
    }
    return passes
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
