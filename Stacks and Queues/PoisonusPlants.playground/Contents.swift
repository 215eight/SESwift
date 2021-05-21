/*:
 # Overview
 */

/*:
 # Code
 */

func poisonousPlants(p: [Int]) -> Int {
    let plants = p

    typealias Plants = [Int]
    typealias DeathPlantsQueue = [Int]
    typealias MaxDays = Int

    typealias Result = (plants: Plants, queue: DeathPlantsQueue, days: MaxDays)
    let initialResult = (plants: Plants(), queue: DeathPlantsQueue(), days: 0)
    let result = plants.reduce(initialResult) { tempResult, plant in
        var result: Result
        defer {
            print(result)
        }
        guard let lastPlant = tempResult.plants.last else {
            result = ([plant],tempResult.queue, tempResult.days)
            return result
        }
        if lastPlant >= plant {
            let dayCount = tempResult.queue.count > tempResult.days ? tempResult.queue.count : tempResult.days
            result = (tempResult.plants + [plant], [], dayCount)
            return result
        } else {
            var updatedQueue = tempResult.queue
            var maxDays = tempResult.days
            if let last = updatedQueue.last,
               last < plant {
                maxDays = updatedQueue.count > tempResult.days ? updatedQueue.count : tempResult.days
                updatedQueue = [plant]
            } else {
                updatedQueue += [plant]
            }
            result = (tempResult.plants, updatedQueue, maxDays)
            return result
        }
    }
    return result.queue.count > result.days ? result.queue.count : result.days
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
        XCTAssertEqual(poisonousPlants(p: [3,1,10,7,3,5,6,6]), 3)
    }
}

runTests(Tests())
