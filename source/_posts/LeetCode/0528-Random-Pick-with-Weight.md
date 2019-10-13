---
title: 0528 Random Pick with Weight
date: 2019-10-13 18:18:56
categories: LeetCode
tags:
---

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

