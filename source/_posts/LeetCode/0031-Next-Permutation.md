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



