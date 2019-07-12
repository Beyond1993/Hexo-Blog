---
title: 0611 Valid Triangle Number
date: 2019-07-11 01:08:45
categories: LeetCode
tags:
---

如果数据规模 >= 100 的话就不能使用n^3 算法

Given an array consists of non-negative integers, your task is to count the number of triplets chosen from the array that can make triangles if we take them as side lengths of a triangle.
Example 1:
Input: [2,2,3,4]
Output: 3
Explanation:
Valid combinations are: 
2,3,4 (using the first 2)
2,3,4 (using the second 2)
2,2,3
Note:
1. The length of the given array won't exceed 1000.
2. The integers in the given array are in the range of [0, 1000].


```java
class Solution {
    public int triangleNumber(int[] nums) {
        if (nums == null || nums.length < 3) return 0;
        nums = IntStream.of(nums).boxed().sorted(Comparator.reverseOrder())
        .mapToInt(i -> i)
        .toArray();
        
        int count = 0;
        for (int i = 0; i < nums.length - 2; i++) {
            int j = i + 1;
            int k = nums.length - 1;
            
            while (j < k) {
                if (nums[i] < nums[j] + nums[k])
                {
                    count += k - j;
                    j++;
                }
                else {
                    k--;
                }
            }
        }
        
        return count;
    }
}
```

```java
class Solution {
    public int triangleNumber(int[] nums) {
        if (nums == null && nums.length < 3) {
            return 0;
        }
        
        Arrays.sort(nums);
        int count = 0;
        for (int a = nums.length - 1; a >= 2; a--) {
            
            int b = a-1;
            int c = 0;
            while(b > c) 
            {
                if (nums[b] + nums[c] > nums[a]) {
                    count +=  b - c;
                    b--;
                } else {
                    c++;
                }
            }
        }
        return count;
    }
}
```
