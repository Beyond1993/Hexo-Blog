---
title: 0010 Regular Expression Matching
date: 2017-12-20 01:38:42
categories: LeetCode
tags:
---

题目描述:

Implement regular expression matching with support for '.' and '*'.

'.' Matches any single character.
'*' Matches zero or more of the preceding element.

The matching should cover the entire input string (not partial).

The function prototype should be:
bool isMatch(const char *s, const char *p)

Some examples:
isMatch("aa","a") → false
isMatch("aa","aa") → true
isMatch("aaa","aa") → false
isMatch("aa", "a*") → true
isMatch("aa", ".*") → true
isMatch("ab", ".*") → true
isMatch("aab", "c*a*b") → true

```txt
or 语句的两种情况
这段代码通过 or 连接了两个条件，表示你有两种选择来匹配字符串 s 和模式 p：

1. self.isMatch(s, p[2:]) — 跳过 * 和它前面的字符：
这个条件表示 将 * 当作匹配零次 前面的字符。

什么时候会走这个条件？

当你决定跳过 * 和它前面那个字符时，表示你认为模式中的 * 匹配 零次 前面的字符。这样，你就可以将字符串 s 和模式 p[2:]（去掉前面那个字符和 * 后）继续匹配。
举个例子： 假设 s = "aa"，p = "a*".

首先检查 first_match = True，因为 s[0] = "a" 和 p[0] = "a" 匹配。
然后，模式中有 *，此时我们有两个选择：
跳过 *：调用 self.isMatch(s, p[2:])，即 self.isMatch("aa", "")，它表示检查 "aa" 能否匹配空模式 ""。这显然会返回 False，因为 "aa" 不是空字符串。
总结：

这个条件的作用是将 * 当作 匹配零次 前面的字符。在 "a*" 这种模式下，它会检查 "aa" 是否能匹配空模式，但在这种情况下显然是不能匹配的，因此返回 False。
2. (first_match and self.isMatch(s[1:], p)) — 将 * 当作匹配一次或多次：
这个条件表示 将 * 当作匹配一次或多次 前面那个字符。

什么时候会走这个条件？

当 first_match 为 True（即 s[0] 和 p[0] 匹配）时，我们决定将 * 当作匹配 一次 或 多次 前面的字符。此时，我们从字符串 s 中去掉第一个字符，并继续检查剩下的部分 s[1:] 是否能与模式 p 匹配。
举个例子： 假设 s = "aa"，p = "a*".

首先，first_match = True（因为 s[0] = "a" 和 p[0] = "a" 匹配）。
然后，模式中有 *，此时我们有两个选择：
使用 * 匹配一个字符：调用 self.isMatch(s[1:], p)，即 self.isMatch("a", "a*")，表示去掉字符串 s 的第一个字符后，检查 "a" 是否能匹配 "a*".
这个过程会重复，继续尝试将 "a" 和 "a*" 匹配，直到我们最终匹配到空字符串 "" 与空模式 ""，返回 True。
```

```python
class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        if not p:
            return not s
        print(s, p)
        
        first_match = len(s) > 0 and (p[0] == s[0] or p[0] == '.')

        if len(p) >= 2 and p[1] == '*':
            ## self.isMatch(s, p[2:]) means * 号前面出现0次, bc, a*bc 
            ## first_match and self.isMatch(s[1:], p) * 号前匹配一次或多次 aaa a*
            return self.isMatch(s, p[2:]) or (first_match and self.isMatch(s[1:], p))
        else:
            return first_match and self.isMatch(s[1:], p[1:])
```

```python
class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        if not p: return not s

        first_match = len(s) > 0 and (s[0] == p[0] or p[0] == ".")

        if len(p) >= 2 and p[1] == "*":
            zero_match = self.isMatch(s, p[2:])
            many_match = first_match and self.isMatch(s[1:], p)
            return zero_match or many_match
        else:
            single_match = self.isMatch(s[1:], p[1:])
            return single_match
```

use memo search:

memo[(i, j)] 代表 s[i:] 和 p[j:] 是否匹配

