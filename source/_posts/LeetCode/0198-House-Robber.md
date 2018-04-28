---
title: 0198 House Robber
date: 2018-04-28 01:59:45
categories: LeetCode
tags:
---

两种思路　

1. 抢还是不抢


public int rob(int[] nums) {
  int n = nums.length;
  if (n == 0) return 0;
  int[] yes = new int[n]; yes[0] = nums[0];
  int[] no = new int[n]; no[0] = 0;
  for (int i = 1; i < n; i++) {
    yes[i] = no[i-1] + nums[i];
    no[i] = Math.max(no[i-1], yes[i-1]);  
  }
  return Math.max(yes[n-1], no[n-1]);
}

2. 往前看几个
pubilc int rob(int[] nums) {
  int n = nums.length;
  if (n == 0) return 0;
  if (n == 1) return nums[0];
  int[] dp = new int[n];
  dp[0] = nums[0];
  dp[1] = Math.max(nums[0], nusm[1]);
  for (int i = 2; i < n; i++) {
    dp[i] = Math.max(dp[i-1], dp[i-2] + nums[i]);
  }
  return dp[n-1];
}

还可以空间优化
