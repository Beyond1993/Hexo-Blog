---
title: 0031 Next Permutation
date: 2018-02-20 01:25:11
categories: LeetCode
tags:
---

这题没啥算法，就是找规律。

1. 从后往前排， 找到第一个降序 A(x)
2. 从后往前排，找到第一个比 A(x) 大的数 A(y)
3. 交换 A(x), A(y)
4. 将 x 之后的数字重新排序

http://www.wayne.ink/2019/08/31/LeetCode/0556-Next-Greater-Element-III/

```java
class Solution {
    public void nextPermutation(int[] nums) {
        int i = nums.length - 1;
        while(i > 0) {
            if (nums[i-1] < nums[i]) { break; }
            i--;
        }
        if (i == 0) {
            if (nums.length > 1 && nums[1] < nums[0]) {
                reverse(nums, 0);
                return;
            }
            return;
        }
        int j = nums.length - 1;
        
        while(nums[j] <= nums[i - 1]) { j--; }
        
        swap(nums, i - 1, j);
        reverse(nums, i);
    }
    private void swap(int[] nums, int i, int j) {
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }
    
    private void reverse(int[] nums, int i) {
        int j = nums.length - 1;
        while(i < j) {
            swap(nums, i, j);
            i++;
            j--;
        }
    }
}
```

```python
class Solution:
    def nextPermutation(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        n = len(nums)
        i = n - 2
        
        # Step 1: Find the breakpoint
        ## 如果是倒序排序，比如 [3,2,1] 那 i = -1
        ## 后面刚好 nums[i + 1:] 就是整体reverse
        
        while i >= 0 and nums[i] >= nums[i + 1]:
            i -= 1

        if i >= 0:
            # Step 2: Find the smallest element larger than nums[i]
            j = n - 1
            while nums[j] <= nums[i]:
                j -= 1
            # Swap nums[i] and nums[j]
            nums[i], nums[j] = nums[j], nums[i]
        
        # Step 3: Reverse the subarray to the right of i
        nums[i + 1:] = reversed(nums[i + 1:])
```

直接交换 i 和 i + 1 在某些情况下是不正确的，因为这并不总是生成下一个字典序更大的排列。

让我们用一个例子来说明为什么需要寻找比 nums[i] 稍大的最小元素 (nums[j])，而不是直接交换 nums[i] 和 nums[i + 1]。

例子：nums = [1, 3, 5, 4, 2]
Step 1: 找到第一个下降点 i
从右向左找到第一个满足 nums[i] < nums[i + 1] 的位置：
nums[2] = 5 和 nums[3] = 4 → 不满足，继续找。
nums[1] = 3 和 nums[2] = 5 → 满足，所以 i = 1。
如果直接交换 i 和 i + 1：
nums[i] = 3，nums[i + 1] = 5，交换后变成：
nums = [1, 5, 3, 4, 2]
显然，这并不是下一个字典序更大的排列，因为还有更小的可能性。

正确的方法：找到比 nums[i] 稍大的最小元素
1. 从右向左寻找第一个比 nums[i] 大的元素 nums[j]：
nums[j] = 4 是比 nums[i] = 3 大的最小元素。
2. 交换 nums[i] 和 nums[j]：
nums = [1, 4, 5, 3, 2]
3. 反转 i + 1 之后的子数组，使得子数组变为最小字典序：
nums = [1, 4, 2, 3, 5]
这才是下一个字典序更大的排列。

而且交换之后，由于交换的是比 i 大的最小元素，变成 [1, 4, 5, 3, 2], 
i 后面是严格递减的， 所以倒转之后就变成严格递增了。刚好是最小序


