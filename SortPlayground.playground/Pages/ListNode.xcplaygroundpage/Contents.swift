//: [Previous](@previous)

import Foundation

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class RandomListNode {
    var val: Int
    var next: RandomListNode?
    var random: RandomListNode?
    
    init(_ val: Int) {
        self.val = val
    }
}

class ListNodeSolution {
    // 链表反转
    static func reverseList(_ head: ListNode?) -> ListNode? {

        var head = head
        var next: ListNode?
        let tempNode = ListNode(0)
        
        while head != nil {
            next = head?.next
            head?.next = tempNode.next
            tempNode.next = head
            head = next
        }
        
        return tempNode.next
    }
    
    // 链表反转（递归）
    static func recurseReverseList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        
        let nextNode = head?.next
        head?.next = nil
        let newNode = recurseReverseList(nextNode)
        nextNode?.next = head
        return newNode
    }
    
    // 递归反向打印链表
    static func printListReverse(head: ListNode?) {
        if head != nil {
            if head?.next != nil {
                printListReverse(head: head?.next)
            }
            print(head!.val)
        }
    }
    
    // 判断链表是否有环
    static func isLoopList(head: ListNode?) -> Bool {
        var slowPointer = head, fastPointer = head
        
        while fastPointer != nil, fastPointer?.next != nil {
            slowPointer = slowPointer?.next
            fastPointer = fastPointer?.next?.next
            
            if slowPointer === fastPointer {
                return true
            }
        }
        return false
    }
    
    // 计算环形链表出现环时的节点（空间复杂度O(1)）
    static func detectCycle(head: ListNode?) -> ListNode? {
        var slowPointer = head
        var fastPointer = head
        while fastPointer != nil {
            slowPointer = slowPointer?.next
            if fastPointer?.next == nil {
                return nil
            }
            fastPointer = fastPointer?.next?.next
            if fastPointer === slowPointer {
                var pointer = head
                while pointer !== slowPointer {
                    pointer = pointer?.next
                    slowPointer = slowPointer?.next
                }
                return pointer
            }
        }
        return nil
    }
    
    // 计算链表环的长度
    static func getCycleLength(head: ListNode?) -> Int {
        var slowPointer = head
        var fastPointer = head
        while fastPointer != nil {
            slowPointer = slowPointer?.next
            if fastPointer?.next == nil {
                return 0
            }
            fastPointer = fastPointer?.next?.next
            if fastPointer === slowPointer {
                var length = 1
                var tempNode = slowPointer?.next
                while slowPointer !== tempNode {
                    tempNode = tempNode?.next
                    length += 1
                }
                return length
            }
        }
        return 0
    }
    
    // 删除链表某个节点（要求时间复杂度O(1)）
    static func deleteNode(head: ListNode?, deleteNode: ListNode?) {
        if head == nil || deleteNode == nil {
            return
        }
        
        if deleteNode!.next == nil {
            var dummyNode = head
            while dummyNode?.next !== deleteNode {
                dummyNode = dummyNode?.next
            }
            dummyNode?.next = nil
        } else {
            let nextNode = deleteNode!.next!
            deleteNode?.val = nextNode.val
            deleteNode?.next = nextNode.next
        }
    }
    
    // 求两个链表的公共节点
    static func findFirstCommonNode(node1: ListNode?, node2: ListNode?) -> ListNode? {
        
        if node1 == nil || node2 == nil {
            return nil
        }
        
        var length1 = 0, length2 = 0
        var node1 = node1, node2 = node2
        while node1 != nil {
            length1 += 1
            node1 = node1?.next
        }
        
        while node2 != nil {
            length2 += 1
            node2 = node2?.next
        }
        
        var num = length1 - length2
        if num > 0 {
            while num > 0 {
                node1 = node1?.next
                num -= 1
            }
            
            while node1 !== node2 {
                node1 = node1?.next
                node2 = node2?.next
            }
            return node1
        } else {
            while num < 0 {
                node2 = node2?.next
                num += 1
            }
            
            while node2 !== node1 {
                node2 = node2?.next
                node1 = node1?.next
            }
            return node2
        }
    }
    
    // 合并两个有序链表
    static func mergeList(node1: ListNode?, node2: ListNode?) -> ListNode? {
        if node1 == nil && node2 == nil {
            return nil
        }
        
        let head = ListNode(0)
        var dummyNode = head
        var node1 = node1, node2 = node2
        while node1 != nil, node2 != nil {
            if node1!.val <= node2!.val {
                dummyNode.next = node1
                node1 = node1?.next
            } else {
                dummyNode.next = node2
                node2 = node2?.next
            }
            dummyNode = dummyNode.next!
        }
        
        if node1 != nil {
            dummyNode.next = node1
        }
        if node2 != nil {
            dummyNode.next = node2
        }
        
        return head.next
    }
    
    // 复制复杂的链表
    static func cloneRandomList(head: RandomListNode?) -> RandomListNode? {
        if head == nil {
            return nil
        }
        
        // 复制所有的节点
        var currentNode = head
        while currentNode != nil {
            let nextNode = currentNode?.next
            let copyNode = RandomListNode(currentNode!.val)
            currentNode?.next = copyNode
            copyNode.next = nextNode
            currentNode = nextNode
        }
        
        // 绑定random节点
        currentNode = head
        while currentNode != nil {
            let randomNode = currentNode?.random
            currentNode?.next?.random = randomNode?.next
            currentNode = currentNode?.next?.next
        }
        
        // 拆分链表
        currentNode = head
        let cloneHead = head?.next
        while currentNode != nil {
            let copyNode = currentNode?.next
            let nextHead = copyNode?.next
            currentNode?.next = nextHead
            copyNode?.next = nextHead?.next
            currentNode = nextHead
        }
        
        return cloneHead
    }
    
}

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


func printList(_ head: ListNode?) {
    var head = head
    var nodeArr = [String]()
    while head != nil {
        nodeArr.append("\(head!.val)")
        head = head?.next
    }
    print(nodeArr.joined(separator: "->"))
}

let head = ListNode(0)
let node1 = ListNode(1)
let node2 = ListNode(2)
let node3 = ListNode(3)
let node4 = ListNode(4)
let node5 = ListNode(5)
let node6 = ListNode(6)

head.next = node1
node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5
node5.next = node6
printList(head)

let reverseList = ListNodeSolution.reverseList(head)
printList(reverseList)
let recurseReverseList = ListNodeSolution.recurseReverseList(reverseList)
printList(recurseReverseList)
ListNodeSolution.printListReverse(head: recurseReverseList)

print(ListNodeSolution.isLoopList(head: recurseReverseList))

let node7 = ListNode(7)
node6.next = node7
node7.next = node3

print(ListNodeSolution.isLoopList(head: recurseReverseList))
let cycleNodel = ListNodeSolution.detectCycle(head: recurseReverseList)
print(cycleNodel?.val ?? -1)
print(ListNodeSolution.getCycleLength(head: recurseReverseList))
