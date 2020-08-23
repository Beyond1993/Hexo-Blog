---
title: 1510 Stone Game IV
date: 2020-08-23 06:11:36
categories: LeetCode
tags:
---


这一版过了 35 / 72

n = 7 没过 

```java
class Solution {
    Map<Integer, Boolean> map = new HashMap<>();
    
    public boolean winnerSquareGame(int n) {
        if (n <= 0) {
            return false;
        }
        
        if (map.containsKey(n)) {
            return map.get(n);
        }
      
        int stones = 1;
        int index = 1;
        boolean onceWin = false;
        while(stones <= n) {
            onceWin = onceWin || !winnerSquareGame(n - stones);
            index++;
            stones = index * index; 
        }
        map.put(n, onceWin);
        return onceWin;
    }
    
}
```
