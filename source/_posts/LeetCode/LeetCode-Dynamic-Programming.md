---
title: LeetCode-Dynamic-Programming
date: 2017-12-26 20:39:15
categories: LeetCode-Index
tags:
---
写在之前：

动态，规划。算是比较抽象的思维了。

如何判定一题可以用DP解，
1. 规划，规划就是决策，所以动态规划的题必定是 决策行的，每一步，既可以选择这个，又可以选择那个。不确定。但只有一个是最优解。 比如说打气球。 打第一个可以，打第n个也可以，那么打哪个最好呢。
若果一个问题是决策型问题，是有八九是DP

2. 动态，找出动态关系，就能找到转移方程，比如打气球，我打爆一个气球，还要算两边气球的值，两边的气球又是不确定的。这是动态。



背包，树型，计数动态规划.


动态规划：
1.四要素：状态方程，初始化，答案
四种基本类型：
矩阵型，单序列型 双序列型 背包型

矩阵型： 10, 
单序列型
双序列型
背包行

<!-- more -->
1.爬梯子，h阶梯子，一次只能爬一阶或两阶，
状态：a[0]-a[n-1]代表第i+1个台阶的解法数
方程：a[i]-a[i-1]+a[i-2]，到达第一阶的方法数十到达前两级的方法数
初始化，a[0]=1，a[1]=2
答案：a[n-1]

198.Howse Robber 单
状态，一维数组，a[i]代表第i间房子能获得的最大收益
方程 a[i]=maximput[i]+a[i-1],
          抢这间房子   不抢这间房子
初始化：a[0]=impnt[0]
        a[1]=max(a[1],a[0])

121.买卖股票
1.买卖一次，先买再卖
状态 max，low
方程 low=a[i]<low?a[i];low
     Max=a[i]-low>max?a[i]-low;max
初始化：max=0，low=Integer。Max
答案：max


交易次数不限，一次只能交易一次，求最大

如1，2，7，5，8，9=&gt;result=（7-1）+（9-5）6+4=10
      =（2-1）+（7-2）+（8-5）+（9-8）
状态：sum
方程：sum十二a[i]&gt;a[i-1]?a[i]-a[i-1]=0;
初始化：sum=0；
答案：sum

最多交易两次，手上最多只能有一支股票，最大收益
双序列动态，归化：超时？？？
    状态：preprofit[i]，表示第0到第i天最大收益
          preprofit[i]，表示第i+1到n-1天，最大收益
    方程：preprofit[i] 调用1  超时
          preprofit[i]
   初始化：preprofit[i]=0
           preprofit[i]=0
          for inti=0  i<n-1,i++1}
    答案   ,mav(prepirheli)+postprofitli]);

原因是计算preprofit[i] postprofie[i]时
for(int i=0li&lt;n;i++){
   preporfit[i]=get max Before(price,);
 } preporfit[i]=get max post (price,);
O(n2)

现在的要求是用O（n）解决
用正向扫描preprofit[i]表示，0，i-1的最大利润
用反向扫描preprofit[i]表示i-1的最大利润
反向用high-prices[i]
是一个用curmax，记录之前遍历的最大值
Math.Max（curmax，prices[i]-low）
Math.max（curmax，high-prices[i]）；
为什么不能和前一个，或后一个代？可以问！



动态规划问题之所以难，是因为他的抽象性，其更接近于计算机思维，而不是直观的逻辑思维．



１.1 动态规划入门 01 背包问题．



http://blog.csdn.net/mu399/article/details/7722810





01 背包是最基础也是最重要的背包问题，完全背包和多重背包问题都能转化成０，１背包来解决．



有Ｎ件物品，总承重为W的背包, 第ｉ件物品的重量是Wi, 价值是Vi. 求怎么放这些物品价值最大．



基本思路：二维数组 F[i][w] 

表示前ｉ个物品，放入背包总承重为w的最大价值．

本质：第i 个物品放不放的问题



放： 价值为 f[i-1][w - Wi] + Vi， 往回找到w-Wi 列的值．

不放: 价值为 f[i-1][w]





状态转移方程：

