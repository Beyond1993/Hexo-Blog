---
title: 1052. Grumpy Bookstore Owner
date: 2021-01-17 06:44:36
categories: LeetCode
tags:
---

Today, the bookstore owner has a store open for customers.length minutes.  Every minute, some number of customers (customers[i]) enter the store, and all those customers leave after the end of that minute.

On some minutes, the bookstore owner is grumpy.  If the bookstore owner is grumpy on the i-th minute, grumpy[i] = 1, otherwise grumpy[i] = 0.  When the bookstore owner is grumpy, the customers of that minute are not satisfied, otherwise they are satisfied.

The bookstore owner knows a secret technique to keep themselves not grumpy for X minutes straight, but can only use it once.

Return the maximum number of customers that can be satisfied throughout the day.

 

Example 1:

Input: customers = [1,0,1,2,1,1,7,5], grumpy = [0,1,0,1,0,1,0,1], X = 3
Output: 16
Explanation: The bookstore owner keeps themselves not grumpy for the last 3 minutes. 
The maximum number of customers that can be satisfied = 1 + 1 + 1 + 1 + 7 + 5 = 16.
 

Note:

1 <= X <= customers.length == grumpy.length <= 20000
0 <= customers[i] <= 1000
0 <= grumpy[i] <= 1



暴力解:

把每个长度为 X 的可能性找到，再算出这个窗口之外的满意人数


```java
class Solution {
    public int maxSatisfied(int[] customers, int[] grumpy, int X) {
        int len = customers.length;
        int count = 0;
        for(int i = 0 ; i < len; i++) {
            count += grumpy[i] == 0 ? customers[i] : 0;
        }
        int sum = 0;
        for(int i = 0; i < X; i++) {
            sum += grumpy[i] == 1 ? customers[i] : 0;
        }
        int res = sum;
        int left = 0;
        int right = X;
        while(right < len) {
            //remove from x windows, 
            sum -= grumpy[left] == 1 ? customers[left] : 0;
            sum += grumpy[right] == 1 ? customers[right] : 0;
            res = Math.max(res,sum);
            left++;
            right++;
        }
        return count + res;
    }
}
```


动态规划:

