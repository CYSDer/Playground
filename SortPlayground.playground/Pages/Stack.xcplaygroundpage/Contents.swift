//: [Previous](@previous)

import Foundation

// 栈定义
protocol Stack {
    associatedtype Element
    
    var isEmpty: Bool { get }
    var size: Int { get }
    var peek: Element? { mutating get }
    
    mutating func push(_ newElement: Element)
    mutating func pop() -> Element?
}

struct IntegerStack: Stack {
    typealias Element = Int
    
    var stack = [Element]()
    
    var isEmpty: Bool {
        return stack.isEmpty
    }
    
    var size: Int {
        return stack.count
    }
    
    var peek: Int? {
        return stack.last
    }
    
    mutating func push(_ newElement: Int) {
        stack.append(newElement)
    }
    
    mutating func pop() -> Int? {
        return stack.popLast()
    }
}

// 堆定义
protocol Queue {
    associatedtype Element
    
    var isEmpty: Bool { get }
    var size: Int { get }
    var peek: Element? { mutating get }
    
    mutating func enqueue(_ newElement: Element)
    mutating func dequeue() -> Element?
}

struct IntegerQueue: Queue {
    typealias Element = Int
    
    var queue = [Element]()
    
    var isEmpty: Bool {
        return queue.isEmpty
    }
    
    var size: Int {
        return queue.count
    }
    
    var peek: Int? {
        return queue.first
    }
    
    var capacity: Int {
        set {
            queue.reserveCapacity(newValue)
        }
        get {
            return queue.capacity
        }
    }
    
    mutating func enqueue(_ newElement: Int) {
        queue.append(newElement)
    }
    
    mutating func dequeue() -> Int? {
        return queue.removeFirst()
    }
}

// 用栈实现队列
struct MyQueue: Queue {
    typealias Element = Int
    
    var stackA = IntegerStack()
    var stackB = IntegerStack()
    
    var isEmpty: Bool {
        return stackA.isEmpty && stackB.isEmpty
    }
    
    var size: Int {
        return stackA.size + stackB.size
    }
    
    var peek: Int? {
        mutating get {
            shift()
            return stackB.peek
        }
    }
    
    mutating func enqueue(_ newElement: Int) {
        stackA.push(newElement)
    }
    
    mutating func dequeue() -> Int? {
        shift()
        return stackB.pop()
    }
    
    mutating private func shift() {
        if stackB.isEmpty {
            while !stackA.isEmpty {
                stackB.push(stackA.pop()!)
            }
        }
    }
}

// 利用队列实现栈
struct MyStack: Stack {
    typealias Element = Int
    
    var queueA = IntegerQueue()
    var queueB = IntegerQueue()
    
    var isEmpty: Bool {
        return queueA.isEmpty && queueB.isEmpty
    }
    
    var size: Int {
        return queueA.size
    }
    
    var peek: Int? {
        mutating get {
            shift()
            let peekObj = queueA.peek
            queueB.enqueue(queueA.dequeue()!)
            swap()
            return peekObj
        }
    }
    
    mutating func push(_ newElement: Int) {
        queueA.enqueue(newElement)
    }
    
    mutating func pop() -> Int? {
        shift()
        let popObjc = queueA.dequeue()
        swap()
        return popObjc
    }
    
    mutating private func shift() {
        while queueA.size != 1 {
            queueB.enqueue(queueA.dequeue()!)
        }
    }
    
    mutating private func swap() {
        (queueA, queueB) = (queueB, queueA)
    }
}

class MetingTime {
    var start: Int
    var end: Int
    
    init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}

func merge(meetingTimes: [MetingTime]) -> [MetingTime] {
    guard meetingTimes.count > 1 else {
        return meetingTimes
    }
    
    // 按开始时间排序,如果开始时间一样按结束时间排
    let meetingTimes = meetingTimes.sorted {
        if $0.start != $1.start {
            return $0.start <  $1.start
        } else {
            return $0.end  < $1.end
        }
    }
    
    var res = [MetingTime]()
    res.append(meetingTimes.first!)
    
    for i in 0..<meetingTimes.count {
        let last = res.last!
        let current = meetingTimes[i]
        
        if current.start > last.end {
            res.append(current)
        } else {
            last.end  =  max(last.end, current.end)
        }
    }
    return res
}

typealias MeetingTupe = (start: Int, end: Int)
func merge(meetingTimes: [MeetingTupe]) -> [MeetingTupe] {
    guard meetingTimes.count > 1 else {
        return meetingTimes
    }
    
    let sortedMeetings = meetingTimes.sorted {
        if $0.start != $1.start {
            return $0.start < $1.start
        } else {
            return $0.end < $1.end
        }
    }
    
    var res = [MeetingTupe]()
    res.append(sortedMeetings.first!)
    
    for i in 0..<sortedMeetings.count {
        var last = res.last!
        let current = sortedMeetings[i]
        
        if current.start > last.end {
            res.append(current)
        } else {
            res.removeLast()
            last.end = max(last.end, current.end)
            res.append(last)
        }
    }
    return res
}
