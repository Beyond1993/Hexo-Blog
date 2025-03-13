---
title: 0560 Subarray Sum Equals K
date: 2018-02-17 20:24:22
categories: LeetCode
tags:
---

Given an array of integers and an integer k, you need to find the total number of continuous subarrays whose sum equals to k.

Example 1:
Input:nums = [1,1,1], k = 2
Output: 2
Note:
1.The length of the array is in range [1, 20,000].
2.The range of numbers in the array is [-1000, 1000] and the range of the integer k is [-1e7, 1e7].

如果都是正数，这种解法是可以的，但是考虑负数， 1,1,-1,1, 对于这种情况 2 会出现两次， 如果k - 
```python
class Solution:
    def subarraySum(self, nums: List[int], k: int) -> int:
        sum_ = 0
        sum_set = set()
        sum_set.add(0)
        count = 0
        for num in nums:
            sum_ += num
            if (sum_ - k) in sum_set:
                count += 1
            sum_set.add(sum_)
        return count
```
正确答案 :

```python
def subarraySum(self, nums: List[int], k: int) -> int:
        count, sum_ = 0, 0
        map_ = {}
        map_[0] = 1
        for num in nums:
            sum_ += num
            if sum_ - k in map_:
                count += map_[sum_ - k]
            map_[sum_] = map_.get(sum_, 0) + 1
        return count
```

map{0, 1} 是为了整个数组的sum 是 k, 比如 [1,2,3] k = 6

如果没有, map {0, 1}, 最后一次就会漏掉。

然后为什么不能用 set(), 

因为要记录 sum - k  的次数， 比如

1, 1, 1, -1, 1, 1

k = 2

当 i 是 5 的时候，sum - k = 4 - 2 = 2, 就是 以 i = 5 为结尾的， 有多少 数组和为k, 这时候就是看之前 sum - k = 2 的prefix  sum 有几个。

```java
public int subarraySum(int[] nums, int k) {
  Map<Integer, Integer> map = new HashMap<>();
  int result = 0, sum = 0;
  map.put(0,1);
  for (int i = 0; i < nums.length; i++) {
    sum += nums[i];
    result += map.getOrDefault(sum - target, 0);
    map.put(sum, map.getOrDefault(sum,0) + 1);
  }
  return result;
}
```

```java
class Solution {
    public int subarraySum(int[] nums, int k) {
       HashMap<Integer,Integer> map = new HashMap<>();
        map.put(0,1);
        int res = 0;
        int sum = 0;
        for (int i=0;i<nums.length;i++) {
            sum += nums[i];
            if (map.containsKey(sum-k)) {
                res+=map.get(sum-k);
            }
            map.put(sum,map.getOrDefault(sum,0)+1);
        }
        return res;
    }
}
```
sum - k 就是之前算好的 sum `

错误答案，这题不能用slid window
```java
class Solution {
    public int subarraySum(int[] A, int t) {
       int i = 0, j = 0;
       int winSum = 0;
        int res = 0;
        while(i < A.length && j < A.length) {
            winSum += A[j];
            if (winSum == t) {
                res++;
                j++;
            } else if (winSum < t) {
                j++;
            } else {
                winSum -= A[i];
                i++;
                j++;
            }
        }
        return res;
    }
}
```
