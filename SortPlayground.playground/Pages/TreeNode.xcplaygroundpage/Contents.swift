//: [Previous](@previous)

import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
    }
}

class TreeNodeSolution {
    
    var nodeArr: [Int] = []
    
    // 深度优先搜索(递归方式)
    func preorderTraversal(_ node: TreeNode?) -> [Int] {
        if let node = node {
            // 前序遍历
            nodeArr.append(node.val)
            
            if node.left != nil {
                preorderTraversal(node.left)
            }
            
            // 中序遍历
            // nodeArr.append(node.val)
            
            if node.right != nil {
                preorderTraversal(node.right)
            }
            
            // 后序遍历
            // nodeArr.append(node.val)
        }
        
        return nodeArr
    }
    
    // 深度优先搜索（非递归）
    static func preorderTraversal1(_ node: TreeNode?) -> [Int] {
        
        var node = node
        var nodeList: [Int] = []
        var stackArr: [TreeNode] = []
        
        while node != nil || !stackArr.isEmpty {
            while node != nil {
                nodeList.append(node!.val)
                stackArr.append(node!)
                node = node?.left
            }
            
            if !stackArr.isEmpty {
                node = stackArr.removeLast().right
            }
        }
        
        return nodeList
    }
    
    // 层次遍历（广度优先搜索）
    func levelTraversal(_ node: TreeNode?) -> [Int] {
        var queueArr: [TreeNode] = []

        if node != nil {
            queueArr.append(node!)
        }
        
        var nodeList: [Int] = []
        
        while !queueArr.isEmpty {
            let dequeueNode = queueArr.removeFirst()
            nodeList.append(dequeueNode.val)
            
            if dequeueNode.left != nil {
                queueArr.append(dequeueNode.left!)
            }
            if dequeueNode.right != nil {
                queueArr.append(dequeueNode.right!)
            }
        }
        
        return nodeList
    }
    
    // 求树的高度
    static func depthTreeNode(_ node: TreeNode?) -> Int {
        if node == nil {
            return 0
        }
        return max(depthTreeNode(node?.left), depthTreeNode(node?.right)) + 1
    }
    
    // 求节点数量
    static func calTreeNodeNum(_ node: TreeNode?) -> Int {
        if node == nil {
            return 0
        }
        return calTreeNodeNum(node?.left) + calTreeNodeNum(node?.right) + 1
    }
    
    // 求叶子结点数量
    static func calTreeNodeLeafCount(_ node: TreeNode?) -> Int {
        guard let node = node else {
            return 0
        }
        
        if node.left == nil, node.right == nil {
            return 1
        }
        
        return calTreeNodeLeafCount(node.left) + calTreeNodeLeafCount(node.right)
    }
    
    // 判断两颗树是否相同
    static func isSameTree(_ node1: TreeNode?, _ node2: TreeNode?) -> Bool {
        
        if node1 == nil, node2 == nil {
            return true
        } else if node1 == nil || node2 == nil {
            return false
        }
        
        if node1?.val != node2?.val {
            return false
        }
        
        return isSameTree(node1?.left, node2?.left) && isSameTree(node1?.right, node2?.right)
    }
    
    // 二叉树的镜像
    static func mirrorTree(_ node: TreeNode?) -> TreeNode? {
        if node == nil {
            return node
        }
        
        let leftNode = mirrorTree(node?.left)
        let rightNode = mirrorTree(node?.right)
        node?.left = rightNode
        node?.right = leftNode
        return node
    }
    
    // 判断是否是二分查找树
    static func isBinarySearchTree(_ node: TreeNode?, _ middle: Int) -> Bool {
        if node == nil {
            return true
        }
        
        var middle = middle
        let left = isBinarySearchTree(node?.left, middle)
        if !left {
            return false
        }
        
        if node!.val <= middle {
            return false
        }
        
        middle = node!.val
        let right = isBinarySearchTree(node?.right, middle)
        if !right {
            return false
        }
        
        return true
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
    
    // 二叉树最近公共祖先
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil || p === root || q === root {
            return root
        }
        
        let left = lowestCommonAncestor(root?.left, p, q)
        let right = lowestCommonAncestor(root?.right, p, q)
        if left == nil { return right }
        if right == nil { return left }
        return root
    }
}

let rootNode = TreeNode(10)
let node1 = TreeNode(9)
let node2 = TreeNode(8)
let node3 = TreeNode(7)
let node4 = TreeNode(6)
let node5 = TreeNode(5)
let node6 = TreeNode(4)
let node7 = TreeNode(3)
let node8 = TreeNode(2)
let node9 = TreeNode(1)
let node10 = TreeNode(0)

rootNode.left = node1
rootNode.right = node2
node1.left = node3
node1.right = node4
node2.left = node5
node2.right = node6
node3.left = node7
node4.right = node8
node5.left = node9
node6.right = node10

print(TreeNodeSolution().preorderTraversal(rootNode))
print(TreeNodeSolution.preorderTraversal1(rootNode))
print(TreeNodeSolution().levelTraversal(rootNode))
print(TreeNodeSolution.depthTreeNode(rootNode))
print(TreeNodeSolution.calTreeNodeNum(rootNode))
print(TreeNodeSolution.calTreeNodeLeafCount(rootNode))
print(TreeNodeSolution.isSameTree(rootNode, rootNode))
let mirrorNode = TreeNodeSolution.mirrorTree(rootNode)
print(TreeNodeSolution().levelTraversal(mirrorNode))
