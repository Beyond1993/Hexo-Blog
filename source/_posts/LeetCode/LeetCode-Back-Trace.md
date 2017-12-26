---
title: LeetCode-Back-Trace
date: 2017-10-16 05:53:09
categories: LeetCode-Index
tags:
---

回溯法．很多题都能通过回溯法至少给出一个解．

很喜欢九章回溯法的模板．

在for 循环里递归调用



模板：

private void dfs() {

    if (condition) {

        result.add(new List);

        retrun;

    }

    for (condition) {

        if (conditions) {

            //去重

        }

        list.add(＊＊)；

        dfs();

        list.remove(list.size() - 1);

    }



}





暴力搜索一个矩阵模板：




leetCode 回溯小结
关于回溯。在leetCode前150题里出现了21题
前100题里出现了18题
前50题里出现了9题 10 17 22 37 39 40 44 46 47

47	Permutations II  28.5%	Medium
46	Permutations 36.6%	Medium
44	Wildcard Matching	17.8%	Hard
40	Combination Sum II	28.2%	Medium
39	Combination Sum	31.7%	Medium
37	Sudoku Solver	25.5%	Hard
22	Generate Parentheses	37.9%	Medium
17	Letter Combinations of a Phone Number 29.4%	Medium
10	Regular Expression Matching 22.3%	Hard


几乎占了20%，说明了此题型的重要程度。而且难度全部是medium和hard。

最经典的就是51，52题N-Queen问题了。（分析详见印象笔记）

回溯法，试用于遍历整个数据集来获得正确答案。
一般先构造一个数据集，再往前探索，符合就可以继续往前走，不符合条件立即回退，或者到最后一层回退。
其中向前走就是把下一层的所有可能性全部扫一遍。

回溯一般有两种解法。迭代和递归。
（迭代和递归的转化桥梁，一般是栈，其实递归不也就是内部的栈实现的嘛）

先掌握递归的吧，因为递归简单。
最典型的例子就是：排列组合46 Permutations
void perm(vector<int> &num, int level){
if( level == N-1){
ret.push_back(num);
}

for(int j = level; j < N; j++){
swap(num[level], num[j]);// 交换
perm(num, level + 1); //向前一步探索
swap(num[j], num[level]);//回来
}
}

Now we study 39. Combination Sum
There is a array, and a target, find all solutions whose sum is target.
For example, given candidate set [2, 3, 6, 7] and target 7, 
All numbers and target are positive
Recursive:
同样是递归，判断条件千差万别。


仔细思考回溯，迭代，递归，和二叉树DFS(深度优先搜索)的关系

https://leetcode.com/submissions/detail/64962974/
这个答案超时了。。
主要为了去重，对中间结果使用了sort, find 。其实那个level 变量是无用的。

仔细思考这个问题：比如 2,3,6,7 求 7
2 的下一层遍历 2,3,6,7
其实3的下一层，只要遍历3,6,7 就可以去重了，此时3可以是重复的

AC：
https://leetcode.com/submissions/detail/64966153/
但是才打败了4%的，需要改进
回溯法，结合剪枝，结合二叉树
回溯，剪枝，是一种编程思想。
二叉树是具体的数据结构





