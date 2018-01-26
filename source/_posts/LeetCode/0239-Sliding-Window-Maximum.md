---
title: 0239-Sliding-Window-Maximum
date: 2018-01-30 19:03:17
categories: LeetCode
tags:
---

Given an array nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.

For example,
Given nums = [1,3,-1,-3,5,3,6,7], and k = 3.

Window position                Max
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7
Therefore, return the max sliding window as [3,3,5,5,6,7].

Note: 
You may assume k is always valid, ie: 1 ≤ k ≤ input array's size for non-empty array.

Follow up:
Could you solve it in linear time?


这题很有意思。给一个滑动窗口，找出窗口里的最大值。

最朴素的想法，就是每一次窗口移动位置，取出这个窗口里的最大值。这样的时间复杂度是K * N。 如果K 接近于 N, 这个算法的时间复杂度直逼到N^2。 顿时觉得很尴尬有木有。

所以自然而然，我们就想，怎么优化，怎么优化啊。怎么样把取到最大值的时间复杂度降到O(1) 这真是个大问题。

HashMap? 记录下 index or value? 好像不行
Stack? NO
Queue? NO
Heap? 堆好像可以，因为可以直接拿到最大值，但是怎么维护这一个heap的 size 呢？

设 heap 的size 为 K ? 好像不行啊，因为这样是维护的是之前所有的前K大的值，但是这里我们index 超出窗口的范围，不管value多大都不管用。

事情一下子陷入了僵局。

再来看看我们的需求。我们需要一个数据结构，可以用O(1) 来找到最大值, 而且还要去除窗口之外的index。。

Deque 呼之欲出

```java
public int[] maxSlidingWindow(int[] nums, int k) {

    if (nums == null || k <= 0) {
        return new int[0];
    }
    int n = nums.length;
    int[] res = new int[n-k+1];
    int index = 0;
    // store index
    Deque<Integer> q = new ArrayDeque<>();
    // poll [DeQueue] pollLast
    // the leftmost side of the queue always is the biggest in this window
    // we need to make sure that the numbers inside queue are in decreasing order. why? because if the largest number is out of the range, we need to make sure the second leftmost element is the largest one after we pop out the leftmost element.   
    for (int i = 0; i < nums.length; i++) {
	// if the new number is greater than the rightmost element in the dequeue, we pop the rightmost element so that the deque can maintain the decreasing order.
        // remove smaller numbers in k range as they are useless
        while (!q.isEmpty() && nums[q.peekLast()] < nums[i]) {
            q.pollLast();
        }
        // q contains index... r contains content
        q.offer(i);

        // remove numbers out of range k
        if (!q.isEmpty() && i  + 1 - q.peek() > k) {
            q.poll();
        }

        if (i >= k - 1) {
            res[index++] = nums[q.peek()];
        }
    }
    return res;
}
```

 
