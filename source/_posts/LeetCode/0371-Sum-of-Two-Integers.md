---
title: 0371 Sum of Two Integers
date: 2018-01-24 04:06:49
categories: LeetCode
tags:
---

```java
public int getSum(int a, int b) {
  if (a == 0) return b;
  if (b == 0) return a;
  while (b  != 0) { // b != 0 说明没有进位了，用XOR （不进位加法) 可以解决。
     carray = a & b;
     a = a ^ b; //相当于做了加法
     b = carray << 1; 
  }
  return a;
}
```
