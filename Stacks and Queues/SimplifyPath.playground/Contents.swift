/*:
 # Overview
 Given a string path, which is an absolute path (starting with a slash '/') to a file or directory in a Unix-style file system, convert it to the simplified canonical path.

 In a Unix-style file system, a period '.' refers to the current directory, a double period '..' refers to the directory up a level, and any multiple consecutive slashes (i.e. '//') are treated as a single slash '/'. For this problem, any other format of periods such as '...' are treated as file/directory names.

 The canonical path should have the following format:

 The path starts with a single slash '/'.
 Any two directories are separated by a single slash '/'.
 The path does not end with a trailing '/'.
 The path only contains the directories on the path from the root directory to the target file or directory (i.e., no period '.' or double period '..')
 Return the simplified canonical path.



 Example 1:

 Input: path = "/home/"
 Output: "/home"
 Explanation: Note that there is no trailing slash after the last directory name.

 Example 2:
 Input: path = "/../"
 Output: "/"
 Explanation: Going one level up from the root directory is a no-op, as the root level is the highest level you can go.

 Example 3:
 Input: path = "/home//foo/"
 Output: "/home/foo"
 Explanation: In the canonical path, multiple consecutive slashes are replaced by a single one.


 Constraints:

 1 <= path.length <= 3000
 path consists of English letters, digits, period '.', slash '/' or '_'.
 path is a valid absolute Unix path.
 */

/*:
 # Code
 */

/*:
 # Tests
 */

func simplifyPath(_ path: String) -> String {

    func update(components: inout [String], subComponent: String) -> [String] {
        if subComponent.count > 2 {
            components.append(subComponent)
            return components
        } else {
            if subComponent == ".." {
                if components.count > 0 {
                    components.removeLast()
                }
                return components
            } else if subComponent == "." {
                return components
            } else if subComponent.count > 0 {
                components.append(subComponent)
                return components
            } else {
                return components
            }
        }
    }

    var components = [String]()
    var subComponent = ""
    for char in path {
        if char == "/" {
            update(components: &components, subComponent: subComponent)
            subComponent = ""
        } else {
            subComponent.append(char)
        }
    }

    if subComponent.count > 0 {
        update(components: &components, subComponent: subComponent)
    }

    if let last = components.last {
        components.removeLast()
        update(components: &components, subComponent: last)
        return "/" + String(components.joined(separator: "/"))
    } else {
        return  "/"
    }
}

func simplifyPath2(_ path: String) -> String {
    var components = [String.SubSequence("")] + path.split(separator:"/") + [String.SubSequence("")]
    var result = [String.SubSequence]()
    for component in components {
        guard component.count > 0 else {
            continue
        }
        switch component {
        case ".":
            continue
        case "..":
            if result.count > 0 {
                result.removeLast()
            }
        default:
            result.append(component)
        }
    }

    return "/" + result.joined(separator: "/")
}

import XCTest
class Tests: XCTestCase {
    func testSimplifyPath() {
        XCTAssertEqual(simplifyPath("/home/"), "/home")
        XCTAssertEqual(simplifyPath("/../"), "/")
        XCTAssertEqual(simplifyPath("/home//foo"), "/home/foo")
        XCTAssertEqual(simplifyPath("/home//foo/"), "/home/foo")
        XCTAssertEqual(simplifyPath("/home//foo/."), "/home/foo")
        XCTAssertEqual(simplifyPath("/home//foo/../"), "/home")
        XCTAssertEqual(simplifyPath("/home//foo.././"), "/home/foo..")
        XCTAssertEqual(simplifyPath("/home//..foo/./"), "/home/..foo")
    }
    func testSimplifyPath2() {
        XCTAssertEqual(simplifyPath2("/home/"), "/home")
        XCTAssertEqual(simplifyPath2("/../"), "/")
        XCTAssertEqual(simplifyPath2("/home//foo"), "/home/foo")
        XCTAssertEqual(simplifyPath2("/home//foo/"), "/home/foo")
        XCTAssertEqual(simplifyPath2("/home//foo/."), "/home/foo")
        XCTAssertEqual(simplifyPath2("/home//foo/../"), "/home")
        XCTAssertEqual(simplifyPath2("/home//foo.././"), "/home/foo..")
        XCTAssertEqual(simplifyPath2("/home//..foo/./"), "/home/..foo")
    }
}


runTests(Tests())
