//: [Previous](@previous)

import Foundation

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int: Int]()
    for i in 0..<nums.count {
        let index = dict[target - nums[i]]
        if index != nil {
            return [index!, i]
        }  else {
            dict[nums[i]] = i
        }
    }
    return []
}
print(twoSum([2,1,3,4,5,6], 10))


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    let num = 10
    var carray = 0
    let list: ListNode? = ListNode.init(0)
    var p = l1, q = l2, currentNode = list
    
    while p != nil || q != nil {
        let val1 = p?.val ?? 0
        let val2 = q?.val ?? 0
        let res = val1 + val2 + carray
        let value = res % num
        carray = res / num
        
        currentNode?.next = ListNode.init(value)
        currentNode = currentNode?.next
        
        if p != nil {
            p = p?.next
        }
        if q != nil {
            q = q?.next
        }
    }
    if carray > 0 {
        currentNode?.next = ListNode.init(carray)
    }
    return list?.next
}

let l1 = ListNode.init(1)
l1.next = ListNode.init(3)
l1.next?.next = ListNode.init(8)

let l2 = ListNode.init(2)
l2.next = ListNode.init(4)
l2.next?.next = ListNode.init(6)

var listNode = addTwoNumbers(l1, l2)
while listNode != nil {
    print(listNode!.val)
    listNode = listNode?.next
}

func reverse(_ x: Int) -> Int {
    var num = x
    var result = 0
    
    while num != 0 {
        let pop = num % 10
        num = num / 10
        
        if result > INT_MAX / 10 || (result == INT_MAX / 10 && pop  > 7) {
            return 0
        }
        
        if result < INT16_MIN / 10 || (result == INT16_MIN / 10 && pop < -8) {
            return 0
        }
        
        result = result * 10 + pop
    }
    
    return result
}
print(reverse(1234656))


func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    var A = nums1
    var B = nums2
    
    // 确保 m<=n
    if A.count > B.count {
        A = nums2
        B = nums1
    }
    let m = A.count
    let n = B.count
    let halfLen = (m + n + 1) / 2
    var iMin = 0, iMax = m
    
    while iMin <= iMax {
        let i = (iMin + iMax) / 2
        let j = halfLen - i
        
        if i < iMax && B[j - 1] > A[i] {
            iMin = i + 1
        } else if i > iMin && A[i - 1] > B[j] {
            iMax = i - 1
        } else {
            var maxLeft = 0
            if i == 0 {
                maxLeft = B[j - 1]
            } else if j == 0 {
                maxLeft = A[i - 1]
            } else {
                maxLeft = max(A[i - 1], B[j - 1])
            }
            
            if (m + n) % 2 == 1 {
                return Double(maxLeft)
            }
            
            var minRight = 0
            if i == m {
                minRight = B[j]
            }  else if j == n {
                minRight = A[i]
            } else {
                minRight = min(A[i], B[j])
            }
            return Double(maxLeft + minRight) / 2.0
        }
    }
    
    return 0.0
}
print(findMedianSortedArrays([1,3,5,7,9,11], [2,4,6,8,10,12]))


func lengthOfLongestSubstring(_ s: String) -> Int {
    var dict = [Character : Int](), i = 0, res = 0
    
    for j in 0..<s.count {
        let c = s[s.index(s.startIndex, offsetBy: j)]
        if dict[c] != nil {
            i = max(dict[c]!, i)
        }
        res = max(res, j - i + 1)
        dict[c] = j + 1
    }
    
    return res
}

let len = lengthOfLongestSubstring("abcabcdbbcdef")
print(len)

func longestPalindrome(_ s: String) -> String {
    guard s.count > 1 else {
        return ""
    }
    var start = 0, end = 0

    func expandAroundCenter(_ str: String, _ left: Int, _ right: Int) -> Int {
        var left = left, right = right
        while left >= 0 && right < str.count && str[str.index(str.startIndex, offsetBy: left)] == str[str.index(str.startIndex, offsetBy: right)] {
            left -= 1
            right += 1
        }
        return right -  left -  1
    }
    
    for i in 0..<s.count {
        let len1 = expandAroundCenter(s, i, i)
        let len2 = expandAroundCenter(s, i, i + 1)
        
        let len = max(len1, len2)
        if len > end - start {
            start = i - (len - 1) / 2
            end = i + len / 2
        }
    }
    
    let startIndex = s.index(s.startIndex, offsetBy: start)
    let endIndex = s.index(s.startIndex, offsetBy: end)
    
    return String(s[startIndex...endIndex])
}
print(longestPalindrome("abcddcb"))


func maxArea(_ height: [Int]) -> Int {
    var left = 0, right = height.count - 1, maxArea = 0
    while left < right {
        maxArea = max(maxArea, min(height[left], height[right]) * (right - left))
        if height[left] < height[right] {
            left += 1
        } else {
            right -= 1
        }
    }
    return maxArea
}
print(maxArea([1,8,6,2,5,4,8,3,7]))


