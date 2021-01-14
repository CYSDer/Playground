//: [Previous](@previous)

import Foundation

example("求x的平方根") {
    func mySqrt(_ x: Int) -> Int {
        var l = 0, r = x, ans = -1
        while l <= r {
            let mid = l + (r - l) / 2
            if mid * mid <= x {
                ans = mid
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
        
        return ans
    }
    
    print(mySqrt(9))
}

example("验证UTF-8") {
    func validUtf8(_ data: [Int]) -> Bool {
        var numberOfBytesToPorcess = 0
        
        for num in data {
            var binStr = String(num, radix: 2)
            
            if binStr.count > 8 {
                binStr = String(binStr[binStr.startIndex..<binStr.index(binStr.startIndex, offsetBy: 8)])
            } else if binStr.count < 8 {
                let prefix = Array(repeating: 0, count: 8 - binStr.count).map({String($0)}).joined()
                binStr = prefix + binStr
            }
            
            if numberOfBytesToPorcess == 0 {
                for character in binStr {
                    if character == "0" {
                        break
                    }
                    
                    numberOfBytesToPorcess += 1
                }
                
                // 当前num表示一个字节
                if numberOfBytesToPorcess == 0 {
                    continue
                }
                
                // 题目规定四个字节，并且一个字节时首位为0，故需要处理在2...4之间
                if numberOfBytesToPorcess > 4 || numberOfBytesToPorcess == 1 {
                    return false
                }
            } else {
                if !(binStr.first == "1" && binStr[binStr.index(after: binStr.startIndex)] == "0") {
                    return false
                }
            }
            
            numberOfBytesToPorcess -= 1
        }
        
        return numberOfBytesToPorcess == 0
    }
    
    print(validUtf8([197, 130, 1]))
}

example("LRU缓存") {
        
    class LRUCache {
        
        class DLinkedNode {
            let key: Int
            var value: Int
            var next: DLinkedNode?
            var prev: DLinkedNode?
            
            init(_ key: Int, _ value: Int) {
                self.key = key
                self.value = value
            }
        }
        
        let capacity: Int
        private var size: Int = 0
        private let head = DLinkedNode(0, 0)
        private let tail = DLinkedNode(0, 0)
        private var cache = [Int: DLinkedNode]()
        
        init(_ capacity: Int) {
            self.capacity = capacity
            head.next = tail
            tail.prev = head
        }
        
        func get(_ key: Int) -> Int {
            if let node = cache[key] {
                moveToHead(node)
                return node.value
            }
            
            return -1
        }
        
        func put(_ key: Int, _ value: Int) {
            if let node = cache[key] {
                node.value = value
                moveToHead(node)
            } else {
                let newNode = DLinkedNode(key, value)
                cache[key] = newNode
                addToHead(newNode)
                size += 1
                if size > capacity {
                    if let deletedNode = removeTail() {
                        cache[deletedNode.key] = nil
                        size -= 1
                    }
                }
            }
        }
        
        private func addToHead(_ node: DLinkedNode) {
            node.prev = head
            node.next = head.next
            head.next?.prev = node
            head.next = node
        }
        
        private func removeNode(_ node: DLinkedNode) {
            node.prev?.next = node.next
            node.next?.prev = node.prev
        }
        
        private func moveToHead(_ node: DLinkedNode) {
            removeNode(node)
            addToHead(node)
        }
        
        private func removeTail() -> DLinkedNode? {
            if let tail = tail.prev, tail !== head {
                removeNode(tail)
                return tail
            }
            return nil
        }
    }
    
    let cache = LRUCache(2)
    cache.put(1, 1)
    cache.put(2, 2)
    print((cache.get(1), cache.get(2)))
}

example("股票买卖最佳时机") {
    
    func maxProfit(_ prices: [Int]) -> Int {
        var minPrice = Int.max
        var maxProfit = 0
        for price in prices {
            if price < minPrice {
                minPrice = price
            } else if price - minPrice > maxProfit {
                maxProfit = price - minPrice
            }
        }
        return maxProfit
    }
    
    func maxProfit2(_ prices: [Int]) -> Int {
        var maxProfit = 0
        for i in 1..<prices.count {
            if prices[i] > prices[i - 1] {
                maxProfit += prices[i] - prices[i - 1]
            }
        }
        return maxProfit
    }
    
    print(maxProfit([7,1,5,3,6,4]))
    print(maxProfit2([7,1,5,3,6,4]))
}

example("动态规划") {
    
    // 动态规划：
    // 1、建立状态转移方程
    // 2、缓存并复用之前计算的结果
    // 3、按从小到大顺序计算
    
    example("爬楼梯") {
        func climbStairs(_ n: Int) -> Int {
            var nums = Array<Int>(repeating: 0, count: n+1)
            for i in 0...n {
                if i < 3 {
                    nums[i] = i
                } else {
                    nums[i] = nums[i-1] + nums[i-2]
                }
            }
            
            return nums[n]
        }
        
        print(climbStairs(10))
    }

    
    example("最小子序和") {
        func maxSubArray(_ nums: [Int]) -> Int {
            if nums.isEmpty { return 0 }
            var nums = nums
            var res = nums[0]
            for i in 1..<nums.count {
                nums[i] += max(nums[i - 1], 0)
                res = max(res, nums[i])
            }
            return res
        }
        
        print(maxSubArray([-2,1,-3,4,-1,2,1,-5,4]))
    }
    
    example("不同路径") {
        func countPaths(_ m: Int, _ n: Int) -> Int {
            
            var nums = Array<Array<Int>>(repeating: Array<Int>(repeating: 1, count: n), count: m)
            for i in 1..<m {
                for j in 1..<n {
                    nums[i][j] = nums[i - 1][j] + nums[i][j - 1]
                }
            }
            return nums[m - 1][n - 1]
        }
        
        print(countPaths(7, 3))
    }

}
