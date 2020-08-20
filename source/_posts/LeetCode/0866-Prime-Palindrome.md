---
title: 0866 Prime Palindrome
date: 2020-06-15 00:41:06
categories: LeetCode
tags:
---

Find the smallest prime palindrome greater than or equal to N.

Recall that a number is prime if it's only divisors are 1 and itself, and it is greater than 1. 

For example, 2,3,5,7,11 and 13 are primes.

Recall that a number is a palindrome if it reads the same from left to right as it does from right to left. 

For example, 12321 is a palindrome.

中文意思:
给出一个 N, 给出大于等于N 的素数，并且素数是回文的

这题有两个大的思路，一个是找出大的素数，判断是否是parlindrome。

还有一个是找出大的parlindrome, 然后啊、判断是否是素数

第二个思路更优:

```java
class Solution {
    public int primePalindrome(int N) {
        if (8 <= N && N <= 11) return 11;
        for (int x = 1; x < 100000; x++) {
            String s = Integer.toString(x), r = new StringBuilder(s).reverse().toString();
            int y = Integer.parseInt(s + r.substring(1));
            if (y >= N && isPrime(y)) return y;
        }
        return -1;
    }

    public Boolean isPrime(int x) {
        if (x < 2 || x % 2 == 0) return x == 2;
        for (int i = 3; i * i <= x; i += 2)
            if (x % i == 0) return false;
        return true;
    }
}
```
