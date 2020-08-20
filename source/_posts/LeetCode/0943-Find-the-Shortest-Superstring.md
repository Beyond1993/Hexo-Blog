---
title: 0943 Find the Shortest Superstring
date: 2020-03-21 11:33:05
categories: LeetCode
tags:
---

```java
class Solution {
    public String shortestSuperstring(String[] A) {
        int n = A.length;
        int[][] dist = new int[n][n];
        int[][] dp =  new int[1 << n][n];
        int[][] parent = new int[1 << n][n];
        
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                dist[i][j] = cal(A[i], A[j]);
            }
        }
        
        for (int i = 0; i < (1 << n); i++) { 
            for (int j = 0; j < n; j++) {
                parent[i][j] = -1;
                dp[i][j] = Integer.MAX_VALUE / 2;
            }
            
        }
        for (int i = 0; i < n; i++) {
            dp[ 1 << i][i] = A[i].length();
        }   
        
        for (int s = 1; s < (1 << n); ++s) {
          for (int j = 0; j < n; ++j) {
              
            if ((s & (1 << j)) == 0) continue;
            int ps = s & ~(1 << j);
              
            for (int i = 0; i < n; ++i) {
              if (dp[ps][i] + dist[i][j] < dp[s][j]) {
                dp[s][j] = dp[ps][i] + dist[i][j];
                parent[s][j] = i;
              }
            }
          }
        }
        
        int j = 0;
        int min = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            System.out.println(dp[(1 << n) - 1][i]);
            if (dp[(1 << n) - 1][i] < min) {
                min = dp[(1 << n) -1][i];
                j = i;
            }
        }
         
        int s = (1 << n)  - 1;
        int p = 0;
        String res = "";
        while(s != 0) {
            p = parent[s][j];
            if (p < 0)
            {
              res = A[j] + res;
            } else {
                res = A[j].substring(A[j].length() - dist[p][j]) + res;
            }
            s = (s & (~(1 << j)));
            j = p;
        }
      return res;
    }
    
    private int cal(String a, String b) {
        for (int i = 1; i < a.length(); i++) {
            if (b.startsWith(a.substring(i))) {
                return b.length() - a.length() + i;
            }
        }
        return b.length();
    }
}
```
