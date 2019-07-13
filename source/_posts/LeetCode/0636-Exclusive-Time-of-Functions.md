---
title: 0636 Exclusive Time of Functions
date: 2019-07-13 04:17:10
categories: LeetCode
tags:
---


```java
class Solution {
    public int[] exclusiveTime(int n, List<String> logs) {
        if (logs == null && logs.size() == 0) return null;
        int[] res = new int[n];
        Stack<Integer> stack = new Stack<Integer>();
        int prevTimestamp = -1;
        for (int i = 0; i < logs.size(); i++) 
        {
            String[] tempArray = logs.get(i).split(":");
            int curFuncId = Integer.valueOf(tempArray[0]);
            String flag = tempArray[1];
            int curTimestamp = Integer.valueOf(tempArray[2]);
            
            if (stack.isEmpty()) {
                stack.push(curFuncId); //0
                prevTimestamp = curTimestamp; //0 
            } else {
                int prevFuncId = stack.peek();
                if (flag.equals("start")) {   
                    res[prevFuncId] += curTimestamp - prevTimestamp;
                    prevTimestamp = curTimestamp;
                    stack.push(curFuncId); 
                } else {
                    res[prevFuncId] += curTimestamp - prevTimestamp + 1;
                    prevTimestamp = curTimestamp + 1;
                    stack.pop();
                }
            }
        }        
        return res;
    }
}
```

Thanks for @xin.wang
