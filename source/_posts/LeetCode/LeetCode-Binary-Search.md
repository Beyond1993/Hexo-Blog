---
title: LeetCode-Binary-Search 
date: 2017-08-23 00:14:04
categories: LeetCode-Index
tags: Binary-Search
---
基础的二分搜索是基于有序数组，不断二分，减小问题规模．这种思想可以推广到很多应用场景．

而且时间复杂度为O(logn)的也只有二分法了．

一般的二分问题都可以转移到 first position, last position

二分法，不一定是分数组，也可能是分一个数 n，选中一个条件，再根据得到的结果做出下一步判断．

二分法的本质是一个求一半一半问题来不断减少问题规模的思路，最终达到加速目的．
如： median of two sorted array 除以２， Divide Integer 乘以 2.

有些题目中要两次运用二分法
如： search for a Range, search a 2D matrix

有些二分法是和Tree, 或者 BST 相结合．

二分法模板四要点：
1. start + 1 < end  相邻或相交时退出，避免死循环
2. mid = start + (end - start) / 2 防溢出
3. mid == < >, start = mid, end = mid
4. A[start], B[start] 比较两个可能答案

模版的方法并不是直接在while中确定最优解，而是通过start + 1 < end, 保留两个可能情况

放弃九章模版, 直接判断, left = mid + 1, right = mid, return left


造成死循环的原因是，写了 left = mid, 或者 right = mid, 这样就一直跳不出来了，
如果是left = mid + 1, right = mid - 1, 就完全不会有死循


