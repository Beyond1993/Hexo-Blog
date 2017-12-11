---
title: LeetCode-Binary-Tree
date: 2017-08-23 01:13:59
categories: LeetCode
tags: binary-tree
---
二叉树

```text
      node1
     /     \
   node2  node3        

                           +-DFS
       +-search--+-traverse+-BFS
Tree---+         +-divide & conquer -->DFS BFS? 
       +-build-->
```
Tree的题目大致分为两种，第一种是遍历一棵树，第二种是构造一棵树。

## travese. 普通递归，将结果用参数的形式返回 


类型一： 遍历二叉树．

遍历二叉树是很多题目的基础，重中之重．

二叉树遍历分为深度(DFS)，层次遍历(BFS)．

### DFS
深度遍历又分为前序，中序，后序．三大遍历．

三种遍历的递归写法比较简单
```cpp
void traverse(TreeNode root) {
  if (root == NULL) {
     return NULL;
  }
  //cout<<root->val<<endl; //preorder
  traverse(root->left);
  //cout<<root->val<<endl; //inorder
  traverse(root->right);
  //cout<<root->val<<endl; //postorder
}
```


二叉树的非递归遍历：

基本思路，先将左子树不断压栈，左子树为空时，将从栈顶节点の右子树作为当前节点．

中序：
```java
Stack s = new Stack();
TreeNode p = root;
while( !s.isEmpty() || p != null) {
    while( p != null) {
        s.push(p);
        p = p.left;
    }
    TreeNode node = s.pop();
    System.out.println(node.val);
    p = node.right;
}
```

前序：
```java
Stack s = new Stack();
TreeNode p = root;
while( !s.isEmpty() || p != null) {
    while( p != null) {
        System.out.println(p.val);
        p = p.left;
    }
    TreeNode node = s.pop();
    p = node.right;
}
```

```java
public List<Integer> preorderTraversal(TreeNode root) {
    if (root == null) {
        return new ArrayList<Integer>();
    }
    List<Integer> result = new ArrayList<Integer>();
    Stack<TreeNode> s = new Stack<TreeNode>();
    s.push(root);
    while(!s.isEmpty()) {
       TreeNode cur = s.pop();
       result.add(cur.val);
       if (cur.right != null) {
            s.push(cur.right);
        }
            
        if (cur.left != null) {
            s.push(cur.left);
        }
    }
   return result;
}
```
前序，中序的思路一样，只是打印节点的位置不同．

后序：还是前序，中序基本的思路，只不过节点第一次出栈时先压回栈顶，第二次出栈在打印出来,　可以在TreeNode 节点里加 flag 或者　用hashSet 记录是否第一次出现.


```java
Stack s = new Stack();
Set set = new HashSet();    
        
TreeNode p = root;
while (!s.empty() || p != null) {
    while(p != null) {
        s.push(p);
        p = p.left;
    }
    TreeNode node = s.pop();
    if (!set.contains(node)) {
        set.add(node);
        s.push(node);
        p = node.right;
    } else {
        list.add(node.val);
    }    
}
```
**树的DFS， 是如此重要，很多很多题，都是DFS的变种题**

