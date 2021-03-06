---
title: 0403 Frog jump
date: 2019-05-05 15:06:11
categories: LeetCode
tags:
---


青蛙跳这题非常有意思。动态规划说到底也还是从后往前看，或者说是from bottom  to top.

所以我们规划的路线是 
 
Start<———-End

0, 1, 3, 5, 6, 8, 12, 17

对于每一个石头，记录 *所有可能弹跳力* 和 *最大弹跳力*。为什么不只记最大弹跳力？

比如 3 的弹跳力有 1,2,3.  但是下一个石头是5. 只需跳两个unit 就可以了。

记录所有弹跳力就是，记录了所有可能性，相当于DFS 遍历了所有可能性。记录最大弹跳力相当于判断能不能完成。 如果需要输出所有的的路径。那就不需要记录最大弹跳力了。


```java

class Solution {
    public boolean canCross(int[] stones) {
        Map<Integer, Set<Integer> > map = new HashMap<Integer, Set<Integer>> ();
    
        for (int i = 0; i < stones.length; i++) {
            map.put(i, new HashSet<Integer>());
        }
        
        for (int i = 1; i < stones.length; i++) {
            if (i == 1) {
                if (stones[i] > 1) return false;
                map.get(i).add(1);
                continue;
            }
            boolean flag = false;
            for (int j = 1; j < i; j++) {
                Set<Integer> jumps = map.get(j);
                
                for (Integer jump : jumps) {
                    if (stones[i] - stones[j] == jump) {
                        map.get(i).add(jump);
                        flag = true;
                    } 
                    
                    if (stones[i] - stones[j] == jump - 1) {
                       map.get(i).add(jump-1);   
                       flag = true;
                    }
                    
                    if (stones[i] - stones[j] == jump + 1) {
                      map.get(i).add(jump + 1);    
                      flag = true;
                    }
                }
            }
            if (!flag && i == stones.length - 1) {
                return false;
            }
        }   
        return true;
    }
}
```


```java
class Solution {
    public boolean canCross(int[] stones) {
        return helper(stones, 0, 0);
    }
    
    public boolean helper(int[] stones, int start, int k) {
        
        if (start == stones.length - 1) return true;
        
        for (int end = start + 1; end < stones.length; ++ end) {
            int step = stones[end] - stones[start];
            if ((step >= k - 1 && step <= k + 1) && helper(stones, end, step)) {
                return true;
            }
        }
        
        return false;
    }
}
```

```java
class Solution {
    public boolean canCross(int[] stones) {
        Boolean[][] MM = new Boolean[stones.length][stones.length];
        return helper(stones, 0, 0, MM);
    }
    
    public boolean helper(int[] stones, int start, int k, Boolean[][] MM) {
        
        if (MM[k][start] != null) {
            return MM[k][start];
        }
        
        if (start == stones.length - 1) return MM[k][start] = true;
        
        for (int end = start + 1; end < stones.length; ++ end) {
            int step = stones[end] - stones[start];
            if ((step >= k - 1 && step <= k + 1) && helper(stones, end, step, MM)) {
                return MM[step][start] = true;
            }
        }
        
        return MM[k][start] = false;
    }
}
```