[模版](http://www.wayne.ink/2019/10/14/Algorithm/Do-you-really-know-how-to-write-a-binary-search/)

三步翻转法，对应旋转数组recover
O(1) space, O(n) time
4,5,1,2,3  ==> 1,2,3,4,5
找到上升的gap, [5,4],[3,2,1] => [1,2,3], [4,5]

二分法的难点在于二分的条件千变万化。
<!-- more -->
## 4. Median of Two Sorted Arrays
4.median of Two Sorted Arrays
首先解客kth的问题，求第k小的数
☆二分法的本质：取第K小=>舍掉k/2个数后，取第k-k/2小
①对于[1,2,5]，[3.4],k=3，k/2=1 k-k/2=2 mum[A_start] &lt;  mum [B_start]
等价于去掉A中的第一个，再求第二小的数
②[2,3,4,5], [1], k= 4,  k/2
这种情况，应该删除小的-B的前两个，然，BP，有一个，所以是先去掉A的前两个
③[3,4,5], [1,2], k= 5, k-k/2 = 3, 去掉两个求第3个，k = 3 去掉B的1,2，A_start = 0 + 2 = 2, 直接返回Aim第3个Astart+3-1



## 29. Divide Two Integers
不用乘除取模来计算除法
最直观的思路，就是减，一直减，看能减多少次
为了加速这一过程，使用2分法，使减的数乘2，当大于被除数，则从头开始


## 33. Search in Rotated Sorted Array
这题通过比较 nums[mid] 和 nums[start]  的大小，来判断哪一边是有序的。
nums[mid] > nums[start] , start ~ mid 有序
nums[mid] < nums[start], mid ~ end 有序
在有序条件下，再判断 target 是否在有序的区间

## 34 Search for a Range
这题就是用两次二分，第一次找左边界，第二次找右边界。

## 35 Search Insert Position
一般二分法

## 50 Pow(x,y)
这是一题典型的二分法将 O(n) --> O(logn)
x.pow(x,y-1) == pow(x,y/2) * pow(x,y -y/2)
有个小trick就是不能直接 return pow(x,y/2) * pow(x, y - y/2)
因为 y = 1时，y - y / 2 一直为1，stackoverflow
判断奇偶：
    n % 2 == 0 : return pow(x,y/2) * pow(x, y/2)
    n % 2 == 1 : return pow(x, y/2) * pow(x,y/2) * x
但是这样依然超时了，因为两次调用pow(x, y/2) 是多余的.
1. double v = pow(x, y/2) v*v*x 或者 v * v
2. pow(x * x, y / 2)

## 69 Sqrt(x)
就是这么简单的代码都写不好,这题用二分法就是找到 i * i <= x 的最后一个，套用九章模版

## 74 Search a 2D matrix
思路一:通过 i = mid / n, j = mid % n 将二维转化成一维
思路二:用两次二分,先确定行，在确定列

## 81 Search in Rotated Sorted Array II
有重复怎么办？1，1，1，1，3，1中找3，O(n)
当nums[start] == nums[mid] 时 start++
这题出题点在于时间复杂度为O(n)


## 153 Find-Minimum-in-Rotated-Sorted-Array
这题只能用nums[mid]和nums[end]的比较来判断，
如果用nums[mid]和nums[start]判断：
e.g. 2,3,4,5,1 nums[mid] > nums[start], 4,5,1,2,3 nums[mid] < nums[start] 
这两种情况均要从右半部分搜索.

## 154 Find Minimum in Rotated Sorted Array II
有了重复值，多一个处理 nums[mid] 和 nums[end] 相等时, end--

## 162 Find Peak Element
找到一个乱序数组中的峰值下标，（峰值是比左边大比右边小）
最朴素的想法是先找到最大值，再根据值找下标。
用二分搜索，巧妙的运用来 nums[mid] 和 nums[mid + 1] 作为比较条件

## 167 Two Sum II
Input array is sorted

典型的二分法,但感觉更像二指针

## 174 Dungeom Game
not DP?

## 209 Minimum Size Subarray Sum
two pointer ?

## 222 Count complete Tree Node
左子树右子树遍历,天然二分

## 230 Kth Smallest Element in a BST

## 240.Search a 2D Matrix II
74题是第n + 1行的第一个比第n行的最后一个大，而这题只是按行，按列递增，就不能转成一维了，从左下角开始考虑
i = row - 1, j = 0, Matrix[i][j] < target j++, matrxi[i][j] > target i--
## 270 Closest Binary Search Tree Value  

## 275 H-Index II
H—index算法：
将某作各自所有文章引用频次从大到小排列
找到cititation[index]>=index in 最后一个
返回index
注意数组index 从0开始，H-index从1开始
Ⅱ问就是这个数组开序排号，怎么化优
显然用二分法
就这样一个简单的二分法都写不好...

注意数字的值，index和H—index间关系
value     0 1 3 5 6
H—index  5 4 3 2 1
index     0 1 2 3 4

## 278 First Bad Version
First Position last position 问题

287.Find the dwphcate Number☆经典的二分法，鸽笼原理
一个n+1个数的数组，里面的值是lun
例：n=6时 1,2,3,4,5,6
n/2的一半是3 ，如果这个数组里的大于3的数的个数
这题虽然看似简单，但里面的大于，小于，小于等于的判断很难

这题记住要用两个《=和mid相比
## ☆300 longest Increasing subsequence
最长递增序列，并没有要求连续

这将birarysearch 和DP相结合，调用了Arrays，birarysearch函数
birarysearch（intc）Q.Lnt key）

必然要search（int[]o，int fromlndex，int to Lndex，int key）
            index                         找到
返回值      -（insertionposintion）-1     没找到
用i和j来遍历，或者DP，时间复杂度为0（n2）
现在要用ocnlogn，只能二分了
这题算法太巧妙了

用tails数组记录当天序列长度下所有序列最后一个元素的最小值
对于某一个数x
if（x大于tails里所有值）tails size+1，记录x
else  x 在tails里找到了，并且在i-1和i之间，则更新tails[i]

## 302 Smallest Rectangle Enclosing Black Pixels

## 349 Intersection of Two Arrays
这题用hashset 是o（mtr）
二分搜索是o（nlogn）

350.Intersection of Two Arrays Ⅱ
Hash map记录key和出现次数，挡在mam2里找时，发现一个减一个，当value<0时，说明nulls1里重复的元素在nums2里面的少

follow up
相后好序？二分
一个长，一个短，对长的二分
内存不够，外排 合并排序

## ☆354.Russiom Doll Enuelops 这就是300题，这题从二维降低一维，非常有代表性
[[5,4],[6,4],[6,7],[2,3]]=>[2,3]→[5,4] [6,7],[6,4]
对宽度升序排列，对宽度相等时，对高度降序

构造tails数组，利用Array，briary search
tails数组记录当前长度i 下，的队尾最小值

## 363.Max sun of Rectogl No larger Thank
这题类似于Range Sum Query 2D— Immntable
对于一维的高口求和[-2,0,3,-5,2,-1],先求出每个位置sum，再sum[j]-gum[i-1]
对于二维的高口求和定义一个二维sum[ ][ ]
s[i][j]表示从s[o][o]到sum[i][j]的和

先求出所有的sum后，就能得到一个o（n4）的解法了
用tree set可以将复杂度降到o（n3 logn）

## 367.Valid erfect square，判断是否为平方数
套用模板

## 374.Guess Number Higher or Lower
猜大小，套用模板

## 378 kth smallert element in a soted mattix ☆
sorted martrix 非蛇形有序，可以从左下角或右上角考虑
start=matrix[o][o]    二分法另一模板：
end=matrix[n-1][n-1]
这两条是有序的          while（start &lt; end）

1, 5, 9                            if（  ）...{
10,11,13                           start=mid+1;
12,13,15找到mid是第几小           }else}
                                    end=mid
