---
title: Interview-Amazon-OA2-Coding
date: 2017-09-08 01:17:58
categories: Interview
tags:
---
[code](https://gitlab.com/wfeng1/Amazon-OA2)

据说还是那九题。

1. Longest Palindrome
给出一个字符串，要返回字符串内最长的回文串的长度

2. Windows Sum
给出一个integer的list或者数组和一个k size的窗口，返回这个list或数组的所有window sum，例如：
[1,3,6,7,11], window size为3，返回[10,16,24] (10=1+3+6，16=3+6+7，24=6+7+11)
注意(arraylist == null || arraylist.size() == 0)要return一个已经初始化的arrayList而不是null，否则会有一个test case过不去

3. Rectangle Overlap
Rectangle Overlap。这题和leetcode 算相交面积的区别：它帮你定义好两个类，一个叫Point，一个叫Rectangle，Rectangle包括左上右下两个Point, Point包括x, y的值.
一个长方形用左上和右下两个的代表，题目给出4个点Point(x,y)，前两个点表示第一个长方形，后两个表示第二个长方形，返回是否重叠了

4. K Closest Five
一个组织发现了外星人，要给他们通信。我们的任务是给太空中的一些有可能有外星人的点发射信号。但是由于天线质量差（真是奇怪的理由），只能给太空中的 k 个点发射信号。现在又已知一个点P，它的坐标是(0,0)，这个点周围最有可能有外星人。好了，给你N个点， 找到这个N个点中离原点P最近的k个。
实质：根据 x*x + y*y给一个数组排序么。
给出一个List&lt;Point&gt;Point是定义好的类，属性就是x和y坐标，返回离原点(0,0)最近的k个点 

5. High Five
给出一个List&lt;Score&gt;，Score两个属性，student id和分数，保证每个student id会有至少5个分数，返回类型是一个map，key是student id，value是这个id所有分数里面最高5个点平均分

6. Minimum Spanning Tree
给出一个List<Connection>，Connection类有3个属性，String name1，String name2，int cost，表示在城市1和城市2之间有有个连接，费用为cost。要求在给出的List<Connection>里面找出能以最小cost总和把所有城市连接起来而且没有环的Connection集合，返回一个List<Connection>(要求先按城市1的名字排序，相同的按城市2)，如果找不到这样的环，或者说本来输入的List<Connection>就不能把所有的城市连接起来的话，返回null。
例子1:
输入[[A,B,3],[A,C,3],[B,C,4]]，返回[[A,B,3],[A,C,3]]，因为能连起来且cost之和为6，比[[A,B,3],[B,C,4]]或[[A,C,3],[B,C,4]]的7小
例子2:
输入[[A,B,3],[A,C,3],[B,C,4],[D,E,4]]，返回null，因为不能找到把ABCDE都连起来的Connection集合，或者说连通块数量不为1

7. Copy List with Random Pointer
跟leetcode 138一样，除了random的名字变成了arbitrary
地里有人因为abritary 拼写问题，挂掉OA2, 
结构 
Node {
  int x,
  node next,
  node abritary
}
test case arbitary

8. Process Order
给一个ArrayList&lt;OrderDependency&gt;，OrderDependecy有两个属性，其实就是两个string，即process name，一个是当前的process，一个是当前process的先决process。比如当前process是C，先决process是D，意思是要执行C，一定要先执行D。最后要求返回一个次序list，比如输入是[[C,D],[D,A],[A,B],[A,E],[E,B]]，假设每个[]内前面的是当前，后面的是先决，最后输出[B,E,A,D,C]。input已经保证解的唯一性，即保证是DAG且不为空。
跟leetcode 210相似

9. Company Tree
给出一课多叉树（不是二叉树），每个节点代表公司的一个员工，节点保存的值是工作年限，然后每个节点还有一个数组保存他的下属，要求返回一个员工节点，以这个节点作为根节点的子树具有最大的平均工作年限（自己和下属的工作年限之和除以当前组人头数）。这个节点不能为叶子节点。具体例子看此文件夹下的jpg文件。