func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    let tempNode = ListNode(0)
    tempNode.next = head
    
    var firstNode: ListNode? = tempNode
    var secondNode: ListNode? = tempNode
    
    for _ in 0...n {
        firstNode = firstNode?.next
    }
    
    while firstNode != nil {
        firstNode = firstNode?.next
        secondNode = secondNode?.next
    }
    secondNode?.next = secondNode?.next?.next
    
    return tempNode.next
}

let headNode = ListNode.init(1)
headNode.next = ListNode.init(2)
headNode.next?.next = ListNode.init(3)
headNode.next?.next?.next = ListNode.init(4)
headNode.next?.next?.next?.next = ListNode.init(5)

var node = removeNthFromEnd(headNode, 2)
//while node != nil {
//    print(node!.val)
//    node = node?.next
//}


func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var list1 = l1, list2 = l2
    let tempNode = ListNode.init(0)
    var nextNode: ListNode? = tempNode
    
    while list1 != nil || list2 != nil {
        
        let handleClosure = {
            nextNode?.next = list2
            nextNode = nextNode?.next
            list2 = list2?.next
        }
        
        if list1 != nil {
            if list2 != nil && (list1?.val)! > (list2?.val)! {
                handleClosure()
            } else {
                nextNode?.next = list1
                nextNode = nextNode?.next
                list1 = list1?.next
            }
        } else {
            handleClosure()
        }
    }
    
    return tempNode.next
}
var resNode = mergeTwoLists(l1, l2)
//while resNode != nil {
//    print(resNode!.val)
//    resNode = resNode?.next
//}


// 移除重复元素
func removeDuplicates(_ nums: inout [Int]) -> Int {
    var i = 0
    for j in 0..<nums.count {
        if nums[i] != nums[j] {
            i += 1;
            nums[i] = nums[j]
        }
    }
    return i + 1
}
var dupicateArr = [0,0,1,1,1,2,2,3,3,4]
let count = removeDuplicates(&dupicateArr)
print(dupicateArr)


// 数组中原地移除某个元素
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    var i = 0
    var n = nums.count
    while i < n {
        if nums[i] == val {
            nums[i] = nums[n - 1]
            n -= 1
        } else {
            i += 1
        }
    }
    return n
}
removeElement(&dupicateArr, 2)
dupicateArr


// 搜索数组中目标的起始和结束位置
func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    guard nums.count > 0 else {
        return [-1, -1]
    }
    
    var left = 0, right = nums.count - 1, resArr = [Int]()
    
    while left < right {
        let mid = (right - left) / 2 + left
        if nums[mid] < target {
            left = mid + 1
        } else {
            right = mid
        }
    }
    if nums[left] == target {
        resArr.append(left)
    } else {
        return [-1, -1]
    }
    
    left = 0; right = nums.count - 1
    while left < right {
        let mid = (right - left + 1) / 2 + left
        if nums[mid] > target {
            right = mid - 1
        } else {
            left = mid
        }
    }
    
    if nums[right] == target {
        resArr.append(right)
    }
    return resArr
}
print(searchRange([1,2,3,4,5,6], 3))


// 判断是否为有效数独
func isValidSudoku(_ board: [[Character]]) -> Bool {
    guard board.count == 9, board[0].count == 9 else {
        return false
    }
    
    var rowSet = Set<Character>()
    var colSet = Set<Character>()
    var cubSet = Set<Character>()
    
    for i in 0..<9 {
        
        rowSet.removeAll()
        colSet.removeAll()
        cubSet.removeAll()
        
        for j in 0..<9 {
            if board[i][j] != "." {
                if rowSet.contains(board[i][j]) {
                    return false
                }
                rowSet.insert(board[i][j])
            }
            
            if board[j][i] != "." {
                if colSet.contains(board[j][i]) {
                    return false
                }
                colSet.insert(board[j][i])
            }
            
            let rowIndex = 3 * (i / 3) + j / 3
            let colIndex = 3 * (i % 3) + j % 3
            if board[rowIndex][colIndex] != "." {
                if cubSet.contains(board[rowIndex][colIndex]) {
                    return false
                }
                cubSet.insert(board[rowIndex][colIndex])
            }
        }
    }
    return true
}
var sudoArr: [[Character]] = [["5","3",".",".","7",".",".",".","."],
                              ["6",".",".","1",".","5",".",".","."],
                              [".","9","8",".",".",".",".","6","."],
                              ["8",".",".",".","6",".",".",".","3"],
                              ["4",".",".","8",".","3",".",".","."],
                              ["7",".",".",".","2",".",".",".","6"],
                              [".","6",".",".",".",".","2","8","."],
                              [".",".",".","4","1","9",".",".","5"],
                              [".",".",".",".","8",".",".","7","."]]
print(isValidSudoku(sudoArr))

