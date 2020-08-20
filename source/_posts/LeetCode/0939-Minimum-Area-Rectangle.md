---
title: 0939 Minimum Area Rectangle
date: 2020-05-31 04:12:46
categories: LeetCode
tags:
---

Given a set of points in the xy-plane, determine the minimum area of a rectangle formed from these points, with sides parallel to the x and y axes.

If there isn't any rectangle, return 0.

 

Example 1:

Input: [[1,1],[1,3],[3,1],[3,3],[2,2]]
Output: 4
Example 2:

Input: [[1,1],[1,3],[3,1],[3,3],[4,1],[4,3]]
Output: 2
 

Note:
1. 1 <= points.length <= 500
2. 0 <= points[i][0] <= 40000
3. 0 <= points[i][1] <= 40000
4. All points are distinct.

这题很有意思. 找平行于x 轴 y 轴的线。求最小面积

我的想法建两个 关于 x, y 坐标的 hash map。然后以每一个点 作为 左下角的点。找到最小面积。

比如说 
x map:
<1, [(1,1), (1,3)]>
<2, [(2,2)]>
<3, [(3,1), (3,3)]>

y map:
<1, [(1,1),(3,1)]>
<2, (2,2)>
<3, [(1,3), (3,3)]>

(1,1) ==> (1,3) ==> (3,3) ==> (3,1) ==> 4


为了简化代码, 可以确定一个三个点，再看第四个点是否存在

```java
class Solution {
    Map<Integer, List<Integer>> xMap = new HashMap<>();
    Map<Integer, List<Integer>> yMap = new HashMap<>();
    Set<String> set = new HashSet<>();
    public int minAreaRect(int[][] points) {
        for (int[] p : points) {
            if (xMap.containsKey(p[0])) {
                xMap.get(p[0]).add(p[1]);
            } else {
                List<Integer> list = new ArrayList<>();
                list.add(p[1]);
                xMap.put(p[0], list);
            }
            
            if (yMap.containsKey(p[1])) {
                yMap.get(p[1]).add(p[0]);
            } else {
                List<Integer> list = new ArrayList<>();
                list.add(p[0]);
                yMap.put(p[1], list);
            }
            set.add(p[0] + " " + p[1]);
        }
        int res = Integer.MAX_VALUE;
        for (int[] p : points) {
            res = Math.min(res, getArea(p));
        }
        return res == Integer.MAX_VALUE ? 0 : res;
    }
    
    private int getArea(int[] p) {
        int x = p[0];
        int y = p[1];
        int area = 1;
        int res = Integer.MAX_VALUE;
        //right
        for (int px : yMap.get(y)) {
            if (px <= x) {
                continue;
            }
            //up
            for (int py : xMap.get(px)) {
                if (py <= y) {
                    continue;
                }
                
                if (set.contains(x + " " + py)) {
                     res = Math.min((px - x) * (py -y), res);
                }
            }
        }
        return res;
    }
}
```
