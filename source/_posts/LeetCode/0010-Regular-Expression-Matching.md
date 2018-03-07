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



