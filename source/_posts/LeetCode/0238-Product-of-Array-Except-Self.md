---
title: 0238 Product of Array Except Self
date: 2019-06-24 00:15:33
categorieso: LeetCode
tags:
---

```python
class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]:
        n = len(nums)
        res = [1] * n
        
        # Calculate the product of elements to the left of each element
        left = [1] * n
        for i in range(1, n):
            left[i] = left[i-1] * nums[i-1]
        
        # Calculate the product of elements to the right of each element
        right = [1] * n
        for i in range(n-1, 0, -1):
            right[i - 1] = right[i] * nums[i]
        
        for i in range(len(left)):
            res[i] = left[i] * right[i]
        
        return res
```

```java
// 算左边的乘积，再算右边的乘积
public class Solution {
    public int[] productExceptSelf(int[] nums) {
        int[] res= new int[nums.length];
        res[0] = 1;
        for (int i = 1; i <nums.length; i++) {
            res[i] = res[i-1] * nums[i-1];
        }
        
        int right = 1;
        for(int i = nums.length -1; i >=0; i--) {
            res[i] = right * res[i];
            right = right * nums[i];
        }
        
        return res;
    }
}
```