// 解数独
class Solution {
    func solveSudoku(_ board: inout [[Character]]) {
        dfs(&board, 0, 0)
    }
    
    func dfs(_ board: inout [[Character]], _ x: Int, _ y: Int) -> Bool {
        if x > 8 {
            return true
        }
        
        if board[x][y] == "." {
            for k in 1...9 {
                if isValid(&board, x, y, Character.init("\(k)")) {
                    board[x][y] = Character.init("\(k)")
                    var nextX = x
                    var nextY = y + 1
                    if nextY == 9 {
                        nextY = 0
                        nextX += 1
                    }
                    if dfs(&board, nextX, nextY) {
                        return true
                    }
                    board[x][y] = "."
                }
            }
            return false
        } else {
            var nextX = x
            var nextY = y + 1
            if nextY == 9 {
                nextY = 0
                nextX += 1
            }
            return dfs(&board, nextX, nextY)
        }
    }
    
    
    func isValid(_ board: inout [[Character]], _ x:  Int, _ y: Int, _ k: Character) -> Bool {
        for i in 0..<9 {
            if board[i][y] == k || board[x][i] == k || board[3*(x/3)+i/3][3*(y/3)+i%3] == k {
                return false
            }
        }
        return true
    }
    
    init() {
        solveSudoku(&sudoArr)
        print(sudoArr)
    }
}
//Solution()

class Sodution {
    
    lazy var results: [[Set<Character>]] = {
        var results = [[Set<Character>]]()
        for i in 0..<9 {
            var rowArr = [Set<Character>]()
            for j in 0..<9 {
                var resultArr: Set<Character> = ["1", "2", "3", "4", "5", "6", "7" ,"8" ,"9"]
                rowArr.append(resultArr)
            }
            results.append(rowArr)
        }
        return results
    }()
    
    
    func solveSudoku(_ board: inout [[Character]]) {
        if !calculateAllResult(&board) {
            return
        }

        var minResultSet: Set<Character> = [], x = 0, y = 0
        for i in 0..<9 {
            for j in 0..<9 {
                if results[i][j].count > 0 {
                    if minResultSet.count == 0 || results[i][j].count < minResultSet.count {
                        minResultSet = results[i][j]
                        x = i
                        y = j
                    }
                }
            }
        }

        for character in minResultSet {
            board[x][y] = character
            if calculateAllResult(&board) {
                solveSudoku(&board)
            } else {
                board[x][y] = "."
            }
        }
    }

    
    func calculateAllResult(_ board: inout [[Character]]) -> Bool {
        for i in 0..<9 {
            for j in 0..<9 {
                if board[i][j] == "." {
                    var characters = Set<Character>()
                    for k in 0..<9 {
                        if board[i][k] != "." {
                            characters.insert(board[i][k])
                        }
                        if board[k][j] != "." {
                            characters.insert(board[k][j])
                        }
                        if board[3*(i/3)+k/3][3*(j/3)+k%3] != "." {
                            characters.insert(board[3*(i/3)+k/3][3*(j/3)+k%3])
                        }
                    }
                    
                    let remainder = results[i][j].subtracting(characters)
                    // 如果造成无解结束本次循环
                    if remainder.count == 0 {
                        return false
                    }
                    results[i][j] = remainder
                } else {
                    results[i][j].removeAll()
                }
                
            }
        }
        return true
    }
    
    init() {
        solveSudoku(&sudoArr)
        print(sudoArr)
    }
    
}
//Sodution()

class SolutionC {
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var res = [[Int]]()
        var item = [Int]()
        backTrack(candidates.filter{ $0 <= target }, 0, target, &item, &res)
        return res
    }
    
    func backTrack(_ candidates: [Int], _ start: Int, _ target: Int, _ item: inout [Int] , _ res: inout [[Int]]) {
        if target < 0 {
            return
        }
        
        if target == 0 {
            res.append(item)
            return
        }
        
        for i in start..<candidates.count {
            item.append(candidates[i])
            backTrack(candidates, i + 1, target - candidates[i], &item, &res)
            item.popLast()
        }
    }
    
    init() {
        print(combinationSum([10,1,2,7,6,1,5], 8))
    }
}
//SolutionC()


class SolutionS {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        guard nums.count > 2 else {
            return res
        }
        nums.sorted()
        
        for i in 0..<nums.count - 2 {
            if i > 0 && nums[i] == nums[i - 1] {
                break
            }
            
            var j = i + 1
            var k = nums.count - 2
            
            while j < k {
                let sum = nums[i] + nums[j] + nums[k]
                if sum > 0 {
                    k -=  1
                } else if sum < 0 {
                    j += 1
                } else {
                    res.append([nums[i], nums[j], nums[k]])
                    while nums[j + 1] == nums[j] {
                        j += 1
                    }
                    j += 1
                }
            }
        }
        return res
    }
    
    init() {
        print(threeSum([-1, 0, 1, 2, -1, -4]))
    }
}
SolutionS()

