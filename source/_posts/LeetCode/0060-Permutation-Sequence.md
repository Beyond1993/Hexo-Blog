---
title: 0060 Permutation Sequence
date: 2017-12-31 22:08:59
categories: LeetCode
tags:
---

The set [1,2,3,…,n] contains a total of n! unique permutations.

By listing and labeling all of the permutations in order,
We get the following sequence (ie, for n = 3):

"123"
"132"
"213"
"231"
"312"
"321"
Given n and k, return the kth permutation sequence.

Note: Given n will be between 1 and 9 inclusive.

```java
public String getPermutation(int n, int k) {
    List<Integer> nums = new ArrayList<Integer>();
    int factor = 1;
    for (int i = 0; i < n; i++) {
        nums.add(i+1);
        if (i != n-1) {
            factor *= nums.get(i);
        }
    }
    k--;
    StringBuilder sb = new StringBuilder();
    for (int i = n-1; i >= 0; i--) {
        int index = k / factor; 说明有index个数, 比第一位这个数字小，应该是index + 1
        k = k % factor;
        sb.append(String.valueOf(nums.get(index)));
        nums.remove(index);
        //System.out.println(sb.toString());
        if (i  > 0) {
            factor = factor / i;
        }
    }
    return sb.toString();
}
```

注意这里用来一个数组来存储, 第 index + 1 个数是多少？ 因为用过一次就要去除，所以不能直接简单的 index + 1
