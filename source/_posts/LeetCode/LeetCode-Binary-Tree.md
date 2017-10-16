---
title: LeetCode-Binary-Tree
date: 2017-08-23 01:13:59
categories: LeetCode
tags: binary-tree
---
二叉树
      node1
     /     \
   node2  node3 


二叉树题目简单，但是变化繁多．特此总结．



类型一： 遍历二叉树．

遍历二叉树是很多题目的基础，重中之重．



二叉树遍历分为深度，层次遍历．



深度遍历又分为前序，中序，后序．三大遍历．



三种遍历的递归写法比较简单，暂时不讨论．



二叉树的非递归遍历：

基本思路，先将左子树不断压栈，左子树为空时，将从栈顶节点の右子树作为当前节点．



中序：

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


前序：

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


前序，中序的思路一样，只是打印节点的位置不同．



后序：还是前序，中序基本的思路，只不过节点第一次出栈时先压回栈顶，第二次出栈在打印出来,　可以在TreeNode 节点里加 flag 或者　用hashSet 记录是否第一次出现.



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


类型二： 构造二叉树




线段树，索引树

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



