---
title: 0009 Palindrome Number
date: 2017-12-26 01:20:06
categories: LeetCode
tags:
---


Determine whether an integer is a palindrome. Do this without extra space.

反转int 数字

这种题不会考到的了。

```java
public boolean isPalindrome(int x) {
  if (x < 0 || ( x != 0 && x % 10 = 0)) return false;
  int rev = 0;
  while ( x > rev ) {
    rev = rev * 10 + x % 10;
    x = x / 10;
  }
  return (x == rev || x == rev / 10);
}
```

