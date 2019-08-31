---
title: 0031 Next Permutation
date: 2018-02-20 01:25:11
categories: LeetCode
tags:
---

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



