/*:
 # Overview
 */

/*:
 # Code
 */

func activityNotifications(expenditure: [Int], lookback d: Int) -> Int {
    return stride(from: d, to: expenditure.count, by: 1)
        .reduce(0) { acc, index in
            let expenditureSlice
                = expenditure[index - d ..< index]
            let sortedExpenditure = expenditureSlice
                .sorted()
            let median: Double
            if sortedExpenditure.count % 2 == 0 {
                let midIndex = sortedExpenditure.count / 2
                let lhs = sortedExpenditure[midIndex - 1]
                let rhs = sortedExpenditure[midIndex]
                median = Double(lhs + rhs) / 2.0
            } else {
                median = Double(sortedExpenditure[sortedExpenditure.count / 2])
            }
            let limit = 2.0 * median
            let todayExpenditure = Double(expenditure[index])
            let newAcc = todayExpenditure >= limit ? acc + 1 : acc
            return newAcc
        }
}

final class Node<T: Comparable> {
    let value: T
    var parentNode: Node? = nil
    var nextNode: Node? = nil

    init(value: T) {
        self.value = value
    }
}

final class Queue {

    private let maxCapacity: Int
    var capacity: Int = 0
    private var head: Node<Int>?
    private var tail: Node<Int>?

    init(maxCapacity: Int) {
        self.maxCapacity = maxCapacity
    }

    var isEmpty: Bool {
        head == nil && tail == nil
    }

    func push(_ node: Node<Int>) {
        guard maxCapacity > 0 else {
            return
        }

        defer {
            capacity += 1
        }

        if capacity == maxCapacity {
            pop()
        }

        guard !isEmpty else {
            self.head = node
            self.tail = node
            return
        }

        head?.parentNode = node
        node.nextNode = head
        self.head = node
    }

    func remove(_ node: Node<Int>) -> Node<Int> {
        defer {
            capacity -= 1
        }
        node.parentNode?.nextNode = node.nextNode
        node.nextNode?.parentNode = node.parentNode

        if head === node {
            head = node.nextNode
        }

        if tail === node {
            tail = node.parentNode
        }

        node.parentNode = nil
        node.nextNode = nil

        return node
    }

    func pop() -> Node<Int>? {
        guard !isEmpty else {
            return nil
        }

        defer {
            capacity -= 1
        }

        if head === tail {
            head = nil
        }

        let temp = tail
        tail = tail?.parentNode
        tail?.nextNode = nil
        temp?.parentNode = nil
        temp?.nextNode = nil

        return temp
    }

    func insert(_ node: Node<Int>) {
        defer {
            capacity += 1
        }

        guard !isEmpty else {
            self.head = node
            self.tail = node
            return
        }

        var runner: Node<Int>? = head
        while let value = runner?.value, value <= node.value {
            runner = runner?.nextNode
        }

        if runner === head {
            runner?.parentNode = node
            node.nextNode = runner
            head = node
        } else if runner == nil  {
            tail?.nextNode = node
            node.parentNode = tail
            tail = node
        } else {
            runner?.parentNode?.nextNode = node
            node.parentNode = runner?.parentNode
            runner?.parentNode = node
            node.nextNode = runner
        }
    }

    var median: Double {
        if capacity % 2 == 0 {
            let jumps = capacity / 2
            var runner = head
            (0..<jumps).forEach { _ in
                runner = runner?.nextNode
            }
            return (Double(runner!.value) + Double(runner!.parentNode!.value)) / 2.0
        } else {
            let jumps = capacity / 2
            var runner = head
            (0..<jumps).forEach { _ in
                runner = runner?.nextNode
            }
            return Double(runner!.value)
        }
    }

    var description: String {
        var result = ""
        var optionalRunner = head
        while let runner = optionalRunner {
            if !result.isEmpty {
                result += " "
            }
            result += runner.value.description
            optionalRunner = runner.nextNode
        }
        return result
    }
}

final class Store {

    private var indexToSortedNodeMap: [Int: Node<Int>]
    var sortedQueue: Queue
    var queue: Queue

    init(array: [Int], lookback: Int) {
        sortedQueue = Queue(maxCapacity: lookback)
        queue = Queue(maxCapacity: lookback)
        indexToSortedNodeMap = [Int: Node<Int>]()

        let arrayEnumerated = array.enumerated().map {
            (index: $0.offset, value: $0.element)
        }
        let arraySlice = arrayEnumerated[0..<lookback]
        arraySlice.forEach {
            queue.push(Node(value: $0.index))
        }
        arraySlice.sorted { lhs, rhs in
            lhs.value > rhs.value
        }
        .forEach {
            let node = Node(value: $0.value)
            sortedQueue.push(node)
            indexToSortedNodeMap[$0.index] = node
        }
    }

    func push(value: Int, key: Int) {
        if let discardedNode = queue.pop(),
           let sortedNode = indexToSortedNodeMap[discardedNode.value] {
            indexToSortedNodeMap[discardedNode.value] = nil
            sortedQueue.remove(sortedNode)

            queue.push(Node(value: key))
            let newNode = Node(value: value)
            indexToSortedNodeMap[key] = newNode
            sortedQueue.insert(newNode)

        } else {
            fatalError()
        }
    }

    var median: Double {
        sortedQueue.median
    }
}

func activityNotifications2(expenditure: [Int], lookback: Int) -> Int {
    let store = Store(array: expenditure, lookback: lookback)

    var count = 0
    for tuple in expenditure.enumerated() {
        guard tuple.offset >= lookback else {
            continue
        }
        let median = store.median
        let doubleMedian = 2.0 * median

        count = Double(tuple.element) >= doubleMedian ? count + 1 : count
        store.push(value: tuple.element, key: tuple.offset)
    }
    return count
}

/*:
 # Tests
 */

//runTestCases(inputOffset: 2,
//             inputBuilder: { lines -> ([Int], Int) in
//                let lookback: Int = Int(lines[0].components(separatedBy: .whitespaces).last!)!
//                let expediture: [Int] = lines[1].components(separatedBy: .whitespaces).map { Int($0)! }
//                return (expediture, lookback)
//             }, outputOffset: 1,
//             outputBuilder: { lines -> Int in
//                return (Int(lines[0])!)
//             }) { (input, expectedResult) in
//    return activityNotifications(expenditure: input.0, lookback: input.1)
//}

runTestCases(inputOffset: 2,
             inputBuilder: { lines -> ([Int], Int) in
                let lookback: Int = Int(lines[0].components(separatedBy: .whitespaces).last!)!
                let expediture: [Int] = lines[1].components(separatedBy: .whitespaces).map { Int($0)! }
                return (expediture, lookback)
             }, outputOffset: 1,
             outputBuilder: { lines -> Int in
                return (Int(lines[0])!)
             }) { (input, expectedResult) in
    return activityNotifications2(expenditure: input.0, lookback: input.1)
}
