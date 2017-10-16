---
title: LeetCode-Dynamic-Programming
date: 2017-09-16 20:39:15
categories: LeetCode
tags:
---


动态规划：
1.四要素：状态方程，初始化，答案
四种基本类型：
矩阵型，单序列型 双序列型 背包型

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


