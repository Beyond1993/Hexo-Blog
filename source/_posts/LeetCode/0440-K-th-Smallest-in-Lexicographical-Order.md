---
title: 0440 K-th Smallest in Lexicographical Order
date: 2019-08-25 17:31:16
categories: LeetCode
tags:
---

Given integers n and k, find the lexicographically k-th smallest integer in the range from 1 to n.

Note: 1 ≤ k ≤ n ≤ 109.

Example:

Input:
n: 13   k: 2

Output:
10

Explanation:
The lexicographical order is [1, 10, 11, 12, 13, 2, 3, 4, 5, 6, 7, 8, 9], so the second smallest number is 10.

```java
class Solution {
    public int findKthNumber(int n, int k) {
        int curr = 1;
        k = k - 1;
        while (k > 0) {
            int steps = calSteps(n, curr, curr + 1);
            System.out.println(steps);
            if (steps <= k) {
                curr += 1;
                k -= steps;
            } else {
                curr *= 10;
                k -= 1;
            }
        }
        return curr;
    }
    
    //use long in case of overflow
    public int calSteps(int n, long n1, long n2) {
        int steps = 0;
        while (n1 <= n) {
            if (n2 <= n) {
               steps += n2 - n1; // this level difference
            } else {
               steps += n + 1 - n1; // this level difference
            }
            
            n1 *= 10; // go to next level 
            n2 *= 10; // go to next level
        }
        return steps;
    }
}
```

