//: [Previous](@previous)

import Foundation

example("最大面积") {
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
}

example("爬楼梯") {
    func climbStairs(_ n: Int) -> Int {
        var nums = Array<Int>(repeating: 0, count: n)
        return fib(n, &nums)
    }
    
    func fib(_ n: Int, _ nums: inout [Int]) -> Int {
        if n <= 2 {
            return n
        }
        
        if nums[n - 1] != 0 {
            return nums[n - 1]
        }
        
        nums[n - 1] = fib(n - 1, &nums) + fib(n - 2, &nums)
        return nums[n - 1]
    }
    
    print(climbStairs(10))
}

example("火柴拼正方形") {
    func makesquare(_ nums: [Int]) -> Bool {
        
        if nums.count < 4 {
            return false
        }
        
        let sum = nums.reduce(0, +)
        if sum % 4 != 0 {
            return false
        }
        
        var buckets = Array<Int>.init(repeating: 0, count: 4)
        return backtrack(0, nums.sorted(), sum / 4, &buckets)
    }
    
    func backtrack(_ i: Int, _ nums: [Int], _ edge: Int, _ bucket: inout [Int]) -> Bool {
        if i >= nums.count {
            return true
        }
        
        for j in 0..<4 {
            if bucket[j] + nums[i] > edge {
                continue
            }
            
            bucket[j] += nums[i]
            if backtrack(i + 1, nums, edge, &bucket) {
                return true
            }
            bucket[j] -= nums[i]
        }
        
        return false
    }
    
    print(makesquare([1,1,2,2,2]))
    print(makesquare([3,3,3,3,4]))
}

example("两数相加") {
    /// 从数组中取出两个数字加起来跟目标值一样
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
}

example("三数相加等于目标值") {
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
    
    print(threeSum([-1, 0, 1, 2, -1, -4]))
}

example("所有组合成目标值的罗列") {
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
    
    print(combinationSum([10,1,2,7,6,1,5], 8))
}

example("数字反转") {
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
}

example("搜索旋转有序数组") {
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
                    left = mid + 1
                } else {
                    right  = mid - 1
                }
            }
        }
        
        return -1
    }
    
    print(search(nums: [5,6,7,1,2,3,4], target: 3))
}

example("搜索数组中目标的起始和结束位置") {
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
    
    print(searchRange([1,2,3,3,4,5,6], 3))
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

example("判断数独是否有效") {
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

    print(isValidSudoku(sudoArr))
}

example("递归解数独") {
    func solveSudoku(_ board: inout [[Character]]) {
        dfs(&board, 0, 0)
    }
    
    func dfs(_ board: inout [[Character]], _ x: Int, _ y: Int) -> Bool {
        if x > 8 {
            return true
        }
        
        if board[x][y] == "." {
            for k in 1...9 {
                if isValid(&board, x, y, Character("\(k)")) {
                    board[x][y] = Character("\(k)")
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
    
    solveSudoku(&sudoArr)
    sudoArr.forEach { print($0) }
}

example("非递归解数独") {
    var results: [[Set<Character>]] = {
        var results = [[Set<Character>]]()
        for _ in 0..<9 {
            var rowArr = [Set<Character>]()
            for _ in 0..<9 {
                let resultArr: Set<Character> = ["1", "2", "3", "4", "5", "6", "7" ,"8" ,"9"]
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
    
    solveSudoku(&sudoArr)
    sudoArr.forEach { print($0) }
}
