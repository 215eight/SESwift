/*:
 # Overview
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func jumpOnClouds(count: Int, clouds: [Int]) -> Int {
    var index = 0
    var jumpCount = 0
    while index < clouds.count {
        let twoJumps = index + 2
        let oneJump = index + 1

        if twoJumps < clouds.count && clouds[twoJumps] == 0 {
            jumpCount += 1
            index = twoJumps
        } else if oneJump < clouds.count && clouds[oneJump] == 0 {
            jumpCount += 1
            index = oneJump
        } else {
            index += 1
        }
    }
    return jumpCount
}

runTestCases(inputOffset: 2,
             inputBuilder: { lines -> (count: Int, clouds: [Int]) in
                let count = Int(lines[0])!
                let clouds = lines[1].components(separatedBy: .whitespaces)
                    .map { Int($0)! }
                return (count: count, clouds: clouds)
             },
             outputOffset: 1,
             outputBuilder: { lines in
                Int(lines[0])!
             }) { (input, output) in
    jumpOnClouds(count: input.count, clouds: input.clouds)
}

