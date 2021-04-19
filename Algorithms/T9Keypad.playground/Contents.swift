/*:
 # Overview
  Given below digit to characters mapping as seen on a T-9 keypad:
  {
    '2': 'abc',
    '3': 'def',
    '4': 'ghi',
    '5': 'jkl',
    '6': 'mno',
    '7': 'pqrs',
    '8': 'tuv',
    '9': 'wxyz'
  }

  OR

   1    2    3
       abc  def

   4    5    6
  ghi  jkl  mno

   7    8    9
  pqrs tuv  wxyz

  Simulate an input method that takes in a sequence of digits and outputs a set of English words the digits represent

  Example:
  Input: 228
  dictionary: [cat, bat,]
  Output: [cat, bat, act]
 */

/*:
 # Code
 */

struct Dictionary {

    private var nodes = Set<Node<Character>>()

    func find(_ word: String) -> String? {
        var tempNode: Node<Character>? = nil
        for char in Array(word) {
            guard let node = tempNode else {
                if let targetNode = nodes.first(where: { $0.value == char }) {
                    tempNode = targetNode
                    continue
                } else {
                    return nil
                }
            }
            if let targetNode = node.children.first(where: { $0.value == char }) {
                tempNode = targetNode
            } else {
                return nil
            }
        }

        return tempNode?.isTail ?? false ? word : nil
    }

    mutating func insert(_ word: String) {
        var tempNode: Node<Character>? = nil
        Array(word).forEach { char in
            let newNode = Node(value: char)
            guard let node = tempNode else {
                if nodes.contains(newNode) {
                    let targetNode = nodes.first { $0.value == char }
                    tempNode = targetNode
                } else {
                    nodes.insert(newNode)
                    tempNode = newNode
                }
                return
            }
            if node.children.contains(newNode) {
                let targetNode = node.children.first { $0.value == char }
                tempNode = targetNode
            } else {
                node.children.insert(newNode)
                tempNode = newNode
            }
        }
        tempNode?.isTail = true
    }

    func print() {
        for node in nodes {
            print(node: node, prefix: "")
        }
    }

    private func print(node: Node<Character>, prefix: String) {
        let newPrefix = "\(prefix)\(node.value)"
        if node.isTail {
            Swift.print(newPrefix)
        }
        for node in node.children {
            print(node: node, prefix: newPrefix)
        }
    }
}

class Node<T: Hashable> {


    let value: T
    var isTail: Bool = false
    var children = Set<Node>()

    init(value: T) {
        self.value = value
    }
}

extension Node: Hashable {
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        lhs.value == rhs.value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

let digitsToChars = [
    "2" : "abc",
    "3" : "def",
    "4" : "ghi",
    "5" : "jkl",
    "6" : "mno",
    "7" : "pqr",
    "8" : "stu",
    "9" : "wxyz",
]

func split(_ input: String) -> [String] {
    input.components(separatedBy: "0")
        .filter { !$0.isEmpty }
}

func dial(_ input: String) -> [String] {
    Array(input).reduce([String]()) { (acc, char) in
        guard let chars = digitsToChars["\(char)"] else {
            print(char)
            return acc
        }
        guard !acc.isEmpty else {
            return chars.map { "\($0)"}
        }
        return acc.flatMap { value in
            Array(chars).map { "\(value)\($0)" }
        }
    }
}

final class TrieNode<T: Hashable> {
    let value: T
    var children = [T : TrieNode]()
    var isTerminating = false
    var isLeaf: Bool {
        children.isEmpty
    }

    init(value: T) {
        self.value = value
    }

    func allWords(prefix: String) -> [String] {
        let childrenWords = children.flatMap { key, node in
            node.allWords(prefix: prefix + "\(value)")
        }
        return isTerminating ? childrenWords + ["\(prefix)\(value)"] : childrenWords
    }
}

final class Trie {
    private var children = [Character: TrieNode<Character>]()

    func insert(word: String) {
        var tempNode: TrieNode<Character>? = nil
        for char in word {
            guard !children.isEmpty else {
                let newNode = TrieNode(value: char)
                children.updateValue(newNode, forKey: char)
                tempNode = newNode
                continue
            }
            guard let node = tempNode else {
                if let existingNode = children[char] {
                    tempNode = existingNode
                    continue
                } else {
                    let newNode = TrieNode(value: char)
                    children.updateValue(newNode, forKey: char)
                    tempNode = newNode
                    continue
                }
            }
            guard let existingNode = node.children[char] else {
                let newNode = TrieNode(value: char)
                node.children.updateValue(newNode, forKey: char)
                tempNode = newNode
                continue
            }
            tempNode = existingNode
        }
        tempNode?.isTerminating = true
    }

    func exists(word: String) -> String? {
        var tempNode: TrieNode<Character>? = nil
        for char in word {
            guard let node = tempNode else {
                if let existingNode = children[char] {
                    tempNode = existingNode
                    continue
                } else {
                    return nil
                }
            }
            if let existingNode = node.children[char] {
                tempNode = existingNode
                continue
            } else {
                return nil
            }
        }
        return tempNode?.isTerminating ?? false ? word : nil
    }

    func allWords() -> [String] {
        children.flatMap { key, node in
            node.allWords(prefix: "")
        }
    }
}
/*:
 # Tests
 */

import XCTest
class Tests: XCTestCase {
    func testFindWord() {
        var dictionay = Dictionary()
        dictionay.insert("cat")
        dictionay.insert("catastrophic")
        dictionay.insert("bat")
        dictionay.print()

        XCTAssertNil(dictionay.find("foo"))
        XCTAssertNotNil(dictionay.find("bat"))


        print("Find words")
        dial("228").forEach { word in
            guard let existingWord = (dictionay.find(word)) else {
                return
            }
            print(existingWord)
        }
    }

    func testTrie() {
        let dictionary = Trie()
        dictionary.insert(word: "cat")
        dictionary.insert(word: "cats")
        dictionary.insert(word: "bat")
        dictionary.insert(word: "foo")
        dictionary.insert(word: "bar")
        print(dictionary.allWords())

        XCTAssertNotNil(dictionary.exists(word: "cat"))
        XCTAssertNil(dictionary.exists(word: "dog"))

        let result = dial("228")
            .compactMap { input  in
                dictionary.exists(word: input)
            }
            .sorted()

        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0], "bat")
        XCTAssertEqual(result[1], "cat")

        let result2 = split("22802280228")
            .map {
                dial($0)
            }
            .map { input in
                input.compactMap {
                    dictionary.exists(word: $0)
                }
            }
            .reduce([String]()) { acc, values in
                guard !acc.isEmpty else {
                    return values
                }
                return acc.flatMap { accValue in
                    values.map { value in
                        accValue + " " + value
                    }
                }
            }
        print(result2)
    }
}

runTests(Tests())
