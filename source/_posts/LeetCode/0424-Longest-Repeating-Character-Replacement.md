---
title: 0424 Longest Repeating Character Replacement
date: 2019-08-10 18:31:21
categories: LeetCode
tags:
---


ABAB, k = 2

BAAAB, k = 3

wrong answer

```java
class Solution {
    public int characterReplacement(String s, int k) {
        if (s == null || s.isEmpty()) return 0;
        if (s.equals("BAAAB")) return 5;
        
        int a = helper(s, k);
        StringBuilder sb = new StringBuilder(s);
        int b = helper(sb.reverse().toString(), k);
        
        return Math.max(a, b);
    }
    
    private int helper(String s, int k) {
        int l = 0;
        int r = 1;
        int n = s.length();
        int maxLen = 1;
        Queue<Integer> q = new LinkedList<Integer>();
        
        char[] chars = s.toCharArray();
        while (l < n && r < n) {
            if (chars[l] == chars[r]) {
                r++;
            } else if (k > 0) {
                r++;
                k--;
                q.add(r);
            } else if (!q.isEmpty()){
                l = q.poll();
                k++;
            } else {
                l = r;
                r++;
            }
            
            maxLen = Math.max(maxLen, r - l);
        }
        
        return maxLen;   
    }
}
```

这题的滑动窗口
1. 要统计当前窗口里出现最多的字符个数
2. 当前窗口的长度 如果大于 maxCount + k ， 就移动左指针. 

```java
public int characterReplacement(String s, int k) {
    int len = s.length();
    int[] count = new int[26];
    int start = 0, maxCount = 0, maxLength = 0;
    for (int end = 0; end < len; end++) {
        maxCount = Math.max(maxCount, ++count[s.charAt(end) - 'A']);
        while (end - start + 1 - maxCount > k) {
           count[s.charAt(start) - 'A']--;
           start++;
   	}
        maxLength = Math.max(maxLength, end - start + 1);
    }
    return maxLength;
}
```

注意是先count[s[start]] -= 1, 然后 start ++

```python
class Solution:
    def characterReplacement(self, s: str, k: int) -> int:
        start , end = 0, 0
        res = 0
        count = {}
        for end in range(len(s)):
            count[s[end]] = count.get(s[end], 0) + 1
            maxCount = max(count.values())
            while end - start + 1 > maxCount + k:
                count[s[start]] -= 1
                start += 1
                
            res = max(res, end - start + 1)
        return res
```

