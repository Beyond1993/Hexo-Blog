---
title: 0331 Verify Preorder Serialization Of A Binary Tree
date: 2024-12-19 07:49:04
categories: LeetCode
tags:
---

先初始化一个根结点的slot, 

不管是数字还是 # 都会占一个slot, 

但是数字会带来 额外两个slot, 

如果刚好slot 可以用完，说明valid


```java
public class Solution {
    public boolean isValidSerialization(String preorder) {
        String[] nodes = preorder.split(",");
        int slots = 1;
        for (String node: nodes) {
            slots --;
            if (slots < 0) return false;
            if (!node.equals("#")) slots += 2;
        }
        return slots == 0;
    }
}
```
