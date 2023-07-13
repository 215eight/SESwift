/*:
 # Overview
 */

/*:
 # Code
 */

/*:
 # Tests
 */

public struct Heap<Element> {
    private var elements: [Element]
    private let priorityFunction: (Element, Element) -> Bool

    public init(elements: [Element], priorityFunction: @escaping (Element, Element) -> Bool) {
        self.elements = elements
        self.priorityFunction = priorityFunction
        for index in (0 ..< (count / 2) ).reversed() {
            siftDownElement(at: index)
        }
    }

    public var isEmpty: Bool {
        elements.isEmpty
    }

    public var count: Int {
        elements.count
    }

    public func peek() -> Element? {
        elements.first
    }

    public mutating func enqueue(_ element: Element) {
        elements.append(element)
        siftUpElement(at: count - 1)
    }

    public mutating func dequeue() -> Element? {
        guard !isEmpty else {
            return nil
        }
        swapElements(at: 0, with: count - 1)
        let element = elements.removeLast()
        if !isEmpty {
            siftDownElement(at: 0)
        }
        return element
    }

    func isRoot(_ index: Int) -> Bool {
        index == 0
    }

    func leftChildIndex(of index: Int) -> Int {
        (2 * index) + 1
    }

    func rightChildIndex(of index: Int) -> Int {
        (2 * index) + 2
    }

    func parentIndex(of index: Int) -> Int {
        (index - 1) / 2
    }

    func  isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        priorityFunction(elements[firstIndex], elements[secondIndex])
    }

    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int {
        guard childIndex < count else {
            return parentIndex
        }
        return isHigherPriority(at: parentIndex, than: childIndex) ? parentIndex : childIndex
    }

    func highestPriorityIndex(for parentIndex: Int) -> Int {
        let left = highestPriorityIndex(of: parentIndex, and: leftChildIndex(of: parentIndex))
        let right = highestPriorityIndex(of: left, and: rightChildIndex(of: parentIndex))
        return highestPriorityIndex(of: left, and: right)
    }

    mutating func swapElements(at firstIndex: Int, with secondIndex: Int) {
        guard firstIndex != secondIndex else {
            return
        }
        elements.swapAt(firstIndex, secondIndex)
    }

    mutating func siftUpElement(at index: Int) {
        let parent = parentIndex(of: index)
        guard !isRoot(index) else { return }
        guard isHigherPriority(at: index, than: parent) else { return }
        swapElements(at: index, with: parent)
        siftUpElement(at: parent)
    }

    mutating func siftDownElement(at index: Int) {
        let highestPriorityIndex = highestPriorityIndex(for: index)
        guard index != highestPriorityIndex else { return }
        swapElements(at: index, with: highestPriorityIndex)
        siftDownElement(at: highestPriorityIndex)
    }
}

import XCTest
class Tests: XCTestCase {
    func testInit() {
        let heap = Heap(elements: [1,45,1,0,51,-1], priorityFunction: >)
    }

    func testPeak() {
        let heap = Heap(elements: [1,45,1,0,51,-1], priorityFunction: >)
        XCTAssertEqual(heap.peek(), 51)
    }

    func testEnqueue() {
        var heap = Heap(elements: [1,45,1,0,51,-1], priorityFunction: >)
        XCTAssertEqual(heap.peek(), 51)
        heap.enqueue(100)
        XCTAssertEqual(heap.peek(), 100)
        heap.enqueue(10)
        XCTAssertEqual(heap.peek(), 100)
        heap.enqueue(10)
        XCTAssertEqual(heap.peek(), 100)
    }

    func testDequeue() {
        var heap = Heap(elements: [1,45,1,0,51,-1], priorityFunction: >)
        XCTAssertEqual(heap.peek(), 51)
        XCTAssertEqual(heap.dequeue(), 51)
        XCTAssertEqual(heap.peek(), 45)
        XCTAssertEqual(heap.dequeue(), 45)
        XCTAssertEqual(heap.peek(), 1)
    }

    func testCount() {
        var heap = Heap(elements: [1,45,1,0,51,-1], priorityFunction: >)
        XCTAssertEqual(heap.count, 6)
        heap.enqueue(100)
        XCTAssertEqual(heap.count, 7)
        heap.dequeue()
        XCTAssertEqual(heap.count, 6)
    }

    func testIsEmpty() {
        var heap = Heap(elements: [Int](), priorityFunction: >)
        XCTAssertEqual(heap.isEmpty, true)
        heap.enqueue(100)
        XCTAssertEqual(heap.isEmpty, false)
        heap.dequeue()
        XCTAssertEqual(heap.isEmpty, true)
    }
}

runTests(Tests())
