---
title: 0689 Maximum Sum of 3 Non-Overlapping Subarrays
date: 2018-02-21 21:25:38
categories: LeetCode
tags:
---

In a given array nums of positive integers, find three non-overlapping subarrays with maximum sum.

Each subarray will be of size k, and we want to maximize the sum of all 3*k entries.

Return the result as a list of indices representing the starting position of each interval (0-indexed). If there are multiple answers, return the lexicographically smallest one.

Example:

Input: [1,2,1,2,6,7,5,1], 2
Output: [0, 3, 5]
Explanation: Subarrays [1, 2], [2, 6], [7, 5] correspond to the starting indices [0, 3, 5].
We could have also taken [2, 1], but an answer of [1, 3, 5] would be lexicographically larger.


在一个数组中 找出 size = k 的 三个不重叠的subarray. 使其sum 最小.

 
nums  : 1,2,1,2,6, 7,5 ,1
kthSUm: 1,3,3,3,8,13,12,6
  
  
i < j < l

j - i + 1>= k

l - j + 1 >= k

searhc 'i, j, l' in kthSum, get maximum sum 

for ()
  for ()
    for ()
      
      
  
k = 2
  
kthSum[1] = sum[1] - sum[0]
  
kthSum[i] = sum[i] -  sum[i - k + 1] 


1,3,

```java
class Solution {
    public int[] maxSumOfThreeSubarrays(int[] nums, int K) {
        //W is an array of sums of windows
        int[] W = new int[nums.length - K + 1];
        int sum = 0;
        for (int i = 0; i < nums.length; i++) {
            sum += nums[i];
            if (i >= K) sum -= nums[i-K];
            if (i >= K-1) W[i-K+1] = sum;
        }
        for (int i : W) {
            System.out.println(i);
        }
      
        int[] left = new int[W.length];
        int best = 0;
        for (int i = 0; i < W.length; i++) {
            if (W[i] > W[best]) best = i;
            left[i] = best;
        }
        //kthSUm: 1,3,3,3,8,13,12,6
        
        //left : 0,1,1,1,4,5,5,5
          
        //right :5 5 5 5 5 5 6 7
      
        
        int[] right = new int[W.length];
        best = W.length - 1;
        for (int i = W.length - 1; i >= 0; i--) {
            if (W[i] >= W[best]) best = i;
            right[i] = best;
        }

        int[] ans = new int[]{-1, -1, -1};
        for (int j = K; j < W.length - K; j++) {
            int i = left[j - K], k = right[j + K];
            if (ans[0] == -1 || W[i] + W[j] + W[k] >
                    W[ans[0]] + W[ans[1]] + W[ans[2]]) {

                ans[0] = i;
                ans[1] = j;
                ans[2] = k;
            }
        }
        return ans;
    }
}
```
  
1,1,1,1,1,1
k = 2

  
2,1,2,1,2, 1,2,1,2,1
3,3,3,3,3, 3,3,3,3,3


0,0,0,0,0, 0,0,0,0,0
  
 
0,1,2,3,4, 5,6,7,8,9  

  
j = 2, j - K = 0, j + K = 4 ==> 9 [0,2,4]

j = 3 ==> 9 ==> [1,3,5]

