---
title: 0295 Find Median from Data Stream
date: 2019-08-16 00:40:48
categories: LeetCode
tags:
---

维护一个最大堆和一个最小堆，最大堆里放小的数据，最小堆里放最大的数据。

而且保持最小堆里的数据规模小于等于最大堆。

先在最小堆里放新加的数，再把最小堆的堆顶元素放到最大堆里。

如果最小堆规模比最大堆小，那就从最大堆poll出来堆顶元素放入最小堆。

```java
class MedianFinder {
    private PriorityQueue<Integer> minH;
    private PriorityQueue<Integer> maxH;
    /** initialize your data structure here. */
    public MedianFinder() {
       minH = new PriorityQueue<Integer>();
       maxH = new PriorityQueue<Integer>( (a, b) -> b - a); 
    }
    
    public void addNum(int num) {
        minH.add(num);
        maxH.add(minH.poll());
        if (minH.size() < maxH.size()) {
            minH.add(maxH.poll());
        } 
    }
    
    public double findMedian() {
        if (minH.isEmpty() && maxH.isEmpty())  {
             return 0.0;
         }
        if (minH.size() > maxH.size()) {
            return (double)(minH.peek());
        }
        if (minH.size() < maxH.size()) {
            return (double)(maxH.peek());
        }
        return ((double)(maxH.peek()+minH.peek()))/2.0;
    }
}

/**
 * Your MedianFinder object will be instantiated and called as such:
 * MedianFinder obj = new MedianFinder();
 * obj.addNum(num);
 * double param_2 = obj.findMedian();
 */
```
