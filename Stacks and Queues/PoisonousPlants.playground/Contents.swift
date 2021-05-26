/*:
 # Overview
 */

/*:
 # Code
 */

func poisonousPlants(p: [Int]) -> Int {

    var plants = p
    guard let firstPlant = plants.first else {
        return 0
    }
    plants.removeFirst()

    var lastLevel = 0
    var plantsQueue = [firstPlant]

    for plant in plants {
        print(plantsQueue)
        var comparisonLevel = lastLevel
        while comparisonLevel >= 0 {
            let plantComparison = plantsQueue[comparisonLevel]
            if plant > plantComparison {
                let newIndex = lastLevel - comparisonLevel + 1
                if (0..<plantsQueue.count).contains(newIndex) {
                    plantsQueue[newIndex] = plant
                } else {
                    plantsQueue.append(plant)
                }
                print(lastLevel, comparisonLevel)
                if newIndex < plantsQueue.count - 1 {
                    lastLevel = plantsQueue.count - 1
                } else {
                    lastLevel = newIndex
                }
                break
            }
            comparisonLevel -= 1
        }
        if comparisonLevel == -1 {
            plantsQueue[0] = plant
            lastLevel = 0
        }
    }

    return plantsQueue.count - 1
}

func poisonousPlants1(p: [Int]) -> Int {

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
//        XCTAssertEqual(poisonousPlants(p: [1,1,1,1,1,1,1]), 0)
//        XCTAssertEqual(poisonousPlants(p: [3,6,2,7,5]), 2)
//        XCTAssertEqual(poisonousPlants(p: [6,5,8,4,7,10,9]), 2)
//        XCTAssertEqual(poisonousPlants(p: [3,7,1,2,4,8,2,7,10]), 2)
//        XCTAssertEqual(poisonousPlants(p: [4,3,7,5,6,4,2]), 3)
//        XCTAssertEqual(poisonousPlants(p: [3,1,10,7,3,5,6,6]), 3)
        XCTAssertEqual(poisonousPlants(p: [11,7,19,6,12,12,8,8,7,1,10,15,5,12]), 5)
    }
}

runTests(Tests())
