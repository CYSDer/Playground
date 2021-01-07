//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var totalSteps: Int = 0 {
    willSet(newTotalSteps) {
        print("About to set totalSteps to \(newTotalSteps)")
    }
    didSet {
        if totalSteps > oldValue  {
            print("Added \(totalSteps - oldValue) steps")
        }
    }
}

let optionalString: String? = nil ?? "def"
optionalString

let precomposed: Character = "\u{D55C}"
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"

let preStr = String(precomposed)
let decStr = String(decomposed)
preStr.count
decStr.count
preStr.endIndex

enum People: String {
    case man, woman
}

People.init(rawValue: "man")


// 求最长不重复子串长度
func lengthOfLongestSubstring(str: String) -> Int {
    var dict = [Character: Int]()
    var i = -1, res = 0
    for j in 0..<str.count {
        let character = str[str.index(str.startIndex, offsetBy: j)]
        if let index = dict[character] {
            i = max(i, index)
        }
        dict[character] = j
        res = max(res, j - i)
    }
    return res
}
print(lengthOfLongestSubstring(str: "abcdabcdabbbc"))

// 求最长公共前缀
func longestCommonPrefix(strs: [String]) -> String {
    
    guard !strs.isEmpty else {
        return ""
    }
    
    let firstStr = strs.first!
    for i in 0..<firstStr.count {
        let characterIndex = firstStr.index(firstStr.startIndex, offsetBy: i)
        let character = firstStr[characterIndex]
        for j in 1..<strs.count {
            if strs[j].count == i || strs[j][characterIndex] != character {
                return String(firstStr.prefix(i))
            }
        }
    }
    
    return firstStr
}
print(longestCommonPrefix(strs: ["flower", "flow", "flight"]))

// 求字符串的全排列
class Solution {
    var res = [String]()
    var characters = [Character]()
    
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        permutation(s1)
        for str in res {
            if s2.contains(str) {
                return true
            }
        }
        
        return false
    }
    
    func permutation(_ str: String) -> [String] {
        characters = str.sorted()
        dfs(0)
        return res
    }
    
    func dfs(_ index: Int) {
        if index == characters.count - 1 {
            res.append(String(characters))
            return
        }
        
        var characterSet = Set<Character>()
        for i in index..<characters.count {
            if characterSet.contains(characters[i]) {
                continue
            }
            
            characterSet.insert(characters[i])
            swap(a: i, b: index)
            dfs(index + 1)
            swap(a: index, b: i)
        }
    }
    
    func swap(a: Int, b: Int) {
        if a == b { return }
        let characterA = characters[a]
        characters[a] = characters[b]
        characters[b] = characterA
    }
}

let solution = Solution()
print(solution.permutation("abc"))
print(solution.checkInclusion("abc", "abcbbba"))

// 复原IP地址
class SolutionIP {
    
    let segmentCount = 4
    var res = [String]()
    var segments = [0, 0, 0, 0]

    func restoreIpAddresses(_ str: String) -> [String] {
        dfs(str, 0, 0)
        return res
    }
    
    func dfs(_ str: String, _ index: Int, _ start: Int) {
        
        if index == segmentCount {
            if start == str.count {
                res.append(segments.map( {String($0) }).joined(separator: "."))
            }
            return
        }
        
        if start == str.count {
            return
        }
        
        if str[str.index(str.startIndex, offsetBy: start)] == "0" {
            segments[index] = 0
            dfs(str, index + 1, start + 1)
            return
        }
        
        var addr = 0
        for end in start..<min(str.count, start + 3) {
            addr = addr * 10 + str[str.index(str.startIndex, offsetBy: end)].wholeNumberValue!
            if addr > 0 && addr <= 255 {
                if Float(str.count - end - 1) / Float(segmentCount - index - 1) > 3 {
                    continue
                }
                segments[index] = addr
                dfs(str, index + 1, end + 1)
            } else {
                break
            }
        }
    }
}

let ipSolution = SolutionIP()
print(ipSolution.restoreIpAddresses("010010"))

// 字符串单词翻转
class SolutionRevserse {
    // 利用swift提供的API
    static func reverseWords(_ s: String) -> String {
        return s.components(separatedBy: CharacterSet.whitespaces)
            .filter({ !$0.isEmpty })
            .reversed()
            .joined(separator: " ")
    }
    
    var characters = [Character]()
    
    func trimSpace(_ str: String) {
        var left = 0, right = str.count - 1
        while left <= right && str[str.index(str.startIndex, offsetBy: left)] == " " {
            left += 1
        }
        
        while left <= right && str[str.index(str.startIndex, offsetBy: right)] == " " {
            right -= 1
        }
        
        while left <= right {
            let character = str[str.index(str.startIndex, offsetBy: left)]
            if character != " " || characters.last != " " {
                characters.append(character)
            }
            left += 1
        }
    }
    
    
    func reverse(_ left: Int, _ right: Int) {
        var left = left, right = right
        while left < right {
            let tmp = characters[left]
            characters[left] = characters[right]
            characters[right] = tmp
            left += 1
            right -= 1
        }
    }
    
    func reverseEachWord() {
        var start = 0, end = 0
        while start < characters.count {
            while end < characters.count && characters[end] != " " {
                end += 1
            }
            
            reverse(start, end - 1)
            start = end + 1
            end += 1
        }
    }
    
    func reverseWords(_ str: String) -> String {
        trimSpace(str)
        reverse(0, characters.count - 1)
        reverseEachWord()
        return String(characters)
    }
}
print(SolutionRevserse.reverseWords("a good   example!"))
print(SolutionRevserse().reverseWords(" a  good  example! "))


// 火柴拼正方形
class MakeSquare {
    
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
    
    private func backtrack(_ i: Int, _ nums: [Int], _ edge: Int, _ bucket: inout [Int]) -> Bool {
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
}
