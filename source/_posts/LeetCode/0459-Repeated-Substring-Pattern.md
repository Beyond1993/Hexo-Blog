---
title: 0459 Repeated Substring Pattern
date: 2018-02-18 12:14:12
categories: LeetCode
tags:
---

https://leetcode.com/problems/repeated-substring-pattern/discuss/94397/C++-O(n)-using-KMP-32ms-8-lines-of-code-with-brief-explanation.

First, we build the KMP table.

Roughly speaking, dp[i+1] stores the maximum number of characters that the string is repeating itself up to position i.
Therefore, if a string repeats a length 5 substring 4 times, then the last entry would be of value 15.
To check if the string is repeating itself, we just need the last entry to be non-zero and str.size() to divide (str.size()-last entry).
```java    
bool repeatedSubstringPattern(string str) {
   int i = 1, j = 0, n = str.size();
   vector<int> dp(n+1,0);
   while( i < str.size() ){
      if( str[i] == str[j] ) dp[++i]=++j;
      else if( j == 0 ) i++;
      else j = dp[j];
   }
  return dp[n]&&dp[n]%(n-dp[n])==0;
}
```

http://www.cnblogs.com/grandyang/p/6087347.html

abcabcabcabc
0   1   2   3
xxx|yyy|zzz|eee
    0   1   2
   |xxx|yyy|zzz

最终证明 : eee <=> zzz <=> yyy <=> xxx 

a 1,1
abca 
dp 0, 0 0 0 1 2 3 4 5 6

n - dp[n] 字串长度 
dp[n]

n - dp[n] + dp[n] = n 
abc |  abcabc

