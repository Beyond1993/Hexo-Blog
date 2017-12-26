---
title: 0004 Median of Two Sorted Arrays
date: 2017-10-16 07:39:04
categories: LeetCode
tags:
---

题目描述:

There are two sorted arrays nums1 and nums2 of size m and n respectively.

Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).

Example 1:
nums1 = [1, 3]
nums2 = [2]

The median is 2.0
Example 2:
nums1 = [1, 2]
nums2 = [3, 4]

The median is (2 + 3)/2 = 2.5





先解k th 的问题，求第K小的数。



二分法的本质，取第K小 ===转化===> **舍掉k / 2 个数后，取第 k - k / 2 小**



1.对于 [1,2,5], [3,4], k = 3, k / 2 =1, k - k/2 = 2, num[A_start] < num[B_start]

等价于去掉A中的第一个后，再求第二小的数。

2. [2,3,4,5] [1] k = 4, k / 2

这种情况，应该删除小的。 B的前两个，然而B只有一个，所以是先去掉A的前两个。

3.[3,4,5] [1,2] k = 5, k - k / 2 = 3, 去掉两个求第3个了, k = 3

去掉 B的1，2， A_start = 0 + 2 = 2, 直接返回A的第3个 A_start + 3 - 1

这题还可以用quick select 去求解。 延伸到多台机器求Kth 的问题，
```java
    public double findMedianSortedArrays(int[] A, int[] B) {
      int m = A.length, n = B.length;
      int l = (m + n + 1) / 2;
      int r = (m + n + 2) / 2;
      return (getkth(A, 0, B, 0, l) + getkth(A, 0, B, 0, r)) / 2.0;
  }

    public double getkth(int[] A, int aStart, int[] B, int bStart, int k) {
      if (aStart > A.length - 1) return B[bStart + k - 1];            
      if (bStart > B.length - 1) return A[aStart + k - 1];                
      if (k == 1) return Math.min(A[aStart], B[bStart]);
      
      int aMid = Integer.MAX_VALUE, bMid = Integer.MAX_VALUE;
      if (aStart + k/2 - 1 < A.length) aMid = A[aStart + k/2 - 1]; 
      if (bStart + k/2 - 1 < B.length) bMid = B[bStart + k/2 - 1];        
      
      if (aMid < bMid) 
          return getkth(A, aStart + k/2, B, bStart, k - k/2);// Check: aRight + bLeft 
      else 
          return getkth(A, aStart, B, bStart + k/2, k - k/2);// Check: bRight + aLeft
    }
```


还可以直接用 PriorityQueue 实现
