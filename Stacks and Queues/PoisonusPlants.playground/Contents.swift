/*:
 # Overview
 */

/*:
 # Code
 */

func poisonousPlants(p: [Int]) -> Int {

    func filter(plants: [Int], count: Int) -> (plants: [Int], count: Int) {
        guard plants.count > 1 else {
            return (plants, count)
        }
        var runner: Int?
        let result = plants.filter {
            guard let _runner = runner else {
                runner = plants.first
                return true
            }
            let result = _runner >= $0
            runner = $0
            return result
        }
        if result.count == plants.count {
            return (plants, count)
        } else {
            return filter(plants: result, count: count + 1)
        }
    }

    return filter(plants: p, count: 0).count
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testPoisonousPlants() {
        XCTAssertEqual(poisonousPlants(p: [1,1,1,1,1,1,1]), 0)
        XCTAssertEqual(poisonousPlants(p: [3,6,2,7,5]), 2)
        XCTAssertEqual(poisonousPlants(p: [6,5,8,4,7,10,9]), 2)
        XCTAssertEqual(poisonousPlants(p: [3,7,1,2,4,8,2,7,10]), 2)
        XCTAssertEqual(poisonousPlants(p: [4,3,7,5,6,4,2]), 3)
//        4 3 7 5 6 4 2
//        4 3 5 4 2
//        4 3 4 2
//        4 3 2
        XCTAssertEqual(poisonousPlants(p: [3,1,10,7,3,5,6,6]), 3)
//        3,1,10,7,3,5,6,6
//        3,1,7,3,6,6
//        3,1,3,6
//        3,1
    }
}

runTests(Tests())
