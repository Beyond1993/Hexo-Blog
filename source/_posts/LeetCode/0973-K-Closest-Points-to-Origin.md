---
title: 0973 K Closest Points to Origin
date: 2020-04-22 08:34:13
categories: LeetCode
tags:
---

We have a list of points on the plane.  Find the K closest points to the origin (0, 0).

(Here, the distance between two points on a plane is the Euclidean distance.)

You may return the answer in any order.  The answer is guaranteed to be unique (except for the order that it is in.)

 

Example 1:

Input: points = [[1,3],[-2,2]], K = 1
Output: [[-2,2]]
Explanation: 
The distance between (1, 3) and the origin is sqrt(10).
The distance between (-2, 2) and the origin is sqrt(8).
Since sqrt(8) < sqrt(10), (-2, 2) is closer to the origin.
We only want the closest K = 1 points from the origin, so the answer is just [[-2,2]].
Example 2:

Input: points = [[3,3],[5,-1],[-2,4]], K = 2
Output: [[3,3],[-2,4]]
(The answer [[-2,4],[3,3]] would also be accepted.)
 

Note:
- 1 <= K <= points.length <= 10000
- -10000 < points[i][0] < 10000
- -10000 < points[i][1] < 10000

```java
class Solution {
    public int[][] kClosest(int[][] points, int K) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> {
            return b[2] - a[2]; 
        });
        
        for (int i = 0; i < points.length; i++) {
            int[] point = points[i];
            int dis = getDistance(point);
            pq.offer(new int[]{point[0], point[1], dis});
            if (pq.size() > K) {
                pq.poll();
            }
        }
        
        int[][] result = new int[K][2];
        int index = 0;
        while(!pq.isEmpty()) {
            int[] p = pq.poll();
            result[index] = new int[]{p[0], p[1]};
            index++;
        }
        return result;
    }
    
    private int getDistance(int[] point) {
        return point[0] * point[0] + point[1] * point[1];
    }
}
```

```python
class Solution:
    def kClosest(self, points: List[List[int]], k: int) -> List[List[int]]:
        
        heap = []

        for p in points:
            heap.append((p[0] * p[0] + p[1] * p[1], p))

        heapq.heapify(heap)

        res = []

        for _ in range(k):
            res.append(heapq.heappop(heap)[1])
        
        return res
```
