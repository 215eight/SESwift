/*:
 # Overview
 Write a function that accepts an array of CGPoint pairs, and returns an array of the angles
 between each point pair. Return the angles in degrees, where 0 or 360 is straight up.
 Tip: If it helps your thought process, imagine each point pair as being two touches on the screen: you have the a touch and the b, what is the angle between them?
 */

/*:
 # Code
 */

func pointsToAngles(_ points: [(a: CGPoint, b: CGPoint)]) -> [Double] {
    return points.map { pointsToAngle($0) }
}

func pointsToAngle(_ point: (a: CGPoint, b: CGPoint)) -> Double {
    let opposite = (point.b.y - point.a.y)
    let adjacent = (point.b.x - point.a.x)

    let radians = atan2(abs(opposite), abs(adjacent))
    var degrees = (Double(radians) * 180) / Double.pi

    switch (opposite, adjacent) {
    case _ where opposite > 0 && adjacent > 0:
        degrees = 90 + degrees
    case _ where opposite > 0 && adjacent < 0:
        print("foo")
        degrees = 270 - degrees
    case _ where opposite > 0 && adjacent == 0:
        degrees = 180
    case _ where opposite < 0 && adjacent > 0:
        degrees = 90 - degrees
    case _ where opposite < 0 && adjacent < 0:
        degrees = 270 + degrees
    case _ where opposite < 0 && adjacent == 0:
        degrees = 0
    case _ where opposite == 0 && adjacent > 0:
        degrees = 90
    case _ where opposite == 0 && adjacent < 0:
        degrees = 270
    case _ where opposite == 0 && adjacent == 0:
        degrees = 0
    default:
        break
    }
    return degrees
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testPointsToAngles() {
        var points = [(a: CGPoint, b: CGPoint)]()
        points.append((a: CGPoint.zero, b: CGPoint(x: 0, y:
        -100)))
        points.append((a: CGPoint.zero, b: CGPoint(x: 100, y:
        -100)))
        points.append((a: CGPoint.zero, b: CGPoint(x: 100, y:
        0)))
        points.append((a: CGPoint.zero, b: CGPoint(x: 100, y:
        100)))
        points.append((a: CGPoint.zero, b: CGPoint(x: 0, y:
        100)))
        points.append((a: CGPoint.zero, b: CGPoint(x: -100, y:
        100)))
        points.append((a: CGPoint.zero, b: CGPoint(x: -100, y:
        0)))
        points.append((a: CGPoint.zero, b: CGPoint(x: -100, y:
        -100)))
        XCTAssertEqual(pointsToAngles(points),
                       [0.0, 45.0, 90.0, 135.0, 180.0, 225.0, 270.0, 315.0])
    }
}

runTests(Tests())
