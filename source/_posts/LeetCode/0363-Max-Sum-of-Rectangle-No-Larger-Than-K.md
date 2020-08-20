---
title: 0363 Max Sum of Rectangle No Larger Than K
date: 2018-01-25 08:17:18
categories: LeetCode
tags:
---
Given a non-empty 2D matrix matrix and an integer k, find the max sum of a rectangle in the matrix such that its sum is no larger than k.

Example:

Input: matrix = [[1,0,1],[0,-2,3]], k = 2
Output: 2 
Explanation: Because the sum of rectangle [[0, 1], [-2, 3]] is 2,
             and 2 is the max number no larger than k (k = 2).
Note:

The rectangle inside the matrix must have an area > 0.
What if the number of rows is much larger than the number of columns?


这题巧妙的应用了两个纬度上的prefix sum.

row 维度上的用 sum array

col 维度上的用 sum 的累加和来计算. 真是将区间和这一特点应用到了极点.

```cpp
int maxSumSubmatrix(vector<vector<int>>& matrix, int k) {
    if (matrix.empty()) return 0;
    int row = matrix.size(), col = matrix[0].size(), res = INT_MIN;
    for (int l = 0; l < col; ++l) {
        vector<int> sums(row, 0);
        for (int r = l; r < col; ++r) {
            for (int i = 0; i < row; ++i) {
                sums[i] += matrix[i][r];
            }
            
            // Find the max subarray no more than K 
            set<int> accuSet;
            accuSet.insert(0);
            int curSum = 0, curMax = INT_MIN;
            for (int sum : sums) {
                curSum += sum;
                set<int>::iterator it = accuSet.lower_bound(curSum - k);
                if (it != accuSet.end()) curMax = std::max(curMax, curSum - *it);
                accuSet.insert(curSum);
            }
            res = std::max(res, curMax);
        }
    }
    return res;
}
```
首先求[Maximum Sum Rectangular Submatrix in Matrix dynamic programming](https://www.youtube.com/watch?v=yCQN096CwWM)


这题用 一个 m * 1 的数组来存prefix sum. 

比如
```text
[
[1,0,1],
[0,-2,3]
[2,3,0]
]
```

以从第一列更新 作为例子
prefix sum 是 
```text
1 1  2
0 -2 1
2 5  0
```
我们在sum 数组 动态迭代的过程中，就不断的更新sum, 
**这题精妙的地方在于，在每一次更新每一行的prefix sum的同时，在col 上也做了prefix sum 的更新**

具体到代码就是

```cpp
for (int sum : sums) {
    curSum += sum;
    set<int>::iterator it = accuSet.lower_bound(curSum - k);
    if (it != accuSet.end()) curMax = std::max(curMax, curSum - *it);
    accuSet.insert(curSum);
}
```

要知道我们更新 curMax 的时候，是 max(curMax, curSum - *it), 而不是 max(curMax, curSum), 仔细想一想为什么?

因为这个最大sum 很可能不是从头开始的。
所以我们要找到 计算的这个最大 col_sum 的起始点。

这个起始点怎么算呢？ 

**lower_bound(curSum - k);**

Lower bound: first element that is greater-or-equal.

Upper bound: first element that is strictly greater.

找到第一次出现 curSum 大于等于 k 的index, 在用现在的 curSum - sum[index],
就是小于等于 k 的最大sum.

比如 sum is
```text
1

2

3

4
```

k = 5

curSum :

1 ==> Set: 0, *it = 0,  curSum - *it  = 1,  curMax = 1

2 ==> Set: 0,1 , *it = 0, curSum - *it = 2, curMax = 2

6 ==> Set: 0,1,2, *it = 1, curSum - *it = 5, curMax = 5 说明是 sum 里的 2,3

10 ==> Set: 0 ,1,2,10, *it = 6, curSum - *it = 4, curMax = 4

 
关于prefix sum的优化，在很多地方会出现。这题巧妙之处在于横向，纵向两次利用里prefix sum. 