```python
class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        # Memoization cache
        memo = {}

        def dp(i, j):
            # If the result for the current state is already computed, return it from memo
            if (i, j) in memo:
                return memo[(i, j)]

            # Base case: if the pattern is exhausted, the string should also be exhausted
            if j == len(p):
                return i == len(s)

            # Check if the first characters match or the pattern has a dot (.)
            first_match = i < len(s) and (s[i] == p[j] or p[j] == '.')

            # Handle the '*' case
            if j + 1 < len(p) and p[j + 1] == '*':
                # Either the '*' matches zero or more of the previous character
                result = (dp(i, j + 2) or  # '*' matches zero occurrences
                          (first_match and dp(i + 1, j)))  # '*' matches one or more occurrences
            else:
                # No '*' after the current character, just move to the next character
                result = first_match and dp(i + 1, j + 1)

            # Store the result in the memoization cache
            memo[(i, j)] = result
            return result

        # Start the recursion from the beginning of both the string and the pattern
        return dp(0, 0)

```


```java
public boolean isMatch(String word, String pattern) {
  if (pattern.isEmpty()) return word.isEmpty();
  char first = pattern.charAt(0);
  if (pattern.length() > 1 && pattern.charAt(1) == '*') {
    int k = 0;
    do {
      if (isMatch(word.substring(k), pattern.substring(2))) return true;
    } while( k < word.length() && match(word.charAt(k++), first));
    return false;
  } 
  return !word
}
```

表示状态 T[i][j] s的前i个字符和p的前j个字符是否匹配。

其实这题的题眼是 * 怎么匹配，. 和 p[j] == s[i] 是一样的

也就是说，当母串遇到*号时，因为可以匹配0次，所以直接将母串回溯两位，
或者，匹配多次，也就是说*前面的字符和 字串当前字符相等，直接将子串回溯一位

方程：
T [i] [j]=  T[i-1][j-1] if(p[j] == s[i]||p[j]=='.')
abc abcb*   T[i][j-2] if(p[j]==‘*’ ; * 前字符出现0次
abcbb abcb* T[i-1][j] if(p[j]==‘*’ && (p[j-1]==s[i] || p[j]=='.')) ； * 前字符出现多次

注意这里 i - 1 而j 保持不变，就说明只有子串在不断的往后退。

初始化：添加同一个dummy node T[o][o]=true
第一行：按照规则来，默认为false；遇到*t[o][j]=t[o][j-2]
第一列：按照规则：全为false
      0  1  2  3  4  5  6
        x  a  *  b    c
0      7            
1    x              
2    a              
3    a              
4    b              
5    y              
6    c              
aa  a  s  aa  a*  ;  ab  ;  *c

每个字符串前加一个字符，使坐标一致.p=“o”+p,s=“o”+s

```java
public boolean isMatch(String s, String p) {
    int m = s.length(), n = p.length();
    boolean[][] t = new boolean[m+1][n+1];
    t[0][0] = true;
    p = "o" + p;
    s = "o" + s;
    for (int i = 1; i <= m; i++) {
        t[i][0] = false;
    }
    for (int j = 1; j <= n; j++) {
        t[0][j] = false;
        if (p.charAt(j) == '*') {
            t[0][j] = t[0][j -2];
        }
    }
    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            if (p.charAt(j) != '*') {
                if (p.charAt(j) == s.charAt(i) || p.charAt(j) == '.') {
                    t[i][j] = t[i -1][j -1];    
                } else {
                    t[i][j] = false;
                }

            } else { 
           // if (p.charAt(j) == '*') {
                if (t[i][j -2]) { // * 前面出现0的字符出现0次 
                    t[i][j] = true;
                } else { // 出现多次
                    if (p.charAt(j-1) == s.charAt(i) || p.charAt(j-1) == '.') {
                        t[i][j] = t[ i - 1][j];
                    }
                }
            }

        }
    }
    return t[m][n];
}
```
这种写法是为了明确的表示，每个位置的状态变化，可以利用java boolean 数据全部初始化为false 的特性，简化代码.

```java
public boolean isMatch(String s, String p) {
    int m = s.length(), n = p.length();
    boolean[][] t = new boolean[m+1][n+1];
    t[0][0] = true;
    p = "o" + p;
    s = "o" + s;

    for (int j = 1; j <= n; j++) {
        if (p.charAt(j) == '*') {
            t[0][j] = t[0][j -2];
        }
    }
    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {

           if (p.charAt(j) == s.charAt(i) || p.charAt(j) == '.') {
                t[i][j] = t[i -1][j -1];    
           } 

           if (p.charAt(j) == '*') {
                if (t[i][j -2]) { // * 前面出现0的字符出现0次 
                    t[i][j] = true;
                } else { // 出现多次
                    if (p.charAt(j-1) == s.charAt(i) || p.charAt(j-1) == '.') {
                        t[i][j] = t[ i - 1][j];
                    }
                }
            }

        }
    }
    return t[m][n];
}
```


