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

