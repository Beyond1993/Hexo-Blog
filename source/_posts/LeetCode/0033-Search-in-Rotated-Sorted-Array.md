---
title: 0033 Search in Rotated Sorted Array
date: 2018-02-28 05:33:02
categories: LeetCode
tags:
---

题目描述
Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.

(i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).

You are given a target value to search. If found in the array return its index, otherwise return -1.

You may assume no duplicate exists in the array.


/*（1）如果target==A[mid]，那么mid就是我们要的结果，直接返回；

（2）如果A[begin]<=A[mid]，那么说明从begin到mid一定是有序的，同样只需要判断target是否在这个范围内，如果是则把右边缘移到mid-1，否则就target在另一半，即把左边缘移到mid+1。

（3）如果A[begin]>A[mid]，那么说明从mid到last一定是有序的（没有受到rotate的影响），那么我们只需要判断target是不是在mid到last之间，如果是则把左边缘移到mid+1，否则就target在另一半，即把右边缘移到mid-1。

*/

```java
public class Solution {
    public int search(int[] nums, int target) {
        if (nums.length == 0) return -1;
        int begin = 0;
        int last = nums.length -1;
        while(begin + 1 < last){
          int mid = (begin+last)/2;
          if(nums[mid]==target) return mid;
          if(nums[mid]>=nums[begin]){ // the left is sorted
            if(nums[begin]<=target && target < nums[mid]){// if the target is the sorted area,left
              last = mid ;
            }else{ // right
              begin = mid ;
            }
          }else{ // else nums[mid] < num[begin],the left is not sorted,which means the right is sorted
            if(nums[mid]< target && target <= nums[last]){// if the target is the sorted area, right
              begin = mid;
            }else{ //left
              last = mid;
            }
            
          }
        }
        if (nums[begin] == target) return begin;
        if (nums[last] == target) return last;
      return -1;
    }
}
```
