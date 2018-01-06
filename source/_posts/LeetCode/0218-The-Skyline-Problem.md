---
title: 0218-The-Skyline-Problem
date: 2018-01-04 17:00:45
categories: LeetCode
tags:
---
|题目描述：

给出区间 : [Li, Ri, Hi], 求所有区间的轮廓

这是 合并二维区间的题，是[合并一维区间](http://52.14.116.56/2017/10/09/LeetCode/0056-Merge-Interval/)的follow up


例子:
input:  [1,3,3], [2,4,4], [5,8,2], [6,7,4], [8,9,4] 
output: [1,3], [2,4], [4,0], [5,2], [6,4], [7,2], [8,4], [9,0]

input:
```text
4       +-------+       +---+   +---+
        |       |       |   |   |   |
3   +---+---+   |       |   |   |   | 
    |   |   |   |       |   |   |   |
2   |   |   |   |   +---+---+---+   |
    |   |   |   |   |   |   |   |   |
1   |   |   |   |   |   |   |   |   |
    |   |   |   |   |   |   |   |   |
0___1___2___3___4___5___6___7___8___9____>
```

output:
```text
output: 

4      *--------+       *---+   *---+
       |        |       |   |   |   |
3   *--+        |       |   |   |   |
    |           |       |   |   |   |
2   |           |   *---+   *---+   |
    |           |   |               |
1   |           |   |               |
    |           |   |               |
0___1___2___3___*___5___6___7___8___*___10__>
```

思路：对于一维区间合并问题。我们只需要先按照start排序，有重叠部分取  end = Max(Ki.end + Ki+1.end),  但是二维问题在处理重叠问题的时候，增加了高度，也就是说重叠部分，取高的.
对于二维问题，我们要降维打击，转成一维，所以对于每一个点, 生成一维的对应关系，[Li, Hi], [Ri,Hi]
对于每一个点，不管是start 还是 end , 取height 最大的. 所以我们要maintain 当前最高点(在合并一维区间里我们取得是最大 右端点)，所以自然就想到了heap, 最大堆. 
但是每一个区间的高度是有生命周期的，start 点开始生成，end 点结束. 所以要从 heap 里去除。

而且在end 点 remove height 之后. 比如移除3, max hight 还是 4, 这个点就不能加入结果集中. 也就是说结果集里的高度是错落有致的，不能连续出现两个相同的高度。

点1,2,3,4 就是全部的test case

```java
public class Solution {
    public List<int[]> getSkyline(int[][] buildings) {
        List<int[]> result = new ArrayList<>();
        List<int[]> height = new ArrayList<>();
        
        for(int[] b:buildings) {
            
            height.add(new int[]{b[0], -b[2]});//负数表示, 是start
            
            height.add(new int[]{b[1], b[2]}); //正数表示, 是end
        }
        
        Collections.sort(height, (a, b) -> {
                if(a[0] != b[0]) 
                    return a[0] - b[0];
                return a[1] - b[1];
        });
        Queue<Integer> pq = new PriorityQueue<>((a, b) -> (b - a));
        pq.offer(0);
        int prev = 0;
        for(int[] h:height) {
            if(h[1] < 0) {
                pq.offer(-h[1]);
            } else {
                pq.remove(h[1]);
            }
            int cur = pq.peek();
            if(prev != cur) {
                result.add(new int[]{h[0], cur});
                prev = cur;
            }
        }
        return result;
    }
}
```


