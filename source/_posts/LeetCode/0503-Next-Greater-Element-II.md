---
title: 0503 Next Greater Element II
date: 2019-08-31 18:10:21
categories: LeetCode
tags:
---

继续用 469 的stack 做法

扩容两倍
```java
class Solution {
    public int[] nextGreaterElements(int[] nums) {
        if (nums.length == 0) {
            return new int[0];
        }
        int[] doubleNums = new int[nums.length * 2];
        
        for (int i = 0; i < nums.length; i++) {
            doubleNums[i] = nums[i];
            doubleNums[i + nums.length] = nums[i];
        }
        
        
        Stack<Integer> s = new Stack<>();
        Map<Integer, Integer> map = new HashMap<>();
        
        for (int i = 0; i < doubleNums.length; i++) {
            while(!s.isEmpty() && doubleNums[i] > doubleNums[s.peek()]) {
                map.put(s.pop(), doubleNums[i]); 
            }
            s.push(i);
        }
        
        while(!s.isEmpty()) {
            map.put(s.pop(), -1);
        }
        
        for (int i = 0; i < nums.length; i++) {
            nums[i] = map.get(i);
        }
        
        return nums;
    }
}
```

```java
class Solution {
    public int[] nextGreaterElements(int[] nums) {
        int n = nums.length, result[] = new int[n];
        Arrays.fill(result, -1);
        Stack<Integer> stack = new Stack<>(); 
        for (int i = 0; i < n * 2; i++) {
            int num = nums[i % n]; 
            while (!stack.isEmpty() && num > nums[stack.peek()] )
                result[stack.pop()] = num;
            if (i < n) stack.push(i);
        }   
        return result;
    }
}
```
