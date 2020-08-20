---
title: Interview-Uber-OA
date: 2020-03-17 09:44:40
categories: Interview
tags:
---

```java
public boolean ifKPal(String s, int k) {
        int n = s.length();
        char[] c = s.toCharArray();
        boolean[][] dp = new boolean[n][k];
        boolean[][] pal = new boolean[n][n];
    
        for(int i = 0; i < n; i++) {
            for(int j = 0; j <= i; j++) {
                if(c[j] == c[i] && (j + 1 >= i - 1 || pal[j + 1][i - 1])) {
                    pal[j][i] = true;         
                }
            }
        }
    
        for (int i = 0; i < n; i++) {
            if (pal[0][i]) {
                dp[i][0]  = true;
            }     
        } 
        
        for (int i = 0; i < n; i++) {
            for (int a = 1; a < k; a++) {
                for (int j = 0; j < i; j++) {
                    if (dp[j][a-1] && pal[j+1][i]) {
                        dp[i][a] = true;
                    } 
                }
            }
        }
        return dp[n-1][k-1];
}
```


https://www.1point3acres.com/bbs/forum.php?mod=viewthread&tid=577853&extra=page%3D3%26filter%3Dsortid%26sortid%3D311%26searchoption%5B3046%5D%5Bvalue%5D%3D22%26searchoption%5B3046%5D%5Btype%5D%3Dradio%26sortid%3D311%26orderby%3Ddateline