## 392.is sub sequence
s=“abc” t=“ahbgdc” true
s=“axc” t=“ahbgdc” flase
明显是两指针

二分语的做法，实在太诡异

## 410.split Array largest sum
将数组分成pm份，得到m份中的最大和，使得这个和最小有时候二分语就是要确定答案范围
start二 maxvallue end=sum时 all numbers
条件以mid为最大和能否将数组分成m份
累加和大于mid，count就加1

## 436 Find rigne Incerval
找到最小的right intercal的下标
Novigablemap=> Tree map继承于sorted map
ceilingkey： Return the least key greater then or egual to
             give key
ceihing entry

## 441.Arranging Coins

## 454 4 sumⅡ

## 475 Heaters
这题的巧妙之处在于对每一句house，在Heaters数组里二次搜索，找出离这个House最近的两个heaters
取其半径小的
4种情况    刚好house在heater中
            不在heater，插中间
            不在heater，插头
            不在heater，插尾

## 483 smallest Good Base

## 402 Remove K Digits
 去掉数字字符串里K一个数字，使得得到的新数字最小和create Maximum类似
每次找到第一个下降转折的位置
1 0 1 2 3 4 5 5 3 的两个，删第一个，倒数第2个5
当没有下降转折时，就删除最后一个

## 394 Decode string
这题用递归代用stack靠的多，一旦发现数字，就将字符串传递下去，递归

补充两道题
利用递归实现栈的反转和排序

## 234 Palindrome Linked List
是否是回文链表
找中点，反转，逐个相比

## 266.Palindrone Permutation
判断给出的字符串能否排列成回文
Map看vohe是否全是偶数个

## 267 Palindrome remontationⅡ
给出所有回文排列的结果

如果能构成回文，奇数个数的字符小于等于1个将个数均存入Hashmap后，再用一半来回溯
还要用一个wed来标记，是否用过list（i）

## 336.palindrome Pairs

## 409 lorgest palindrome
用set来做，算奇偶，每重复出现一次coneTT

## 5.longest Polindromic substring
这题的DP要从后往前推

## 516 longest palindromic cubsequence
从后往前的动态羽化
i=slength( )-1起，j=i+1
ifs.chanAT(i)=s.charAt(j){
  dp[i][j]=dp[i+1]{j-1}+2
jecse{
 dp[i][j]=max(ap[i+1][j],dp[i][j-1])
}

## 479.largest palindrome prodmct
求两个n位数字的乘积，使得这个积是回文的，并且最大
上步n=2为例
99×99=9801 ，left=98
接下来98-1=97，拼接或9719，再判断9779是否是两个数的积



