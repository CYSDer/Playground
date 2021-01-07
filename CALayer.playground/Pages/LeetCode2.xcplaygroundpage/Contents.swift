
import Foundation

// 链表结构
public class ListNode {
    public var val: Int
    public var next: ListNode?
    
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// 计算字符串数组中最长公共前缀: https://leetcode-cn.com/problems/longest-common-prefix/
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
    print(longestCommonPrefix(["a", "ab", "abc"]))
}


// 链表表示两数相加：https://leetcode-cn.com/problems/add-two-numbers/
example("两数相加") {
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        let head = ListNode(0)
        
        var p = l1, q = l2
        var remainder = 0, nextNode: ListNode? = head
        
        while p != nil || q != nil {
            
            let sum = (p?.val ?? 0) + (q?.val ?? 0) + remainder
            
            remainder = sum / 10
            nextNode?.next = ListNode(sum % 10)
            nextNode = nextNode?.next
            
            if p != nil {
                p = p?.next
            }
            
            if q != nil {
                q = q?.next
            }
        }
        
        if remainder > 0 {
            nextNode?.next = ListNode(remainder)
        }
        
        return head.next
    }
    
    
    let list1 = ListNode(2)
    list1.next = ListNode(4)
    list1.next?.next = ListNode(3)
    
    let list2 = ListNode(5)
    list2.next = ListNode(6)
    list2.next?.next = ListNode(4)
    
    var result = addTwoNumbers(list1, list2)
    while result != nil {
        print(result!.val)
        result = result?.next
    }
}

