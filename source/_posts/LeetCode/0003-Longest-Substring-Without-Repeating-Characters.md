---
title: 0003-Longest-Substring-Without-Repeating-Characters
date: 2017-12-05 01:16:11
categories: LeetCode
tags:
---

[SLiding-Window](http://www.wayne.ink/2017/11/05/LeetCode/LeetCode-Sliding-Window/)

靠，这道题我一直理解错了，这题求的是最长不重复字串，相同字符不能出现两次，可能是aaa, 这样子长度就是1, 而不是 3
而另一种题型是，字符的总类不超过K个，可以有重复字符。aaa, 的长度是3 完全是两种题型。真蛋疼。


那这样子就不是 经典的 map + counter 了。
而是滑动窗口 + 两指针

https://leetcode.com/problems/longest-substring-without-repeating-characters/description/

方法一: 采用计数法
```java
public int lengthOfLongestSubstring(String s) {
    if (s == null || s.isEmpty()) return 0;
    int[] map = new int[128];
    int begin = 0, end = 0, len = Integer.MIN_VALUE;
    while(end < s.length()) {
        if (map[s.charAt(end)] == 0) {
            map[s.charAt(end)]++;
        }
        len = Math.max(len,end - begin);
        end++;

        while(end < s.length() && map[s.charAt(end)] > 0) {
            map[s.charAt(begin)]--;
            begin++;
        }

    }
    return len + 1;
}
```

方法二: 有没有发现, 滑动窗口，不再是计数，而是记录位置有没有!! dict[s[i]] 记录最近这个字符出现的位置. 所以要先判断，再赋值.
```cpp
int lengthOfLongestSubstring(string s) {
        vector<int> dict(256, -1);
        int maxLen = 0, start = -1;
        for (int i = 0; i != s.length(); i++) {
            if (dict[s[i]] > start)
                start = dict[s[i]];
            dict[s[i]] = i;
            maxLen = max(maxLen, i - start);
        }
        return maxLen;
    }
```



