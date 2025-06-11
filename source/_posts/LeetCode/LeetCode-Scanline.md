---
title: Scanline algorithm
date: 2024-10-06 07:02:22
categories: LeetCode-Index
tags:
---

https://archive.org/details/jiuzhang-algorithm/07.%E4%B9%9D%E7%AB%A0%E7%AE%97%E6%B3%95%E9%9D%A2%E8%AF%95%E9%AB%98%E9%A2%91%E9%A2%98%E5%86%B2%E5%88%BA%E7%8F%AD2021%E3%80%90%E5%AE%8C%E7%BB%93%E3%80%91/18+%E7%AC%AC%E5%8D%81%E5%85%AB%E7%AB%A0%E3%80%90%E4%BA%92%E5%8A%A8%E3%80%91%E4%BD%BF%E7%94%A8%E6%89%AB%E6%8F%8F%E7%BA%BF%E8%A7%A3%E5%86%B3%E5%8C%BA%E9%97%B4%E9%97%AE%E9%A2%98/%E3%80%90%E5%86%B2%E5%88%BA%E3%80%9118.1+%E5%90%88%E5%B9%B6%E5%8C%BA%E9%97%B4%E7%9A%84%E6%89%AB%E6%8F%8F%E7%BA%BF%E8%A7%A3%E6%B3%95.mp4


扫描线算法就是用一根扫描线, 直接去扫描所有的区间，关键点在如何表示一根线 ？可以将一个区间的起始点标记为 -1, 1 （或者 1, -1) 

然后整体按照 端点的值排序，遍历一遍，一旦 -1， 1 的累计值是0 的时候，说明这时候 start 和 end 刚好匹配，这是个大区间，否则说明还是有重叠。


这个取决于前一个区间的end 和后一个区间重叠的时候，要不要merge.

比如对于区间  [2,3] [3,4]

case1 :在merge interval 里，start 标记为 -1， end 标记为 1. 这里应该合并成一个区间 [2, 4]
所以扫描线的数组就应该是 [2,-1] [3,-1] [3, 1], [4, 1]


case2: 但是在meeting room 里，这两个区间是分开的， 可以用一个meeting room， start 标记为1， end 标记为 -1
[2, 1], [3, -1], [3, 1], [4, -1]

这里都是按第一，第二个元素 从小到大排序的

**针对case1, 这里也可以统一写成 [start, 1], [end, -1], 然后排序的时候就是 intervals.sort(key=lambda x: (x[0], -x[1])) 第二个元素从大往小排 **
