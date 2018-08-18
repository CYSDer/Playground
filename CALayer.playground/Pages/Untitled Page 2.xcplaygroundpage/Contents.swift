//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

// 栈定义
protocol Stack {
    associatedtype Element
    
    var isEmpty: Bool { get }
    var size: Int { get }
    var peek: Element? {  get }
    
    mutating func push(_ newElement: Element)
    mutating func pop() -> Element?
}

// 堆定义
protocol Queue {
    associatedtype Element
    
    var isEmpty: Bool { get }
    var size: Bool { get }
    var peek: Element? { get }
    
    mutating func enqueue(_ newElement: Element)
    mutating func dequeue() -> Element?
}

// 二叉树定义
class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ val: Int) {
        self.val = val
    }
}

// 求二叉树高度
func maxDepth(root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    return max(maxDepth(root: root.left), maxDepth(root: root.right)) + 1
}

// 判断一颗二叉树是否为二叉搜索树
func isValidBST(root: TreeNode?) -> Bool {
    return helper(node: root, nil, nil)
}

func helper(node: TreeNode?, _ min: Int?, _ max: Int?) -> Bool
{
    guard let node = node else { return true }
    
    // 所有右子树节点的值都必须大于根节点的值
    if let min = min, node.val <= min {
        return false
    }
    
    // 所有左子树节点的值都必须小于根节点的值
    if let max = max, node.val >= max {
        return false
    }
    
    return helper(node: node.left, min, node.val) && helper(node: node.right, node.val, max)
}

// 利用队列思想层级遍历二叉树
func levelOrder(root: TreeNode?) -> [[Int]] {
    var res = [[Int]]()
    var queue = [TreeNode]()
    
    if let root = root {
        queue.append(root)
    }
    
    while queue.count > 0 {
        var level = [Int]()
        
        for _ in 0 ..< queue.count {
            let node = queue.removeFirst()
            
            level.append(node.val)
            if let left = node.left {
                queue.append(left)
            }
            
            if let right = node.right {
                queue.append(right)
            }
        }
        res.append(level)
    }
    return res
}

// 快速排序简单版
func quickSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else {
        return array
    }
    
    let pivot = array[array.count / 2]
    let left = array.filter{ $0 < pivot }
    let middle = array.filter{ $0 == pivot }
    let right = array.filter{ $0 > pivot }
    
    return quickSort(left) + middle + quickSort(right)
}

// 二分搜索
func binarySearch(_ num: [Int], _ target: Int) -> Bool {
    var left = 0, mid = 0, right = num.count - 1
    
    while left <= right {
        mid = (right - left) / 2 + left
        
        if num[mid] == target {
            return true
        } else if num[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    
    return false
}

// 二分搜索递归实现
func binarySearch(nums: [Int], target: Int) -> Bool {
    return binarySearch(nums: nums, target: target, left: 0, right: nums.count - 1)
}

func binarySearch(nums: [Int], target: Int, left: Int, right: Int) -> Bool {
    guard left <= right else {
        return false
    }
    
    let mid = (right - left) / 2 + left
    
    if nums[mid] == target {
        return true
    } else if nums[mid] < target {
        return binarySearch(nums: nums, target: target, left: mid + 1, right: right)
    } else {
        return binarySearch(nums: nums, target: target, left: left, right: mid - 1)
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

// 搜索旋转有序数组
func search(nums: [Int], target: Int) -> Int {
    var (left, mid, right) = (0, 0, nums.count - 1)
    
    while left <= right {
        mid = (right - left) / 2 + left
        
        if nums[mid] == target {
            return mid
        }
        
        if nums[mid] >= nums[left] {
            if nums[mid] > target && target >= nums[left] {
                right = mid - 1
            } else {
                left = mid + 1
            }
        } else {
            if nums[mid] < target && target <= nums[right] {
                left = mid + 10
            } else {
                right  = mid - 1
            }
        }
    }
    
    return -1
}

// 函数柯里化
func add(_ num: Int) -> (Int) -> Int {
    return { $0  + num }
}
let addTwo = add(2)
addTwo(1)

(0...10).map{ $0 * $0 }.filter{ $0 % 2 == 0 }
// @synchronized

let concurrentQueue = DispatchQueue.global(qos: .background)
print(1)
concurrentQueue.sync {
    print(2)
    concurrentQueue.async {
        print(3)
    }
    print(4)
}
print(5)
// 12345  12435  12453


let highPriorityQueue = DispatchQueue.global(qos: .userInitiated)
let lowPriorityQueue  = DispatchQueue.global(qos: .utility)

let semaphore = DispatchSemaphore(value: 1)
lowPriorityQueue.async {
    semaphore.wait()
    for i in 0...10 {
        print(i)
    }
    semaphore.signal()
}

highPriorityQueue.async {
    semaphore.wait()
    for i in 11...20 {
        print(i)
    }
    semaphore.signal()
}


class ViewController: UITableViewController {
    
    var nums = [Int]()
    let numOfRows = 10
    let maxNum: UInt32 = 100
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewDataSource()

//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
//        tableView.refreshControl = refreshControl
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        let mainQueue = DispatchQueue.main
        let time = DispatchTime.init(uptimeNanoseconds: 2)
        
        mainQueue.asyncAfter(deadline: time) {
            self.configureTableViewDataSource()
            refreshControl.endRefreshing()
        }
    }
    
    func configureTableViewDataSource() -> Void {
        generateRandom()
        tableView.reloadData()
    }
    
    func generateRandom() -> Void {
        nums.removeAll()
        
        for _ in 0..<numOfRows {
            nums.append(Int(arc4random_uniform(maxNum)))
        }
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text =  "\(nums[indexPath.row])"
        return cell
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveItem = nums[sourceIndexPath.row]
        nums.remove(at: sourceIndexPath.row)
        nums.insert(moveItem, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            nums.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
}

PlaygroundPage.current.liveView = ViewController()

var aClosure: () -> Void = {}

func escapingClosure(closure: @escaping () -> Void) {
    aClosure = closure
}

escapingClosure {
    print("hello")
}

aClosure()


