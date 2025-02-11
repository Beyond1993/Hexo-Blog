---
title: Do you really know how to write a binary search?
date: 2019-10-14 00:37:39
categories: Algorithm
tags:
---

Binary Search is a basic algorithm. but there are still a lot of details we want to discuss.

举个例子:
1，2，3，4，6， target = 5

以下几个是结果肯定存在的情况

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

这个模版返回 index 4, 但是不能确定index 4 是否就是target, 需要再次判断

```java
if (nums[l] == target) {
    return l;
}
else {
    return -1;
}
```

```java
public int binarySearch(int[] nums, int target)
{
    int l = 0;
    int r = nums.length - 1;
    while(l < r) {
        int mid = l + (r - l) / 2;
        if (nums[mid] > target) {
            r = mid - 1; 
        } else {
            l = mid;
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
这个模版 会在循环里就检测 left == right 这种最后一个元素

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



二分法里 什么时候用 while left <= right: 什么时候用 while left < right
ChatGPT said:
在二分法 (binary search) 中，while left <= right 和 while left < right 这两种形式的循环条件使用场景和逻辑是有所不同的，主要体现在如何处理目标值的查找和确定结束条件。

1. while left <= right:
适用场景: 用于查找一个元素是否存在于一个已排序的数组中，或者要返回找到的元素的索引。这个条件保证了 left 和 right 之间的区间是闭合的，即包含了所有可能的元素，直到找到目标元素为止。

循环逻辑:

需要包括 left 和 right 指向的元素，确保在某个时刻，left 和 right 中间的元素都被检查过。
一旦 left == right，仍然可以继续进行查找，因为还可能存在目标元素。
常见用法: 查找元素的位置，或者在某些情况下，需要处理left == right的特殊情况。

代码示例：
```python
def binary_search(arr, target):
    left, right = 0, len(arr) - 1
    
    while left <= right:  # 重点：允许 left == right
        mid = left + (right - left) // 2
        if arr[mid] == target:
            return mid  # 找到目标元素，返回其索引
        elif arr[mid] < target:
            left = mid + 1  # 目标在右半部分
        else:
            right = mid - 1  # 目标在左半部分
    return -1  # 没有找到目标元素
```
在上面的代码中，我们使用 while left <= right 确保在最后一次迭代时，left 和 right 都会被检查到。如果我们使用 while left < right，则在 left == right 时会跳过最后一个位置的检查。

2. while left < right:
适用场景: 用于求解某个条件下的最小或最大值，特别是在找“最接近目标”的值时。例如，通常用于查找一个值的位置区间的下界或上界，或者当目标值不存在时找其插入位置。

循环逻辑:

这个条件保证了left和right区间是开区间的，即不包括right，避免了left == right 时的重复操作。
在某些情况下，left == right 时，left 已经指向目标的正确位置或可能的插入位置。
常见用法: 当我们需要确保 left 最终指向目标位置的“上界”或“下界”，常用这种条件来避免重复检查。

代码示例：
```python
def binary_search(arr, target):
    left, right = 0, len(arr)
    
    while left < right:  # 重点：left 不等于 right
        mid = left + (right - left) // 2
        if arr[mid] == target:
            return mid  # 找到目标元素，返回其索引
        elif arr[mid] < target:
            left = mid + 1  # 目标在右半部分
        else:
            right = mid  # 目标在左半部分
    return -1  # 没有找到目标元素
```
在这个例子中，使用 while left < right 可以确保最终 left 直接指向目标的位置（或者插入位置）。特别是查找插入位置时，right 会逐步向左收缩，确保 left 最终指向正确的位置。

总结：
while left <= right: 常用于需要检查 left == right 的情况，通常用于查找目标值的具体位置。
while left < right: 用于查找上界或下界，通常用于找到插入位置，避免重复的检查。
选择哪种循环条件，取决于你需要的逻辑行为：
如果你要查找的是“某个位置”的值，并且需要包括最后一个元素的检查，使用 left <= right。
如果你在查找范围或插入点，不需要检查最后一个位置时，使用 left < right。
