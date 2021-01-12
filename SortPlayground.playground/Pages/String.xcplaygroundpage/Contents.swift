//: Playground - noun: a place where people can play

import Foundation

example("求字符串的全排列") {
    var res = [String]()
    var characters = [Character]()
    
    func permutation(_ str: String) -> [String] {
        characters = Array(str)
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
    
    print(permutation("abbc"))
}

example("复原IP地址") {
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
                res.append(segments.map({ String($0) }).joined(separator: "."))
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
    
    print(restoreIpAddresses("010010"))
}

example("字符串单词翻转") {
    // 利用swift提供的API
    func reverseWordsSystem(_ s: String) -> String {
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
        characters.removeAll()
        trimSpace(str)
        reverse(0, characters.count - 1)
        reverseEachWord()
        return String(characters)
    }
    
    print(reverseWords("a good   example!"))
    print(reverseWords(" a  good  example! "))
}

example("最长公共前缀") {
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.isEmpty {
            return ""
        }
        
        let firstStr = strs[0]
        var otherStr = ""
        for i in 0..<strs[0].count {
            let c = firstStr[firstStr.index(firstStr.startIndex, offsetBy: i)]
            
            for j in 1..<strs.count {
                otherStr = strs[j]
                if i == otherStr.count || otherStr[otherStr.index(otherStr.startIndex, offsetBy: i)] != c {
                    return String(firstStr.prefix(i))
                }
            }
        }
        return firstStr
    }
    print(longestCommonPrefix(["flower", "flow", "flight"]))
}

example("最长回文字") {
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
}

example("最长不重复子串") {
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

    print(lengthOfLongestSubstring("abcabcdbbcdef"))
}

example("简化路径") {
    func simplifyPath(_ path: String) -> String {
        if path.isEmpty {
            return "/"
        }
        
        var completedPath = [String]()
        var compnent = path.components(separatedBy: "/").filter({ !$0.isEmpty && $0 != " " })
        while !compnent.isEmpty {
            let name = compnent.removeFirst()
            if name == ".." {
                if !completedPath.isEmpty {
                    completedPath.removeLast()
                }
            } else if name != "." {
                completedPath.append(name)
            }
        }
        
        return "/" + completedPath.joined(separator: "/")
    }
    
    print(simplifyPath("/home/"))
}
