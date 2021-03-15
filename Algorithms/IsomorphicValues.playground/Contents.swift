/*:
 # Overview
 Write a function that accepts two values and returns true if they are isomorphic. That is, each part of the value must map to precisely one other, but that might be itself.

 Tip: Strings A and B are considered isomorphic if you can replace all instances of each letter with another. For example, “tort” and “pump” are isomorphic, because you can replace both Ts with a P, the O with a U, and the R with an M. For integers you compare individual digits, so 1231 and 4564 are isomorphic numbers. For arrays you compare elements, so [1, 2, 1] and [4, 8, 4] are isomorphic.
 */

/*:
 # Code
 */

func areIsomorphoic<T: CustomStringConvertible>(_ rhs: T, _ lhs: T) -> Bool {
    let rhsDescription = rhs.description
    let lhsDesciprtion = lhs.description

    guard rhsDescription.count == lhsDesciprtion.count else { return false }

    var tupleMap = [Character: Character]()
    var uniqueMap = Set<Character>()
    let zipValues = zip(rhsDescription, lhsDesciprtion)

    for (key, value) in zipValues {
        if let currentMap = tupleMap[key] {
            guard currentMap == value else { return false }
        } else {
            guard !uniqueMap.contains(value) else { return false }
            tupleMap[key] = value
            uniqueMap.insert(value)
        }
    }
    return true
}

/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testAreIsomorphic() {
        XCTAssertTrue(areIsomorphoic("clap", "slap"))
        XCTAssertTrue(areIsomorphoic("run", "mud"))
        XCTAssertTrue(areIsomorphoic("pip", "did"))
        XCTAssertTrue(areIsomorphoic("carry", "baddy"))
        XCTAssertTrue(areIsomorphoic("cream", "lapse"))
        XCTAssertTrue(areIsomorphoic(123123, 456456))
        XCTAssertTrue(areIsomorphoic(3.14159, 2.03048))
        XCTAssertTrue(areIsomorphoic([1,2,1,2,3], [4,5,4,5,6]))
        XCTAssertFalse(areIsomorphoic([1,2,1,2,3], [40,50,40,50,60]))
        XCTAssertFalse(areIsomorphoic("carry","daddy"))
        XCTAssertFalse(areIsomorphoic("did","cad"))
        XCTAssertFalse(areIsomorphoic("maim","same"))
        XCTAssertFalse(areIsomorphoic("curry","flurry"))
        XCTAssertFalse(areIsomorphoic(112233,112211))
    }
}

runTests(Tests())
