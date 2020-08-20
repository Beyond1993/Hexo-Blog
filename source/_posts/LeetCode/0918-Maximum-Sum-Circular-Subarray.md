---
title: 0918  Maximum Sum Circular Subarray
date: 2020-07-12 03:32:06
categories: LeetCode
tags:
---

Given a circular array C of integers represented by A, find the maximum possible sum of a non-empty subarray of C.

Here, a circular array means the end of the array connects to the beginning of the array.  (Formally, C[i] = A[i] when 0 <= i < A.length, and C[i+A.length] = C[i] when i >= 0.)

Also, a subarray may only include each element of the fixed buffer A at most once.  (Formally, for a subarray C[i], C[i+1], ..., C[j], there does not exist i <= k1, k2 <= j with k1 % A.length = k2 % A.length.)

Example 1:

Input: [1,-2,3,-2]
Output: 3
Explanation: Subarray [3] has maximum sum 3
Example 2:

Input: [5,-3,5]
Output: 10
Explanation: Subarray [5,5] has maximum sum 5 + 5 = 10
Example 3:

Input: [3,-1,2,-1]
Output: 4
Explanation: Subarray [2,-1,3] has maximum sum 2 + (-1) + 3 = 4
Example 4:

Input: [3,-2,2,-3]
Output: 3
Explanation: Subarray [3] and [3,-2,2] both have maximum sum 3
Example 5:

Input: [-2,-3,-1]
Output: -1
Explanation: Subarray [-1] has maximum sum -1

Note:
1. -30000 <= A[i] <= 30000
2. 1 <= A.length <= 30000


在数组中求最大 sum, 可以循环。

### 错误思路

数组乘以数量扩一倍，然后找连续正数
```java
class Solution {
    public int maxSubarraySumCircular(int[] A) {
        int[] nums = new int[A.length * 2];
        
        for (int i = 0; i < A.length; i++) {
            nums[i] = A[i];
            nums[i+A.length] = A[i];
        }
        
        int right = 0;
        int left = 0;
        int sum = 0;
        int maxSum = 0;
        
        while (right < nums.length) {
            if (nums[right] <= 0) {
                right++;
                //continue;
            }
            else { //> 0
                if (right >= nums.length - 1) {
                    break;   
                }
                left = right;
                while(nums[right] >= 0 
                      && right - left < A.length) {
                    sum += nums[right];
                    right++;
                }
                
                if (right - left >= A.length) {
                    left++;
                    sum -= nums[left];
                    maxSum = Math.max(sum, maxSum);
                }
                else if (nums[right] < 0) {
                    maxSum = Math.max(sum, maxSum);
                    sum = 0;
                }
                right++;
            }  
        }
        
        return maxSum;
    }
}
```

### preSum 
```java
class Solution {
    public int maxSubarraySumCircular(int[] A) {
        int[] nums = new int[A.length * 2];
        int maxSum = Integer.MIN_VALUE;
        boolean allNegtive = true;
        for (int i = 0; i < A.length; i++) {
            nums[i] = A[i];
            nums[i+A.length] = A[i];
            maxSum = Math.max(maxSum, A[i]);
            if (A[i] > 0) {
                allNegtive = false;
            } 
        }
        
        if (allNegtive) {
            return maxSum;
        }
        
        int[] preSum = new int[nums.length];
        int sum = 0;
        for (int i = 0; i < nums.length; i++) {
            sum += nums[i];
            preSum[i] = sum; 
        }
        
        int right = 0;
        int left = 0;
        
        int lastMinIndex = 0;
        int lastMaxIndex = 0;
        int localSum = 0;
        
        while (right < nums.length) {
            if (right - left == A.length - 1) {
                left++;
                localSum = 0;
                
            } else {
                localSum += nums[right];
                maxSum = Math.max(maxSum, localSum);
            }
            if (preSum[right] < preSum[lastMinIndex]) {
                lastMinIndex = right;
            }
            
            if (preSum[right] > preSum[lastMaxIndex]) {
                lastMaxIndex = right;
            }
            
            if (lastMaxIndex >= lastMinIndex && lastMaxIndex - lastMinIndex < A.length)  {
                maxSum = Math.max(maxSum, preSum[lastMaxIndex] - preSum[lastMinIndex]);
            }
        
            right++;
        }
        
        return maxSum;
    }
    
}
```

### 答案

```java
public int maxSubarraySumCircular(int[] A) {
        int total = 0, maxSum = A[0], curMax = 0, minSum = A[0], curMin = 0;
        for (int a : A) {
            curMax = Math.max(curMax + a, a);
            maxSum = Math.max(maxSum, curMax);
            curMin = Math.min(curMin + a, a);
            minSum = Math.min(minSum, curMin);
            total += a;
        }
        return maxSum > 0 ? Math.max(maxSum, total - minSum) : maxSum;
    }
```
