---
title: 0647 Palindromic Substrings
date: 2018-03-16 22:24:05
categories: LeetCode
tags:
---

扩展法:

分奇偶:
```python
class Solution:
    def countSubstrings(self, s: str) -> int:
        def extendAroundCenter(left: int, right: int) -> int:
            count = 0
            while left >= 0 and right < len(s) and s[left] == s[right]:
                count += 1
                left -= 1
                right += 1
            return count

        total = 0
        for i in range(len(s)):
            # 奇数长度：以 s[i] 为中心
            total += extendAroundCenter(i, i)

            # 偶数长度：以 s[i] 和 s[i+1] 为中心
            total += extendAroundCenter(i, i + 1)

        return total
```

统一中心法:
```python
class Solution:
    def countSubstrings(self, s: str) -> int:
        n = len(s)
        count = 0

        for center in range(2 * n - 1):
            left = center // 2
            right = left + (center % 2)

            while left >= 0 and right < n and s[left] == s[right]:
                count += 1
                left -= 1
                right += 1

        return count
```




在原有基础上构造最短回文
暴力解法: 从第一个字符开始找最长回文串，将剩下的翻转
KMP 的核心就是要解决，字串不匹配后的回溯问题
KMP 是在匹配失败时，主串不回溯，而只需要模式串按照next数组回溯
next数组只和模式串有关，是其自身特性
求next函数:next[i] 表示 substring(0,i)的真前缀，真后缀最长公共长度
      a b c d a b c a
      0 1 2 3 4 5 6 7
next: 0 0 0 0 1 2 3 1

s + "#" + rever_s 就变成了写一个KMP里的失败函数

```java
class Solution {
    public int countSubstrings(String s) {
        int count = 0;
        boolean[][] M = new boolean[s.length()+1][s.length()+1];
        for (int i=1;i<=s.length();i++) {
            for (int j=1;j<=i;j++) {
                if (s.charAt(i-1)==s.charAt(j-1)) {
                    M[j][i] = i-j<3||M[j+1][i-1];
                }
                if (M[j][i]) {
                    count++;
                }
            }
        }
        return count;
    }
}
```
