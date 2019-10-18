---
title: Do you really know how to write a binary search?
date: 2019-10-14 00:37:39
categories: Algorithm
tags:
---

Binary Search is a basic algorithm. but there are still a lot of details we want to discuss.

```java
public int binarySearch(int[] nums, int target)
{
    int l = 0;
    int r = nums.length - 1;
    while( l < r) {
        int mid = l + (r - l) / 2;
        if (nums[mid] > target) {
            r = mid; // 如果这里是 r = mid - 1; 就会提前结束循环，少判断一次
        } else {
            l = mid + 1;
        }
    }
    return l;
}
```

```java
public int binarySearch(int[] nums, int target)
{
    int l = 0;
    int r = nums.length - 1;
    
    while( l <= r) {
        int mid = l + (r - l) / 2;
        if (nums[mid] > target) {
            r = mid - 1;
        } else {
            l = mid + 1;
        }
    } 
    return l;
}

```

九章模版

```java
public int binarySearch(int[] nums, int target)
{
    int l = 0;
    int r = nums.length - 1;

    while( l + 1 < r) {
        int mid = l + (r - l) / 2;
        if (nums[mid] > target) {
            r = mid;
        } else {
            l = mid;
        }
    }

    if (nums[r] == target) {
       return r;
    }
    return l ;
}
```



