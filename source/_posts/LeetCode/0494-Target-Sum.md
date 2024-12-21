---
title: 0494 Target Sum
date: 2018-01-26 00:01:37
categories: LeetCode
tags:
---

You are given a list of non-negative integers, a1, a2, ..., an, and a target, S. Now you have 2 symbols + and -. For each integer, you should choose one from + and - as its new symbol.

Find out how many ways to assign symbols to make sum of integers equal to target S.

Example 1:
Input: nums is [1, 1, 1, 1, 1], S is 3. 
Output: 5
Explanation: 

-1+1+1+1+1 = 3
+1-1+1+1+1 = 3
+1+1-1+1+1 = 3
+1+1+1-1+1 = 3
+1+1+1+1-1 = 3

brute force
```python
class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        
        count = 0
        def dfs(i, sum_):
            nonlocal count
            if i == len(nums) - 1:
                if sum_ == target:
                    count += 1
                return
            dfs(i + 1, sum_ + nums[i + 1])
            dfs(i + 1, sum_ - nums[i + 1])
        dfs(-1, 0)
        return count
```
accepted
```python
from typing import List

class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        # Using memoization to store results for overlapping subproblems
        memo = {}

        def dfs(i, curr_sum):
            # Base case: if we've processed all numbers
            if i == len(nums):
                return 1 if curr_sum == target else 0
            
            # Check if the result is already computed
            if (i, curr_sum) in memo:
                return memo[(i, curr_sum)]
            
            # Recursive case: add or subtract the current number
            add = dfs(i + 1, curr_sum + nums[i])
            subtract = dfs(i + 1, curr_sum - nums[i])
            
            # Store the result in the memoization dictionary
            memo[(i, curr_sum)] = add + subtract
            return memo[(i, curr_sum)]

        # Start recursion from the first index with a sum of 0
        return dfs(0, 0)
```

There are 5 ways to assign symbols to make the sum of nums be target 3.
Note:
The length of the given array is positive and will not exceed 20.
The sum of elements in the given array will not exceed 1000.
Your output answer is guaranteed to be fitted in a 32-bit integer.

这题第一反应就是二维DP

dp[i][j] 表示遍历到第i个数, sum 为 j 的种类，但是这题的j 的范围不能简单的设成0 ~ S. 而是 sum(-nums)  ~ sum(nums)之间. 这样字搜索的空间复杂度就很大，相当于把sum 的所有种类都要遍历到。

Solution 1:
Brute force: DFS
Time complexity O(2^n) AC, 585 ms
Space complexity O(n)

元素的个数是20 没有问题.


//LC494

Input: nums is [1, 1, 1, 1, 1], S is 3. 
Output: 5
Explanation: 

-1+1+1+1+1 = 3
+1-1+1+1+1 = 3
+1+1-1+1+1 = 3
+1+1+1-1+1 = 3
+1+1+1+1-1 = 3

There are 5 ways to assign symbols to make the sum of nums be target 3.

```c++
class Solution0 {
public:
    int counts=0;
    int findTargetSumWays(vector<int>& nums, int S) {
        dfs(nums,S,0,0);
        return counts;
    }
    void dfs(vector<int>&nums, int target, int index, int sum){

        if(index == nums.size()){
            if(sum==target) {
                counts++;
                return;
            }
            else return;
        }

        dfs(nums,target,index+1, sum+nums[index]);
        dfs(nums,target,index+1, sum-nums[index]);
    }
};
```

<index sum> count ==>

//nums is [1, 1, 1, 1, 1], S is 3.

//dp[1] . map<sum, count>
//dp[2]
//dp[3]  

//O(
```c++ 
class Solution1 {
public:
    int findTargetSumWays(vector<int>& nums, int S) {
        vector<unordered_map<int, int>> dp(nums.size());
        
        return helper(nums, S, 0, dp);
    }
    int helper(vector<int>& nums, int sum, int start, vector<unordered_map<int, int>>& dp) {
        if (start == nums.size()) return sum == 0;
        
        //memoization
        if (dp[start].count(sum)) return dp[start][sum];
        
        int cnt1 = helper(nums, sum - nums[start], start + 1, dp);
        int cnt2 = helper(nums, sum + nums[start], start + 1, dp);
        
        return dp[start][sum] = cnt1 + cnt2;
    }
};
```

```txt
   0 , 1
   /   \
  0,1  0,1
```
2 ^ n


http://collabedit.com/4gjd8

```java
public class Solution {
    public int findTargetSumWays(int[] nums, int s) {
        int sum = 0; 
        for(int i: nums) sum+=i;
        if(s>sum || s<-sum) return 0;
        int[] dp = new int[2*sum+1];
        dp[0+sum] = 1;
        for(int i = 0; i<nums.length; i++){
            int[] next = new int[2*sum+1];
            for(int k = 0; k<2*sum+1; k++){
                if(dp[k]!=0){
                    next[k + nums[i]] += dp[k];
                    next[k - nums[i]] += dp[k];
                }
            }
            dp = next;
        }
        return dp[sum+s];
    }
}
```



//Definition
//dp[i][j] 到index 为i的时候 sum为j 的counts

[0]

//Init
//dp[0][nums[0]] = 1
//dp[0][-nums[0]] += 1


* --> *
|
V
*
    
  
 * --> *
       ^
       | 
       *   
//Func
if (dp[i-1][sum]){
  dp[i][sum+nums[i]] += dp[i-1][sum]
  dp[i][sum-nums[i]] += dp[i-1][sum]
}


//return

return dp[nums.length][S]


```c++
public class Solution {
    public int findTargetSumWays(int[] nums, int S) {
        int[][] dp = new int[nums.length][2001];
        dp[0][nums[0] + 1000] = 1;
        dp[0][-nums[0] + 1000] += 1;
        for (int i = 1; i < nums.length; i++) {
            for (int sum = -1000; sum <= 1000; sum++) {
                if (dp[i - 1][sum + 1000] > 0) {
                    dp[i][sum + nums[i] + 1000] += dp[i - 1][sum + 1000];
                    dp[i][sum - nums[i] + 1000] += dp[i - 1][sum + 1000];
                }
            }
        }
        return S > 1000 ? 0 : dp[nums.length - 1][S + 1000];
    }
}

class Solution {
    public int findTargetSumWays(int[] nums, int S) {
       
        int sum = 0; 
        for(int i: nums) {
            sum += i;
        }
        if(S > sum || S < -sum) return 0;
        int[][] dp = new int[nums.length][2*sum+1];
        
        //dp[0][0+sum] = 1;
        
        dp[0][nums[0]+sum] = 1;
        dp[0][-nums[0]+sum] += 1;
        
        for(int i = 0; i < nums.length - 1; i++){
            
            for(int k = -sum; k <= sum; k++){
                if(dp[i][k+sum]!=0){
                    dp[i+1][k +sum + nums[i+1]] += dp[i][k+sum];
                    dp[i+1][k +sum - nums[i+1]] += dp[i][k+sum];
                }
            }
        }
        return dp[nums.length - 1][S+sum];
    }
}


        for (int i = 1; i < nums.length; i++) {
            for (int sum = -1000; sum <= 1000; sum++) {
                if (dp[i - 1][sum + 1000] > 0) {
                    dp[i][sum + nums[i] + 1000] += dp[i - 1][sum + 1000];
                    dp[i][sum - nums[i] + 1000] += dp[i - 1][sum + 1000];
                }
            }
        }
```        
        
        
  
  [1,0] 1 
