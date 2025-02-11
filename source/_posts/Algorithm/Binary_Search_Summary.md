---
title: Binary Search Summary
date: 2025-02-11 08:36:58
categories: Algorithm
tags:
---

今天来总结一下二分搜索算法:

* 查找一个已排序序列中第一个不小于某个值的元素
* 查找一个已排序序列中最后一个不大于某个值的元素
* 查找一个已排序序列中第一个大于某个值的元素
* 查找一个已排序序列中最后一个小于某个值的元素

二分搜索是一个看着容易，实现起来细节非常多的算法。主要点在几个方面。

1. 左右边界的初始化，这个对于一些应用题相对比较隐晦。
2. 二分法的搜索区间. 二分搜索算法的搜索区间存在四种选择： [left, right], [left, right), (left, right], (left, right). 重点要掌握两个搜索区间, 左闭右闭[left, right]，左闭右开[left, right)
3. 返回什么

## 中点值计算
二分搜索算法是一个很细节的算法，中点值的计算就是其需要注意的一个地方。

通常情况下，中点值的计算是这样的：

int mid = (left + right) / 2;
如果对二分搜索算法有一定的了解，应该知道，这样的计算可能存在溢出的问题，即：left 和 right 的和可能超出 int 类型的取值范围。

因此，中点值的计算应该用如下算式替代：

int mid = left + (right - left) / 2;
然而，中点值的计算也存在一个隐含的条件：向下取整，也就是说，我们平时写的二分搜索算法的中点值都是向 左边界 接近的。

所以说，以下两者是等价的：

int mid = (left + right) / 2;
int mid = left + (right - left) / 2;
当然了，既然存在向下取整的写法，自然也存在向上取整的写法，只不过平时我们不怎么用罢了，而这篇博客也不做讨论，不过还是给出中点值向上取整的写法：

int mid = ceil((left + right) / 2);
int mid = right - (right - left) / 2;


## 左闭右闭 [left,right]
这类是最标准的二分搜索
查找一个已排序序列中等于某个值的元素是很简单的，这里就直接给出代码好了：

```java
int bsearch(arr, left, right, target) {
  while (left <= right) {
    int mid = left + (right - left) / 2;
    if (arr[mid] == target) {
      return mid;
    } else if (arr[mid] > target) {
      right = mid - 1;  // [left, mid - 1]
    } else {
      left = mid + 1;   // [mid + 1, right]
    }
  }
  return -1;
}
```
这个实现是针对区间 [left, right] 而言的，需要注意的地方是 搜索区间的缩减：

当中点值大于目标值时，说明区间 [mid, right] 内的元素都是我们不需要的，因此，执行的操作是： right = mid - 1.
相应的，当中点值小于目标值时，说明区间 [left, mid] 内的元素都是我们不需要的，因此，执行的操作是： left = mid + 1.
这里需要重点关注的是由边界值的变化，因为搜索的区间是 [left, right], 因此，当中点值不需要时，可以让右边界值直接等于中点值减一。

## 左闭右开 [Left, right)
但是，这对于区间 [left, right) 来说就不一样了：

```java
int bsearch(arr, left, right, target) {
  while (left < right) {
    int mid = left + (right - left) / 2;
    if (arr[mid] == target) {
      return mid;
    } else if (arr[mid] > target) {
      right = mid;     // [left, mid)
    } else {
      left = mid + 1;  // [mid + 1, right)
    }
  }
  return -1;
}
```
在这种情况下，中点值大于目标值，说明区间 [mid, right] 内的元素都是我们不需要的，但是， mid - 1 还是需要等待判断的。

因此，右边界值被修改为 mid 而不是 mid - 1.

这种左闭右开的区间搜索是最常见，也最容易写错的, 很多的题目并不是直接让你在一个数组里找到这个数字，而是找到最接近的大于等于，最接近的小于等于。

对于左闭右开的区间搜索，right 是不需要被访问搜索的，所以这种情况判断条件就是

while left < right:
区间移动的方式是 left = mid + 1, right = mid

而不是 left = mid, right = mid - 1, 因为 mide - 1 是需要被探索的，而这种区间写法里 mid - 1 是开区间，

也就是说 会变成 [mid + 1, mid - 1)

从代码死循环的角度看的，
错误情况: mid = (left + right) // 2 = (mid + mid - 1) = (2mid) // 2 = mid,
正确情况：mid = (left + right) // 2 = (mid + 1 + mid) // 2 =  mid + 1/2

left = mid + 1 能确保搜索区间往右移动

模版
```python
def binary_search(array) -> int:
    def condition(value) -> bool:
        pass
    left, right = 0, len(array) - 1
    while left < right:
        mid = left + (right - left) // 2
        if condition(mid):
            right = mid
        else:
            left = mid + 1
    return left
``` 

在这种左闭右开搜索中，由于right 只是起到收缩边界的作用，没有被真正被搜索，所以只能返回left



## reference:
https://medium.com/@SarKerson/%E4%BA%8C%E5%88%86%E6%90%9C%E7%B4%A2-%E4%BD%A0%E8%BF%98%E5%9C%A8%E7%94%A8%E4%B8%89%E4%B8%AA%E6%A8%A1%E7%89%88-%E4%B8%80%E4%B8%AA%E5%B0%B1%E5%A4%9F%E4%BA%86-bb9c73f36e34

https://www.cnblogs.com/grandyang/p/6854825.html

https://rgb-24bit.github.io/blog/2019/binary-search.html