f[i][w] = max{ f[i-1][w], f[i-1][ w - Wi] + Vi;



空间复杂度优化到O(w)， 用一维数组．



恰好装满背包： F[0]  初始化为 0, 其他 F[1..V] 初始化为 −∞

不要求装满背包： 全部初始化为０

 

1.2 完全背包问题

每种物品的数量是限的．

最简单思路： 转化为每种物品取⌊V /Ci⌋个．



1.3 多重背包问题．

多重背包问题是每个物品个数限制是Mi 个， 同样可以拆分成 Mi 个等重，等值的物品，这样就可以转换成0,1 背包问题．



1.4 组合背包问题

这是我自己想出来的背包问题．使得拿出的物品价值刚好为一个目标值．共有多少种解法．





变种题：找零钱． target sum, leetcode 416



其实大多数情况下，动态规划的问题都能通过回溯法来解决．面试中可以先提出回溯的解法,再通过动态规划来优化. 但是递归的时间复杂度往往是指数级别的．


10  Regular Expression Matching  24.3%  Hard  
32  Longest Valid Parentheses  23.2%  Hard  
44  Wildcard Matching  20.7%  Hard  
53  Maximum Subarray  40.0%  Easy  
62  Unique Paths  42.1%  Medium  
63  Unique Paths II  32.0%  Medium  
64  Minimum Path Sum  39.6%  Medium  
70  Climbing Stairs  40.7%  Easy  
72  Edit Distance  32.3%  Hard  
85  Maximal Rectangle  29.0%  Hard  
87  Scramble String  29.5%  Hard  
91  Decode Ways  20.1%  Medium  
95  Unique Binary Search Trees II  31.9%  Medium  
96  Unique Binary Search Trees  41.6%  Medium  
97  Interleaving String  25.0%  Hard  
115  Distinct Subsequences  31.9%  Hard  
120  Triangle  34.5%  Medium  
121  Best Time to Buy and Sell Stock  42.3%  Easy  
123  Best Time to Buy and Sell Stock III  30.0%  Hard  
132  Palindrome Partitioning II  24.6%  Hard  
139  Word Break  31.0%  Medium  
140  Word Break II  24.1%  Hard  
152  Maximum Product Subarray  26.4%  Medium  
174  Dungeon Game  24.0%  Hard  
188  Best Time to Buy and Sell Stock IV  24.7%  Hard  
198  House Robber  39.6%  Easy  
213  House Robber II  34.4%  Medium  
221  Maximal Square  29.8%  Medium  
256  Paint House   46.3%  Easy  
264  Ugly Number II  33.1%  Medium  
265  Paint House II   38.2%  Hard  
276  Paint Fence   34.8%  Easy  
279  Perfect Squares  37.6%  Medium  
300  Longest Increasing Subsequence  38.7%  Medium  
303  Range Sum Query - Immutable  31.2%  Easy  
304  Range Sum Query 2D - Immutable  26.5%  Medium  
309  Best Time to Buy and Sell Stock with Cooldown  41.5%  Medium  
312  Burst Balloons  43.3%  Hard  
321  Create Maximum Number  24.8%  Hard  
322  Coin Change  26.7%  Medium  
338  Counting Bits  61.9%  Medium  
343  Integer Break  46.3%  Medium  
351  Android Unlock Patterns   44.5%  Medium  
354  Russian Doll Envelopes  32.5%  Hard  
357  Count Numbers with Unique Digits  46.0%  Medium  
361  Bomb Enemy   39.7%  Medium  
363  Max Sum of Rectangle No Larger Than K  33.5%  Hard  
368  Largest Divisible Subset  33.8%  Medium  
375  Guess Number Higher or Lower II  36.0%  Medium  
376  Wiggle Subsequence  36.1%  Medium  
377  Combination Sum IV  42.5%  Medium  
392  Is Subsequence  44.6%  Medium  
403  Frog Jump  32.5%  Hard  
410  Split Array Largest Sum  38.9%  Hard  
413  Arithmetic Slices  54.6%  Medium  
416  Partition Equal Subset Sum  39.1%  Medium  
418  Sentence Screen Fitting   28.0%  Medium  
446  Arithmetic Slices II - Subsequence  27.7%  Hard  
464  Can I Win  25.3%  Medium  
466  Count The Repetitions  27.6%  Hard  
467  Unique Substrings in Wraparound String  33.1%  Medium  
471  Encode String with Shortest Length   42.8%  Hard  
472  Concatenated Words  30.7%  Hard  
474  Ones and Zeroes  39.1%  Medium  
486  Predict the Winner  45.2%  Medium  
494  Target Sum  43.8%  Medium  
514  Freedom Trail  39.1%  Hard  
516  Longest Palindromic Subsequence  42.7%  Medium  
517  Super Washing Machines  36.5%  Hard  
523  Continuous Subarray Sum  23.3%  Medium  
546  Remove Boxes  35.0%  Hard  
552  Student Attendance Record II  31.4%  Hard  
568  Maximum Vacation Days   38.5%  Hard  
576  Out of Boundary Paths  30.8%  Medium  
600  Non-negative Integers without Consecutive Ones  31.1%  Hard  
629  K Inverse Pairs Array  26.8%  Hard  
638  Shopping Offers  43.9%  Medium  
639  Decode Ways II  24.5%  Hard  
646  Maximum Length of Pair Chain  47.7%  Medium  
647  Palindromic Substrings  55.7%  Medium  
650  2 Keys Keyboard  44.7%  Medium  
651  4 Keys Keyboard   49.1%  Medium  
656  Coin Path   25.7%  Hard  
664  Strange Printer  33.3%  Hard  
673  Number of Longest Increasing Subsequence  31.3%  Medium  
688  Knight Probability in Chessboard  39.6%  Medium  
689  Maximum Sum of 3 Non-Overlapping Subarrays  41.5%  Hard  
691  Stickers to Spell Word  34.4%  Hard  
698  Partition to K Equal Sum Subsets  37.6%  Medium  
712  Minimum ASCII Delete Sum for Two Strings  51.3%  Medium  
714  Best Time to Buy and Sell Stock with Transaction Fee  42.7%  Medium  
718  Maximum Length of Repeated Subarray  40.6%  Medium  
727  Minimum Window Subsequence   31.3%  Hard  
730  Count Different Palindromic Subsequences  33.4%  Hard  
740  Delete and Earn  42.5%  Medium  
741  Cherry Pickup  22.0%  Hard  
746  Min Cost Climbing Stairs  46.3%  Easy  
750  Number Of Corner Rectangles 


