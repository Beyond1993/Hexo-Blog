---
title: 0801 Minimum Swaps To Make Sequences Increasing
date: 2020-05-22 09:38:44
categories: LeetCode
tags:
---

We have two integer sequences A and B of the same non-zero length.

We are allowed to swap elements A[i] and B[i].  Note that both elements are in the same index position in their respective sequences.

At the end of some number of swaps, A and B are both strictly increasing.  (A sequence is strictly increasing if and only if A[0] < A[1] < A[2] < ... < A[A.length - 1].)

Given A and B, return the minimum number of swaps to make both sequences strictly increasing.  It is guaranteed that the given input always makes it possible.

Example:
Input: A = [1,3,5,4], B = [1,2,3,7]
Output: 1
Explanation: 
Swap A[3] and B[3].  Then the sequences are:
A = [1, 3, 5, 7] and B = [1, 2, 3, 4]
which are both strictly increasing.
Note:

A, B are arrays with the same length, and that length will be in the range [1, 1000].
A[i], B[i] are integer values in the range [0, 2000].


这题感觉有点绕。

利用两个数组。

### case1: i th 不需要交换
例如:
```txt
      i
A 1 3 5 4
B 0 1 3 7
```

更新 swap[i], (swap[i] 从0 ~ i **累计**要换几次), 强制更新
swap[i] = swap[i-1] + 1
 
更新 noswap[i] = noswap[i-1]
```txt
1 3 5  ==> 1 1 3
0 1 3  ==> 0 3 5

i       0 1 2
swap    1 2 3
noswap  0 0 0
```

### case2: ith 需要交换

#### 大前提:   
A[i-1] < A[i] or
B[i-1] < A[i]
例如:
```txt
        i
A 1 3 5 4
B 1 2 3 7
```
更新  swap[i], 需要交换, 在大前提的条件下
swap[i] = noswap[i-1] + 1;


更新 noswap[i]，在大前提的条件下, noswap[i] = swap[i-1],
**当前位置i不交换，交换前一个位置i-1 肯定valid**
```java
class Solution {
    public int minSwap(int[] A, int[] B) {
          
    }
}
```
