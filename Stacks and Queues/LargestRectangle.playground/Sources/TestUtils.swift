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

public func runTestCases<I, O: Equatable>(inputOffset: Int,
                                          inputBuilder: ([String]) -> I,
                                          outputOffset: Int,
                                          outputBuilder: ([String]) -> O,
                                          test: (I, O) -> O) {
    testFiles().forEach { file in
        let startDate = Date()
        print("Starting test cases in file \(file.name)")
        testCases(fileLines: (file.input, file.output),
                  inputOffset: inputOffset,
                  inputBuilder: inputBuilder,
                  outputOffset: outputOffset,
                  outputBuilder: outputBuilder,
                  test: test)
        print("Ending test cases in file \(file.name)")
        print("File test cases duration: \(Int(Date().timeIntervalSince(startDate)))s")
        print()
    }
}

fileprivate func testFiles() -> [(name: String, input: [String] , output: [String])] {
    let fileManager = FileManager.default
    let inputRoot = Bundle.main.path(forResource: "input", ofType: nil)!
    let outputRoot = Bundle.main.path(forResource: "output", ofType: nil)!
    let inputFiles = try! fileManager.contentsOfDirectory(atPath: inputRoot)
        .sorted()
    let outputFiles = try! fileManager.contentsOfDirectory(atPath: outputRoot)
        .sorted()
    let files = zip(inputFiles, outputFiles)
    return files.map { (input: String, output: String) in

        let inputFile = inputRoot + "/" + input
        let inputContent = try! String(contentsOfFile: inputFile, encoding: .utf8)
        let inputContentLines = inputContent.components(separatedBy: .newlines)

        let outputFile = outputRoot + "/" + output
        let outputContent = try! String(contentsOfFile: outputFile, encoding: .utf8)
        let outputContentLines = outputContent.components(separatedBy: .newlines)

        return (name: input,
                input: inputContentLines,
                output: outputContentLines)
    }
}

fileprivate func testCases<I, O: Equatable>(fileLines: (input: [String], output: [String]),
                                            inputOffset: Int,
                                            inputBuilder: ([String]) -> I,
                                            outputOffset: Int,
                                            outputBuilder: ([String]) -> O,
                                            test: (I, O) -> O) {
    var inputRunner = 0
    var outputRunner = 0

    while inputRunner + inputOffset <= fileLines.input.count &&
            outputRunner + outputRunner <= fileLines.output.count {

        let input = inputBuilder(Array(fileLines.input[inputRunner ..< inputRunner + inputOffset]))
        let output = outputBuilder(Array(fileLines.output[outputRunner ..< outputRunner + outputOffset]))

        let testOutput = test(input, output)
        if testOutput == output {
            print("Success: Test Case \(input) - Output: \(testOutput)")
        } else {
            print("Failure: Test Case \(input) - Expected Output \(output) - Received Output: \(testOutput)")
            assertionFailure()
        }

        inputRunner += inputOffset
        outputRunner += outputOffset
    }
}
