---
title: 0125 Valid Palindrome
date: 2024-12-20 10:40:08
categories: LeetCode
tags:
---

```python
class Solution:
    def isPalindrome(self, s: str) -> bool:
        left, right = 0, len(s) - 1
        s = s.lower()
        while left < right:
            if not s[left].isalpha() and not s[left].isdigit():
                left += 1
                continue
            if not s[right].isalpha() and not s[right].isdigit():
                right -= 1
                continue
            if s[left] != s[right]:
                return False
            left += 1
            right -= 1
        
        return True
```


```java
class Solution {
    public boolean isPalindrome(String s) {
        char[] arr = s.toCharArray();
        int i = 0;
        int j = arr.length - 1;
        int val = 0;
        boolean isNumber = false;
        
        while(i < j) {
            
            if (arr[i] >= 'A'  && arr[i] <= 'Z') {
                val = s.charAt(i) - 'A';
                isNumber = false;
            } else if(arr[i] >= 'a' && arr[i] <= 'z') {
                val = s.charAt(i) - 'a';
                isNumber = false;
            } else if (arr[i] >= '0' && arr[i] <= '9') {
               val = s.charAt(i) - '0';
               isNumber = true;
            } else {
                i++;
                continue;
            }
            
            
            if (arr[j] >= 'A'  && arr[j] <= 'Z') {
                if (val != s.charAt(j) - 'A' ) {
                    return false;
                }
            } else if(arr[j] >= 'a' && arr[j] <= 'z') {
                if (val != s.charAt(j) - 'a') {                   
                    return false;
                }
            } else if (arr[j] >= '0' && arr[j] <= '9') {
               if ( !isNumber || val != arr[j] - '0') {                   
                   return false;
               }
            } else {
                j--;
                continue;
            }
            j--;
            i++;
            //System.out.println(i + " " + j);
        }
        return true;
    }
}
```
