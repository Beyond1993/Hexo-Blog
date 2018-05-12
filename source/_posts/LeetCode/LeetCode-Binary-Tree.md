---
title: LeetCode-Binary-Tree
date: 2017-12-12 01:13:59
categories: LeetCode-Index
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
Tree的题目大致分为三种，第一种是遍历一棵树，第二种是divde conquer, 第三种是构造一棵树。

第二种 divide conquer:

[543. Diameter of Binary Tree](http://www.wayne.ink/2017/12/14/LeetCode/0543-Diameter-of-Binary-Tree/)

## Traversal. 普通递归，将结果用参数的形式返回 


类型一： 遍历二叉树．

遍历二叉树是很多题目的基础，重中之重．

二叉树遍历分为深度(DFS)，层次遍历(BFS)．

### Traversal-DFS
深度遍历又分为前序，中序，后序．三大遍历．

最近重新复习, binary tree. 发现之前结论是错误的，前序遍历的第二种写法。其实是BFS. 先右子树压栈，再左子树压栈。

**也就是说前序遍历有DFS, BFS 两种实现**

而且后序遍历的有一种写法是反前序遍历倒过来。所以**后序遍历也有BFS 的写法**

那么问题来了。中序遍历有没有BFS 的写法呢？
果然有
http://blog.163.com/guo_linda/blog/static/1237730572010928251143/

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

### 前序：
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


### Traversal-BFS
以前一直认为前序，中序，后序遍历是属于DFS, 这次总结发现了以前还是too young too simple
用BFS 照样可以做

#### 前序
 
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

####  中序 

用栈 + BFS 的版本却并不乐观。preOrder可以用栈很好的执行的原因是，将左右节点压入栈后，根节点就再也用不着了；而中序和后序却不一样，左右节点入栈后，根节点后面还需要访问。
因此三个节点都要入栈，而且入栈的先后顺序必须为：右节点，根节点，左节点。但是，当入栈以后，根节点与其左右子树的节点就分不清楚了。
因此必须引入一个标志位，表示 是否已经将该节点的左右子树入栈了。每次入栈时，根节点标志位为true,左右子树标志位为false。
```cpp
void InOrder2(TNode* root) 
{ 
    Stack S; 
    if( root != NULL ) 
    { 
        S.push(root); 
    } 
    while ( !S.empty() ) 
    { 
        TNode* node = S.pop();  
        if ( node->bPushed ) 
        {   // 如果标识位为true,则表示其左右子树都已经入栈，那么现在就需要访问该节点了 
            Visit(node);         
        } 
        else 
        {   // 左右子树尚未入栈，则依次将 右节点，根节点，左节点 入栈 
            if ( node->right != NULL ) 
            { 
                node->right->bPushed = false; // 左右子树均设置为false 
                S.push(node->right); 
            } 
            node->bPushed = true;  // 根节点标志位为true 
            S.push(node); 
            if ( node->left != NULL ) 
            { 
                node->left->bPushed = false; 
                S.push(node->left); 
            } 
        } 
    } 
}
```

#### 后序
```java
public List<Integer> postorderTraversal(TreeNode root) {
    if (root == null) {
        return new ArrayList<Integer>();
    }
    Stack<TreeNode> s = new Stack<TreeNode>();
    List<Integer> list = new ArrayList<Integer>();
    s.push(root);
    while(!s.isEmpty()) {
        TreeNode p = s.pop();
        
        list.add(p.val); // list.add(0,p.val) witout Collections.reverse(list);
        if (p.left != null) {
            s.push(p.left);
        }
        
        if(p.right != null) {
            s.push(p.right);
        }
    }
        
    Collections.reverse(list);
    return list;
        
}
```


**树的前中后三序搜索是如此重要， 如此重要，是如此重要，很多很多题，都是Traversal的变种题**
[114. Flatten Binary Tree to Linked List](https://leetcode.com/problems/flatten-binary-tree-to-linked-list/description/)

### 时间复杂度
搞了一大推

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



