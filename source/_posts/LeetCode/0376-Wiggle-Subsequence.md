---
title: 376-Wiggle-Subsequence
date: 2024-11-03 09:31:06
categories: LeetCode
tags:
---

最长摇摆子序列

A wiggle sequence is a sequence where the differences between successive numbers strictly alternate between positive and negative. The first difference (if one exists) may be either positive or negative. A sequence with one element and a sequence with two non-equal elements are trivially wiggle sequences.

For example, [1, 7, 4, 9, 2, 5] is a wiggle sequence because the differences (6, -3, 5, -7, 3) alternate between positive and negative.
In contrast, [1, 4, 7, 2, 5] and [1, 7, 4, 5, 5] are not wiggle sequences. The first is not because its first two differences are positive, and the second is not because its last difference is zero.
A subsequence is obtained by deleting some elements (possibly zero) from the original sequence, leaving the remaining elements in their original order.

Given an integer array nums, return the length of the longest wiggle subsequence of nums.

 

Example 1:

Input: nums = [1,7,4,9,2,5]
Output: 6
Explanation: The entire sequence is a wiggle sequence with differences (6, -3, 5, -7, 3).
Example 2:

Input: nums = [1,17,5,10,13,15,10,5,16,8]
Output: 7
Explanation: There are several subsequences that achieve this length.
One is [1, 17, 10, 13, 10, 16, 8] with differences (16, -7, 3, -3, 6, -8).
Example 3:

Input: nums = [1,2,3,4,5,6,7,8,9]
Output: 2
 

Constraints:

1 <= nums.length <= 1000
0 <= nums[i] <= 1000
 

Follow up: Could you solve this in O(n) time?

解题思路:

https://www.youtube.com/watch?v=inPQObejpyU

贪心解法:

```txt
  6   7
 / \ /
4   5---5
     \
      4   5
       \ /
        3
```

比如这个例子:

4 到 6， 6 再到 5， 此时 5 的下一个数有三种情况，
第一种 7， 比5大，应该加入子序列，
第二种 和 5 一样大， 随便 取一个 5
第三种 比5 小，那就是 flag 没变，就一直把这个小的值 从 5 替换到 4， 替换到 3


```c++
class Solution {
public:
    int wiggleMaxLength(vector<int>& nums) {
        if(nums.empty()) return 0;  
        int flag = -1; // -1, 0, 1 can not use 0 , 1 
        int length = 1, prev = nums[0];  
          
        for(int i=0; i<nums.size(); ++i) {  
            if(nums[i] == prev) continue;  
            if(flag != nums[i]>prev) {  
                flag = nums[i]>prev;  
                //cout<<flag<< i <<endl;
                ++length;  
            }  
            prev = nums[i];  
        }  
          
        return length;
    }
};
```


```python
class Solution:
    def wiggleMaxLength(self, nums):
        if not nums:
            return 0
        
        flag = -1  # -1, 0, 1 where 0 means equal, -1 and 1 indicate up/down
        length = 1  # Start with the first element
        prev = nums[0]
        
        for num in nums:
            if num == prev:
                continue
            
            if flag != (num > prev):
                flag = num > prev
                length += 1
            
            prev = num
        
        return length

```

```python
class Solution:
    def wiggleMaxLength(self, nums):
        greedy = [ nums[i] > nums[i-1] for i in range(1, len(nums)) if nums[i] != nums[i-1]]

        if not greedy: return 1

        size = 2

        for i in range(1, len(greedy)):
            if (greedy[i] and not greedy[i-1]) or (not greedy[i] and greedy[i-1] ):
                size += 1

        return size
```
