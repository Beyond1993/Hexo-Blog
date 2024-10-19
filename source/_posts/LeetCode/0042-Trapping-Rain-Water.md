---
title: 0042 Trapping Rain Water
date: 2018-02-18 03:10:56
categories: LeetCode
tags:
---


Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.

For example, 
Given [0,1,0,2,1,0,1,3,2,1,2,1], return 6.

![](https://leetcode.com/static/images/problemset/rainwatertrap.png)

https://www.youtube.com/watch?v=8BHqSdwyODs

```java
public class Solution {
    public int trap(int[] A){
        if (A.length == 0) return 0;
        int[] leftMax = new int[A.length];
        int[] rightMax = new int[A.length];
        int left = Integer.MIN_VALUE;
        int right = Integer.MIN_VALUE;
        for (int i = 0; i < A.length; i++) {
            if (A[i] >= left) {
                left = A[i];
            }
            if (i + 1 <= A.length -1) {
              leftMax[i+1] = left;
            }
            int index = A.length - 1 - i;
            if (A[index] >= right) {                
                right = A[index];
            }

            if (index - 1 >= 0) {
              rightMax[index - 1] = right;
            }
        }
        leftMax[0] = rightMax[A.length -1] = 0;
        int sum = 0;
        for (int i = 0; i < A.length; i++) {
            int temp = Math.min(leftMax[i], rightMax[i]) - A[i];
            sum += temp >= 0? temp: 0;
        }
        return sum;
    }
}
```



```java
class Solution {
    public int trap(int[] height) {
        if (height == null || height.length < 3) {
            return 0;
        }
        int l = 0, r = height.length - 1;
        int area = 0;
        int leftMax = -1;
        int rightMax = -1;
        while (l < r) {
            // 只能从 高度小的一边更新，
           // 为什么不用 leftMax <= rightMax, 因为这只是上一轮的左右最高值。
           // 我并不知道当前比较位置的值, 我得确切的知道当前高度的值 
            if (height[l] <= height[r]) {
                if (height[l] >= leftMax) {
                    leftMax = Math.max(leftMax, height[l]);
                } else {
                    area += leftMax - height[l];
                }
                ++ l;
            } else {
                if (height[r] >= rightMax) {
                    rightMax = Math.max(rightMax, height[r]);
                } else {
                    area += rightMax - height[r];
                }
                r--;
            }
        }
        return area;
    }
}
```



其实leftMax 和 rightMax 都是单调序列. 所以可以简化
```java
public class Solution {
    public int trap(int[] A){
        int a = 0;
        int b = A.length-1;
        int max = 0;
        int leftmax = 0;
        int rightmax = 0;
        while(a <= b) {
            leftmax = Math.max(leftmax,A[a]);
            rightmax = Math.max(rightmax,A[b]);
            if(leftmax < rightmax){
                max += (leftmax-A[a]);       
                // leftmax is smaller than rightmax, so the (leftmax-A[a]) water can be stored
                a++;
            }
            else{
                max += (rightmax-A[b]);
                b--;
            }
        }
        return max;
    }
}
```


容易出错的写法1:

两边同时移动，拿case 1 举例，index right 等于 6 的时候 高度是1 ，rightMax 是3， 此时代码算出来的积水是 3 - 1 = 2

但是 应该算 leftMax, rightMax 的较小值， 2 - 1 = 1

就是左边 右边高度 哪个小，就按照哪个算

```python
class Solution:
    def trap(self, height: List[int]) -> int:
        leftMax, rightMax = 0, 0

        left, right = 0, len(height) - 1
        res = 0
        while left < right:
            
            if height[left] >= leftMax:
                leftMax = height[left]
            else:
                res += leftMax - height[left]
                print("left", left, height[left] , leftMax, res)
            left += 1

            if height[right] >= rightMax:
                rightMax = height[right]
            else:
                res += rightMax - height[right]
                print("right", right, height[right], rightMax, res)
            
            right -= 1

        return res
```

容易出错的写法2:

这里左右哪个高度小，不能用 leftMax, rightMax 算，应该用当前的高度，height[left], height[right] 做比较

```python
class Solution:
    def trap(self, height: List[int]) -> int:
        
        left, right = 0, len(height) - 1

        leftMax, rightMax = height[left], height[right]

        res = 0
        while left < right:
            if leftMax <= rightMax:
                if height[left] > leftMax:
                    leftMax = height[left]
                else:
                    res += leftMax - height[left]
                    print("left", left, height[left] , leftMax, res)
                left += 1
            else:
                if height[right] > rightMax:
                    rightMax = height[right]
                else:
                    res += rightMax - height[right]
                    print("right", right, height[right], rightMax, res)
                right -= 1

        return res
```

正确答案:

```python
class Solution:
    def trap(self, height: List[int]) -> int:
        
        left, right = 0, len(height) - 1

        leftMax, rightMax = height[left], height[right]

        res = 0
        while left < right:
            if height[left] <= height[right]:
                if height[left] >= leftMax:
                    leftMax = height[left]
                else:
                    res += leftMax - height[left]
                    print("left", left, height[left] , leftMax, res)
                left += 1
            else:
                if height[right] >= rightMax:
                    rightMax = height[right]
                else:
                    res += rightMax - height[right]
                    print("right", right, height[right], rightMax, res)
                right -= 1

        return res
```

最简答案:

```python
class Solution:
    def trap(self, height: List[int]) -> int:
        if not height:
            return 0

        l, r = 0, len(height) - 1
        leftMax, rightMax = height[l], height[r]
        res = 0
        while l < r:
            if leftMax < rightMax:
                l += 1
                leftMax = max(leftMax, height[l])
                res += leftMax - height[l]
            else:
                r -= 1
                rightMax = max(rightMax, height[r])
                res += rightMax - height[r]
        return res
```


其他解法:

1. Brute Force

```python
class Solution:
    def trap(self, height: List[int]) -> int:
        if not height:
            return 0
        n = len(height)
        res = 0

        for i in range(n):
            leftMax = rightMax = height[i]

            for j in range(i):
                leftMax = max(leftMax, height[j])
            for j in range(i + 1, n):
                rightMax = max(rightMax, height[j])
                
            res += min(leftMax, rightMax) - height[i]
        return res
```

2. Prefix & Suffix Arrays

```python
class Solution:
    def trap(self, height: List[int]) -> int:
        n = len(height)
        if n == 0:
            return 0
        
        leftMax = [0] * n
        rightMax = [0] * n
        
        leftMax[0] = height[0]
        for i in range(1, n):
            leftMax[i] = max(leftMax[i - 1], height[i])
        
        rightMax[n - 1] = height[n - 1]
        for i in range(n - 2, -1, -1):
            rightMax[i] = max(rightMax[i + 1], height[i])
        
        res = 0
        for i in range(n):
            res += min(leftMax[i], rightMax[i]) - height[i]
        return res
```

3. Stack

```python
class Solution:
    def trap(self, height: List[int]) -> int:
        if not height:
            return 0
        stack = []
        res = 0

        for i in range(len(height)):
            while stack and height[i] >= height[stack[-1]]:
                mid = height[stack.pop()]
                if stack:
                    right = height[i]
                    left = height[stack[-1]]
                    h = min(right, left) - mid
                    w = i - stack[-1] - 1
                    res += h * w
            stack.append(i)
        return res
```