[114. Flatten Binary Tree to Linked List](https://leetcode.com/problems/flatten-binary-tree-to-linked-list/description/)

### 分治法，典型代码
分支法最后由return value 返回。
例子： 求树的hight
```cpp
int left = maxpath(root->left);
int right = maxpath(root->right);
return math.max(left, right) + 1;
```

类型二： 构造二叉树

核心结构
```cpp
TreeNode * root = new TreeNode();
root->left = helper();
root->right = helper(); 
```

或者

```cpp
vector<TreeNode *> lefts = helper();
vector<TreeNode *> rights = helper();
for (int i = 0; i < lefts.size(); i++) 
  for (int j = 0; rights.size(); i++)
{
    TreeNode * root = new TreeNode();
    root->left = left;
    root->right = right;
}
```
这两种结构的最大区别就是，第一种helper function 只返回一种情况，但是第二种模板是返回多种情况, lefts,rights

[Unique Binary Search Trees II](https://leetcode.com/problems/unique-binary-search-trees-ii/description/)


线段树，索引树

Tree Questions Categories:

94 Binary Tree Inorder Traversal

95 Unique Binary Search Trees II

96 Unique Binary Search Trees

98 Valid Binary Search Tree

99 Revocer Binary Search Tree

100 Same Tree

101 Symmetric Tree

102 Binary Tree Level Order Traversal

103 Binary Tree Zigzag Level Order Traversal

104    Maximum Depth of Binary Tree    53.5%    Easy    
105    Construct Binary Tree from Preorder and Inorder Traversal    32.9%    Medium    
106    Construct Binary Tree from Inorder and Postorder Traversal    32.6%    Medium    
107    Binary Tree Level Order Traversal II    41.1%    Easy    
108    Convert Sorted Array to Binary Search Tree    42.9%    Easy    
110    Balanced Binary Tree    38.0%    Easy    
111    Minimum Depth of Binary Tree    33.4%    Easy    
112    Path Sum    34.4%    Easy    
113    Path Sum II    34.7%    Medium    
114    Flatten Binary Tree to Linked List    35.8%    Medium    
116    Populating Next Right Pointers in Each Node    36.9%    Medium    
117    Populating Next Right Pointers in Each Node II    33.9%    Medium    
124    Binary Tree Maximum Path Sum    26.7%    Hard    
129    Sum Root to Leaf Numbers    37.2%    Medium    
144    Binary Tree Preorder Traversal    45.9%    Medium    
145    Binary Tree Postorder Traversal    41.0%    Hard    
156    Binary Tree Upside Down     45.2%    Medium    
173    Binary Search Tree Iterator    42.6%    Medium    
199    Binary Tree Right Side View    41.7%    Medium    
222    Count Complete Tree Nodes    27.6%    Medium    
226    Invert Binary Tree    52.6%    Easy    
230    Kth Smallest Element in a BST    44.6%    Medium    
235    Lowest Common Ancestor of a Binary Search Tree    39.5%    Easy    
236    Lowest Common Ancestor of a Binary Tree    30.0%    Medium    
250    Count Univalue Subtrees     43.0%    Medium    
255    Verify Preorder Sequence in Binary Search Tree     40.8%    Medium    
257    Binary Tree Paths    39.9%    Easy    
270    Closest Binary Search Tree Value     40.2%    Easy    
272    Closest Binary Search Tree Value II     39.5%    Hard    
285    Inorder Successor in BST     36.3%    Medium    
297    Serialize and Deserialize Binary Tree    34.1%    Hard    
298    Binary Tree Longest Consecutive Sequence     41.5%    Medium    
333    Largest BST Subtree     30.7%    Medium    
337    House Robber III    44.1%    Medium    
366    Find Leaves of Binary Tree 

303Range Sum Query - Immutable   29.3%Easy

304Range Sum Query 2D - Immutable   24.9%Medium

307Range Sum Query - Mutable   20.4%Medium

308Range Sum Query 2D - Mutable   

这四道题是很好的一个系列题．从一维到二维，从矩阵到树 从0(n^2) 到 O(logn)， 正是计算机优化的方向．



303 一维数组

304 二维数组



307 segment tree

Given an integer array nums, find the sum of the elements between indices i and j (i ≤ j), inclusive.

The update(i, val) function modifies nums by updating the element at index i to val.

Example:

Given nums = [1, 3, 5]

sumRange(0, 2) -> 9
update(1, 2)
sumRange(0, 2) -> 8


reference:http://blog.csdn.net/metalseed/article/details/8039326

线段树，又称区间树， 在区间统计问题上，如区间动态查询，能达到较快速度。

节点中包含了 start end, 还有sum, max, min 等信息。

一般线段树空间是数组的四倍？？？











308 二进制索引树（树状数组）



能用树状数组解决的题基本都能用segment tree 解决， 但是反之不行。

树状数组效率比线段树要高。



