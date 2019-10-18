---
title: 0050 Pow(x,n)
date: 2019-10-18 00:37:12
categories: LeetCode
tags:
---


```java
public class Solution {
    private double pow(double x, int n) {
        if (n == 0) {
            return 1;
        } 
        
        if (n % 2 == 0) {
            return pow(x * x, n / 2);    
        } else {
            return pow(x * x, n / 2) * x;
        }
    }
    public double myPow(double x, int n) {
        
        if (n < 0) {
            x = 1 / x;
            n = -n;
        }
        
        return pow(x,n);
    }
}
```
