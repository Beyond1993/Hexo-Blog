---
title: 470 Implement Rand10() Using Rand7()
date: 2019-11-12 01:29:23
categories: LeetCode
tags:
---



```java
class Solution extends SolBase {
    public int rand10() {
        int temp = (rand7() - 1) * 7 + rand7() - 1 + 1;
        while(temp > 10) {
             temp = (rand7() - 1) * 7 + rand7() - 1 + 1;
        }
        return temp;
    }
}
```


```java
class Solution extends SolBase {
    public int rand10() {
        int row, col, idx;
        do {
            row = rand7();
            col = rand7();
            idx = col + (row - 1) * 7;
        } while (idx > 40);
        return 1 + (idx - 1) % 10;
    }
}
```
