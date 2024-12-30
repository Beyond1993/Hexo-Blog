---
title: 0680 Valid Palindrome II
date: 2020-04-08 06:00:36
categories:
tags:
---


Given a string s, return true if the s can be palindrome after deleting at most one character from it.

 

Example 1:

Input: s = "aba"
Output: true
Example 2:

Input: s = "abca"
Output: true
Explanation: You could delete the character 'c'.
Example 3:

Input: s = "abc"
Output: false
 

Constraints:

1 <= s.length <= 105
s consists of lowercase English letters.


```java

class Solution {

    public boolean isPalindrome(String s, int i, int j) {
        for (int k = i; k <= i + (j - i) / 2; k++) {
            if (s.charAt(k) != s.charAt(j - k + i)) {
                return false;
            }
        }
        return true;
    }

    public boolean validPalindrome(String s) {
        int i = 0, j = s.length() - 1;

        while(i < j) {
            if (s.charAt(i) == s.charAt(j)) {
                i++;
                j--;
            } else {
                return isPalindrome(s, i + 1 , j) || isPalindrome(s, i, j-1);
            }
        }

        return true;
    }
}
```

```python
class Solution:
    def validPalindrome(self, s: str) -> bool:
        
        def isPalin(s, i, j):
            while i < j:
                if s[i] != s[j]: return False
                i +=1
                j -=1
            return True
        
        l = 0
        r = len(s) - 1

        while l < r :
            if s[l] != s[r]:
                return isPalin(s, l + 1, r) or isPalin(s, l, r - 1)
            l += 1
            r -= 1
        return True
```


follow up: 如果 去除 N 个咋算
