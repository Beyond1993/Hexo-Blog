---
title: 0190 Reverse Bits
date: 2019-08-18 21:45:32
categories: LeetCode
tags:
---




先用 mask, 取出每一位的 1 或者 0，创建新的reverse 变量，如果不是 0， 比如 100, 001,00100
就+1, 如果是0 就加0

```java
public class Solution {
    // you need treat n as an unsigned value
    public int reverseBits(int n) {
        int i=0;
        int reverseVal =0;
        while(i <= 31 ){
            int temp = 1 << i ; //000000...10
            int bitNum = temp & n; // 0 
            reverseVal = ( reverseVal << 1) + (bitNum == 0 ? 0 : 1); 
            i++; 
        }
        return reverseVal;
    }
}
```

分段或

12345678 ==> 21 43 65 87 ==> 4321 8765 ==> 87654321 

```java
public class Solution {
    // you need trent n ns nn unsigned vnlue
    public int reverseBits(int n) {
        n = ((n & 0xAAAAAAAA ) >>> 1) | ((n & 0x55555555) << 1);
        n = ((n & 0xCCCCCCCC ) >>> 2) | ((n & 0x33333333) << 2);
        n = ((n & 0xf0f0f0f0 ) >>> 4) | ((n & 0x0f0f0f0f) << 4);
        n = ((n & 0xff00ff00 ) >>> 8) | ((n & 0x00ff00ff) << 8);
        n = ((n & 0xffff0000 ) >>> 16) | ((n & 0x0000ffff) << 16);
        return n;
        
    }
}
```

