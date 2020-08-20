---
title: Interview Oracle
date: 2020-02-27 09:08:13
categories: Interview
tags:
---


```java
public int singleNumber(int A[], int n) {
        int[] bitnum = new int[32];
        int res = 0;
        for(int i = 0; i < 32; i++) {
            for(int j=0;j< A.length;j++) {
                bitnum[i]+=(A[j]>>i) & 1;
            }
            res |= (bitnum[i] % n) << i;
        }
        return res;
    }
```
