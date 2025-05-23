---
title: 0128 Longest Consecutive Sequence
date: 2019-09-20 03:00:27
categories: LeetCode
tags:
---

Given an unsorted array of integers, find the length of the longest consecutive elements sequence.

Your algorithm should run in O(n) complexity.

Example:

Input: [100, 4, 200, 1, 3, 2]
Output: 4
Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.

// 100, 99, 101, 1
// 4 3, 5, len 1
    
    
// 1, len = 1
// 3, 4  ==> len 2
    
// 2, left 1, right 2 ==> 4, 

// 3 len 2
// 4 len 4
// 1 len 4
    
// 0  1,2,3,4   5,6,7..    
只需要跟新 两端的节点，因为中间的访问不到。


```java
class Solution {
    public int longestConsecutive(int[] nums) {
        int res = 0;
        Map<Integer, Integer> map = new HashMap<>();
        for (int n : nums) {
            if (!map.containsKey(n)) {
                int left = map.getOrDefault(n - 1, 0);
                int right = map.getOrDefault(n + 1, 0);
                int sum = left + 1 + right;
                res = Math.max(res, sum);
                map.put(n, sum);
                map.put(n - left, sum);
                map.put(n + right, sum);
            }
        }
        return res;
    }
}
```

```python
class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        nums = list(set(nums))
        unionMap = {}

        for i in range(len(nums)):
            curV = nums[i]
            if curV in unionMap: continue
            upper = curV + 1
            lower = curV - 1

            if upper in unionMap and lower in unionMap:
                upperInterval = unionMap.pop(upper)
                lowerInterval = unionMap.pop(lower)
                unionMap[upperInterval[1]] = [lowerInterval[0], upperInterval[1]]
                unionMap[lowerInterval[0]] = [lowerInterval[0], upperInterval[1]]

            elif upper in unionMap and lower not in unionMap:
                upperInterval = unionMap.pop(upper)
                unionMap[curV] = [curV, upperInterval[1]]
                unionMap[upperInterval[1]] = [curV, upperInterval[1]]
            elif upper not in unionMap and lower in unionMap:
                lowerInterval = unionMap.pop(lower)
                unionMap[lowerInterval[0]] = [lowerInterval[0], curV] 
                unionMap[curV] = [lowerInterval[0], curV]
            else:
                unionMap[curV] = [curV, curV]
            ##print("curV", curV, unionMap)

        res = 0
        for value in unionMap.values():
            #print(value)
            res = max(res, value[1] - value[0] + 1)
        return res
```
            
union find 


比较直观的一个方法，先转成set，然后 通过 num - 1 是否在 num_set 里找到这个序列的起点, 如果是起点，就连续的判断，得到一个可能解，每个元素只会被遍历一次，所以是 O（N）

```python
class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        num_set = set(nums)
        max_streak = 0

        for num in num_set:
            if num - 1 not in num_set:
                current_num = num
                current_streak = 1

                while current_num + 1 in num_set:
                    current_num += 1
                    current_streak += 1
                
                max_streak = max(max_streak, current_streak)
        return max_streak
```


