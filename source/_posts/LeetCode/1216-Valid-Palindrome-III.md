---
title: 1236 Valid Palindrome III
date: 2020-06-22 01:20:08
categories: LeetCode
tags:
---

Given a string s and an integer k, return true if s is a k-palindrome.

A string is k-palindrome if it can be transformed into a palindrome by removing at most k characters from it.

 

Example 1:

Input: s = "abcdeca", k = 2
Output: true
Explanation: Remove 'b' and 'e' characters.
Example 2:

Input: s = "abbababa", k = 1
Output: true
 

Constraints:

1 <= s.length <= 1000
s consists of only lowercase English letters.
1 <= k <= s.length

先找到变成Palindrome 最少次数, 然后和K 比较

```java
class Solution {

    Integer memo[][];

    public boolean isValidPalindrome(String s, int k) {
        memo = new Integer[s.length()][s.length()];

        return checkPalindrome(s, 0,  s.length() - 1) <= k;
    }

    int checkPalindrome(String s, int i, int j) {
        if (i == j) return 0;

        if (i == j - 1) return s.charAt(i) != s.charAt(j) ? 1 : 0;

        if (memo[i][j] != null) {
            return memo[i][j];
        }

        if (s.charAt(i) == s.charAt(j)) {
            memo[i][j] = checkPalindrome(s, i + 1, j - 1);
            
        } else {
            memo[i][j] = Math.min(checkPalindrome(s, i + 1, j), checkPalindrome(s, i, j -1)) + 1;
        }
        return memo[i][j];
    }
}
```

