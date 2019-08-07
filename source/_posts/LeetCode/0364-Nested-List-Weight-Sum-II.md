---
title: 0364 Nested List Weight Sum II
date: 2018-01-26 04:42:50
categories: LeetCode
tags:
---

Given a nested list of integers, return the sum of all integers in the list weighted by their depth.

Each element is either an integer, or a list -- whose elements may also be integers or other lists.

Different from the previous question where weight is increasing from root to leaf, now the weight is defined from bottom up. i.e., the leaf level integers have weight 1, and the root level integers have the largest weight.

Example 1:
Given the list [[1,1],2,[1,1]], return 8. (four 1's at depth 1, one 2 at depth 2)

Example 2:
Given the list [1,[4,[6]]], return 17. (one 1 at depth 3, one 4 at depth 2, and one 6 at depth 1; 1*3 + 4*2 + 6*1 = 17)

和上一题的区别是，层次反过来了.

level sum 是累加的， 每进入到下一层，上一层的levelsum 会自动多累加一次

[ [1,1], 2, [1,1]]

当迭代到 [1,1,1,1] 这一层时， 2 相当于 累加了两次 2 + 2 + 1 + 1 + 1 + 1 = 8

```java
public class Solution {
    public int depthSumInverse(List<NestedInteger> nestedList) {
        int levelSum = 0, sum = 0;
        while(!nestedList.isEmpty()) {
            List<NestedInteger> next = new ArrayList<>();
            for (NestedInteger value : nestedList) {
                if (value.isInteger()) {
                    levelSum += value.getInteger();
                } else {
                    next.addAll(value.getList());
                }
            }
            
            sum += levelSum;
            nestedList = next;
        }
        return sum;
    }
}
```

```java

class Solution {
    public int depthSumInverse(List<NestedInteger> nestedList) {
        if (nestedList == null) return 0;
        Queue<NestedInteger> queue = new LinkedList<NestedInteger>();
        int levelSum = 0;
        int total = 0;
        for (NestedInteger next: nestedList) {
            queue.offer(next);
        } 
        while (!queue.isEmpty()) {
            int size = queue.size();   
            for (int i = 0; i < size; i++) {
                NestedInteger current = queue.poll();
                if (current.isInteger())  {
                    levelSum += current.getInteger();
                } else {
                    List<NestedInteger> nextList = current.getList();
                    for (NestedInteger next: nextList) {
                        queue.offer(next);
                    }
                }
            }
            total += levelSum;
        }
        return total;
    }
}
```

```c++
class Solution {
public:
    int depthSumInverse(vector<NestedInteger>& nestedList) {
        vector<int> result;
        for(auto ni : nestedList) {
            dfs(ni, 0, result);
        }
        //post processing 
        int sum = 0;
        for(int i = result.size()-1,level = 1; i >=0; i--, level++) {
            sum += result[i]*level;
        }
        
        return sum;
    }
    
private:
    void dfs(NestedInteger &ni, int depth, vector<int> & result) {
        if(result.size() < depth+1) result.resize(depth+1);
        if(ni.isInteger()) {
            result[depth] += ni.getInteger();
        } else {
            for(auto n_ni : ni.getList()) {
                dfs(n_ni, depth+1, result);
            }
        }
        
    }
    
    
};
```
