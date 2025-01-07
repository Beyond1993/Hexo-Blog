---
title: 0528 Random Pick with Weight
date: 2019-10-13 18:18:56
categories: LeetCode
tags:
---

注意和这题区分开来:

http://47.113.101.198/2025/01/07/LeetCode/0398_Random_Pick_Index/

Given an array w of positive integers, where w[i] describes the weight of index i, write a function pickIndex which randomly picks an index in proportion to its weight.

Note:

1 <= w.length <= 10000
1 <= w[i] <= 10^5
pickIndex will be called at most 10000 times.
Example 1:

Input: 
["Solution","pickIndex"]
[[[1]],[]]
Output: [null,0]
Example 2:

Input: 
["Solution","pickIndex","pickIndex","pickIndex","pickIndex","pickIndex"]
[[[1,3]],[],[],[],[],[]]
Output: [null,0,1,1,1,0]
Explanation of Input Syntax:

The input is two lists: the subroutines called and their arguments. Solution's constructor has one argument, the array w. pickIndex has no arguments. Arguments are always wrapped with a list, even if there aren't any.

```java
class Solution {

    int[] preSum;
    int sum;
    public Solution(int[] w) {
        preSum = new int[w.length];
        this.sum = 0;
        for (int i = 0; i < w.length; i++) {
            this.sum += w[i];
            this.preSum[i] = sum; 
        }
    }
    
    public int pickIndex() {
        int cur = (int)(Math.random() * this.sum + 1);
        int l = 0;
        int r = this.preSum.length - 1;
        
        while(l + 1 < r) {
            int mid = l + (r - l) / 2;
            if (preSum[mid] == cur) {
                return mid;
            } else if (preSum[mid] > cur) {
                r = mid;
            } else {
                l = mid;
            }
        }
        return r;
    }
}
```

这样写只能过一半 case ..

```java
cass Solution {

    int[] preSum;
    int sum;
    public Solution(int[] w) {
        preSum = new int[w.length];
        this.sum = 0;
        for (int i = 0; i < w.length; i++) {
            this.sum += w[i];
            this.preSum[i] = sum; 
        }
    }
    
    public int pickIndex() {
        int cur = (int)(Math.random() * this.sum + 1);
        int l = 0;
        int r = this.preSum.length - 1;
        
        while(l < r) {
            int mid = l + (r - l) / 2;
           // System.out.println(l + " " + r + " " + mid + " " + cur);
            if (preSum[mid] == cur) {
                return mid;
            } else if (cur < preSum[mid]) {
                r = mid - 1; // 这里会提前跳出, l == r 最后一次没有算， 所以要把条件改成 l <= r, 算最后一次，看是否是结果
            } else {
                l = mid + 1;
            }
        } 
        return l;
    }
}
```

或者这样

```java
class Solution {

    int[] preSum;
    int sum;
    public Solution(int[] w) {
        preSum = new int[w.length];
        this.sum = 0;
        for (int i = 0; i < w.length; i++) {
            this.sum += w[i];
            this.preSum[i] = sum; 
        }
    }
    
    public int pickIndex() {
        int cur = (int)(Math.random() * this.sum + 1);
        int l = 0;
        int r = this.preSum.length - 1;
        
        while(l < r) {
            int mid = l + (r - l) / 2;
           // System.out.println(l + " " + r + " " + mid + " " + cur);
            if (preSum[mid] == cur) {
                return mid;
            } else if (cur < preSum[mid]) {
                r = mid;
            } else {
                l = mid + 1;
            }
        } 
        return l;
    }
}


//1 2 3 4
//1 3 6 10, target = 2
//l      r

//mid = (0 + 3) / 2 = 1

//   5

/**
 * Your Solution object will be instantiated and called as such:
 * Solution obj = new Solution(w);
 * int param_1 = obj.pickIndex();
 */
```

