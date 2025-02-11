---
title: 0162 Find Peak Element
date: 2019-10-18 00:22:10
categories: LeetCode
tags:
---


A peak element is an element that is greater than its neighbors.

Given an input array nums, where nums[i] ≠ nums[i+1], find a peak element and return its index.

The array may contain multiple peaks, in that case return the index to any one of the peaks is fine.

You may imagine that nums[-1] = nums[n] = -∞.

Example 1:

Input: nums = [1,2,3,1]
Output: 2
Explanation: 3 is a peak element and your function should return the index number 2.
Example 2:

Input: nums = [1,2,1,3,5,6,4]
Output: 1 or 5 
Explanation: Your function can return either index number 1 where the peak element is 2, 
             or index number 5 where the peak element is 6.

对于 左右两个端点，比如index 0, index -1 缺失，说明就是比左边大，同理index Len - 1 也是
比如 [6,5,4,3,2,6,4], peak index is 0


```java
public class Solution {
    public int findPeakElement(int[] nums) {
        
        int start = 0;
        int end = nums.length - 1;
        
        while(start < end) {
            int mid = start + (end - start) / 2;
            if (nums[mid] <= nums[mid+1]) {
                start = mid + 1;
            } else {
                end = mid;
            }
        }
        
        return start;
        
    }
}
```

```python
class Solution:
    def findPeakElement(self, nums: List[int]) -> int:
        
        ## 和左右邻居 判断，如果自己是peak， 就返回
        ## 如果自己不是peak, 就是比自己大的那一边找，因为只要这个邻居比自己大，
        ## 不管这个邻居之后是递增还是递减，之后答案肯定在这边

        l, r = 0, len(nums) - 1

        while l <= r:
            m = l + ((r - l) // 2)
            if m > 0 and nums[m] < nums[m - 1]:
                r = m -1
            elif m < len(nums) - 1 and nums[m] < nums[m + 1]:
                l = m + 1
            else:
                return m
        return 0
```

这个二分法其实不太对，用了左右都是闭区间的写法，
如果用左闭右开的写法，应该是这样:
```python
class Solution:
    def findPeakElement(self, nums: List[int]) -> int:
        
        ## 和左右邻居 判断，如果自己是peak， 就返回
        ## 如果自己不是peak, 就是比自己大的那一边找，因为只要这个邻居比自己大，
        ## 不管这个邻居之后是递增还是递减，之后答案肯定在这边

	# 注意这里r = len(nums), 不是 len(nums) - 1
        l, r = 0, len(nums)

        while l < r:
            m = l + ((r - l) // 2)
            if m > 0 and nums[m] < nums[m - 1]:
                r = m
            elif m < len(nums) - 1 and nums[m] < nums[m + 1]:
                l = m + 1
            else:
                return m
        return 0
```

follow up:
Finding a local minimum is very similar to finding a peak. A local minimum is an element that is smaller than its neighbors. Again, we can use a binary search approach for O(log n) time complexity.

```python
def findLocalMin(nums):
    left, right = 0, len(nums) - 1

    while left < right:
        mid = (left + right) // 2

        if nums[mid] < nums[mid + 1]:
            # You're in the ascending part of the array
            # The local minimum is on the left (including mid)
            right = mid
        else:
            # You're in the descending part of the array
            # The local minimum is on the right
            left = mid + 1

    # left and right converge to the local minimum
    return left
```

