---
title: 0087 Scamble String
date: 2018-01-01 01:04:34
categories: LeetCode
tags:
---


Given a string s1, we may represent it as a binary tree by partitioning it to two non-empty substrings recursively.

Below is one possible representation of s1 = "great":

    great
   /    \
  gr    eat
 / \    /  \
g   r  e   at
           / \
          a   t
To scramble the string, we may choose any non-leaf node and swap its two children.

For example, if we choose the node "gr" and swap its two children, it produces a scrambled string "rgeat".

    rgeat
   /    \
  rg    eat
 / \    /  \
r   g  e   at
           / \
          a   t
We say that "rgeat" is a scrambled string of "great".

Similarly, if we continue to swap the children of nodes "eat" and "at", it produces a scrambled string "rgtae".

    rgtae
   /    \
  rg    tae
 / \    /  \
r   g  ta  e
       / \
      t   a
We say that "rgtae" is a scrambled string of "great".

Given two strings s1 and s2 of the same length, determine if s2 is a scrambled string of s1.


这题很重要。判断一个string 是否是 另一个 string 的 旋转字符串

这题最直观的想法就是，从中间切分开来，判断是否可以互旋，这题的剪枝非常有意思，先判断字符个数是否相同。

```java
public boolean isScramble(String s1, String s2) {
    if (s1.equals(s2)) return true; 

    int[] letters = new int[26];
    for (int i=0; i<s1.length(); i++) {
        letters[s1.charAt(i)-'a']++;
        letters[s2.charAt(i)-'a']--;
    }
    for (int i=0; i<26; i++) if (letters[i]!=0) return false;

    for (int i=1; i<s1.length(); i++) {
        return ( 
            (
            isScramble(s1.substring(0,i), s2.substring(0,i)) 
            && isScramble(s1.substring(i), s2.substring(i))
            )
          || 
             (
              isScramble(s1.substring(0,i), s2.substring(s2.length()-i)) 
              && isScramble(s1.substring(i), s2.substring(0,s2.length()-i))
             )
        );
    }
    return false;
}
```

这题难在非常非单序列，短阵型即，是一棵二叉树
用三维数组，存中间结果，dp[i][j][cen]
表示s1从i开始，长度为cen和s2从j开始，长度为len是否为scramble

```java
public boolean isScramble(String s1, String s2) {  
    if (s1.length() != s2.length()) return false;  
    if (s1.equals(s2)) return true;  

    boolean[][][] dp = new boolean[s1.length()][s2.length()][s1.length() + 1];  
    for (int i = 0; i < s1.length(); i++) {  
        for (int j = 0; j < s2.length(); j++) {  
            dp[i][j][1] = s1.charAt(i) == s2.charAt(j);  
        }  
    }  

    for (int len = 2; len <= s1.length(); len++) {  
        for (int i = 0; i < s1.length() - len + 1; i++) {  
            for (int j = 0; j < s2.length() - len + 1; j++) {  
                for (int k = 1; k < len; k++) {  
                    dp[i][j][len] |= dp[i][j][k] && dp[i + k][j + k][len - k] || dp[i][j + len - k][k] && dp[i + k][j][len - k];  
                }  
            }  
        }  
    }  

    return dp[0][0][s1.length()];  
}  
```

这题，为什么要用三维DP, 这才是一个问题的思维方式。





