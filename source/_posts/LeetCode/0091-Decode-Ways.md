---
title: 0091 Decode Ways
date: 2017-12-23 20:40:26
categories: LeetCode
tags:
---

题目描述：

A message containing letters from A-Z is being encoded to numbers using the following mapping:

'A' -> 1
'B' -> 2
...
'Z' -> 26
Given an encoded message containing digits, determine the total number of ways to decode it.

For example,
Given encoded message "12", it could be decoded as "AB" (1 2) or "L" (12).

The number of ways decoding "12" is 2.



这题的状态比较好想，关键要考虑“0”和初始化前一个
状态：way[i]表示到第s[i]共有多少种不同方式
方程：ways[i]    （s[i-1]=‘1’‖s[i-1]==‘2’)?ways[i-2]=0;if s[i]==‘0’
                  ways[i-1]+ways[i-2],s[i-1][i]在“1”～“26”内，s[i]！=“0”
                  ways[i-1],s[i-1][i]不在“1”～“26”内，s[i]!=‘0’
初始化：ways[0]=s[0]==‘0’？0:1；
        ways[1]=
        考虑  00  10  40  01  34  21
当s[1]==‘0’时，ways[1]=（s[0]==“1”‖s[0]==‘2’）？1:0；
当s[1]!=‘0’时，  s[0][1]是有效     way[1]=2
                             无效     ways[1]=ways[0]

n个数，有多少种不同BST


```java
public class Solution {
    public int numDecodings(String s) {
        int n = s.length();
        if (n == 0) return 0;
        
        int[] memo = new int[n+1];
        memo[n]  = 1;
        memo[n-1] = s.charAt(n-1) != '0' ? 1 : 0;
        
        for (int i = n - 2; i >= 0; i--)
            if (s.charAt(i) == '0') continue;
            else memo[i] = (Integer.parseInt(s.substring(i,i+2))<=26) ? memo[i+1]+memo[i+2] : memo[i+1];
        
        return memo[0];
    }
}

```



follow up  O(1) space complexity

```java
    //follow up: O(1) space complexity
    public int numDecodings(String s) {
        if (s == null || s.length() == 0 || s.charAt(0) == '0' ){
            return 0;
        }
        
        int prevTwo = 1;
        int prevOne = 1;
        int curt = 1;
        
        for (int i = 1; i < s.length(); i++){   
            curt = 0;
            int twoDigits = Integer.parseInt(s.substring(i - 1, i + 1));
            System.out.println(twoDigits);
            if (twoDigits >= 10  && twoDigits <= 26){
                curt += prevTwo;
            }
            int oneDigit = s.charAt(i) - '0';
            if (oneDigit >= 1 && oneDigit <= 9){
                curt += prevOne;
            }
            System.out.println(prevOne + " " + prevTwo);
            prevTwo = prevOne;
            prevOne = curt;
        }
        return curt;
    }
```

这就设计到DP 中的空间优化问题，因为在构造状态转移方程的时候，往往需要大量的空间，这对于大规模的数据来说是一个巨大的挑战. 所以我总结了DP
