---
title: 0276 Paint Fence
date: 2020-03-29 05:20:55
categories: LeetCode
tags:
---


There is a fence with n posts, each post can be painted with one of the k colors.

You have to paint all the posts such that no more than two adjacent fence posts have the same color.

Return the total number of ways you can paint the fence.

Note:
n and k are non-negative integers.

```txt
Example:

Input: n = 3, k = 2
Output: 6
Explanation: Take c1 as color 1, c2 as color 2. All possible ways are:

            post1  post2  post3      
 -----      -----  -----  -----       
   1         c1     c1     c2 
   2         c1     c2     c1 
   3         c1     c2     c2 
   4         c2     c1     c1  
   5         c2     c1     c2
   6         c2     c2     c1
```
有 K 种颜色. 最多两个相连的post 可以涂同一个颜色. 问一共多少种涂法.


这是一个双重 dp.

分析 在第i个柱子.

case1:  如果第i 个 和 第 i - 1个 颜色一样。第i -1 个柱子和第 i -2 个颜色就不一样
case2: 如果和第 i - 1 个柱子颜色不一样，那第i个柱子颜色 是 **第 i-1 个柱子颜色种类** 乘以  (k -1), 因为第 i 个柱子有 k - 1 种颜色可以选.

所以我们需要两个dp, 一个记录第i 个和第i-1个颜色一样，一个记录不一样.


然后考虑两个dp数组的递推公式：

dp1[i] = dp2[i-1]，这个表示如果i和i-1染一样的色，那么染色方案为dp2[i-1]

dp2[i] = (dp1[i-1] + dp2[i-1]) * (k-1)，表示i和i-1染不一样染色，对于第i-1柱子也有两种情况, 因此每一种染色方案，我们有k-1种颜色可选.

```java
class Solution {
    public int numWays(int n, int k) {
        if(n == 0 || k == 0) return 0;
        int[] dp1 = new int[n+1], dp2 = new int[n+1];
        dp1[1] = 0;
        dp2[1] = k;
        for(int i = 2; i <= n; i++) {
            dp1[i] = dp2[i-1];
            dp2[i] = (dp1[i-1] + dp2[i-1]) * (k-1);
        }
        return dp1[n] + dp2[n];
    }
}
```

状态压缩
```java
class Solution {  
    public int numWays(int n, int k) {  
            if(n == 0 || k == 0)  
                return 0;  
            if(n == 1)  
                return k;  
            int dp1 = k; 
            int dp2 = k * (k - 1);  
            for(int i = 2; i < n; i++) {  
                int a = (k - 1) * (dp1 + dp2);  
                dp1 = dp2;  
                dp2 = a;  
            }  
            return dp1 + dp2;  
        }  
}
```
