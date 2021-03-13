import Foundation
import XCTest

class TestObserver: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        let message = """

        ############
        \(description)
        File: \(filePath ?? "Unknown")
        Line: \(lineNumber)
        ############
        """
        assertionFailure(message)
    }
}

public func runTests<T: XCTestCase>(_ testSuite: T) {
    let testObserver = TestObserver()
    XCTestObservationCenter.shared.addTestObserver(testObserver)
    type(of: testSuite).defaultTestSuite.run()
}
