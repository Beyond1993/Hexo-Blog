---
title: 0636 Exclusive Time of Functions
date: 2019-07-13 04:17:10
categories: LeetCode
tags:
---

```python
class Solution:
    ## 这题的思路就是一个一个event 去遍历，然后对于start, 就先把累计时间存起来，
    ## 因为累计时间是 end - start, 在 "start" 的时候，prev_time = timestamp,
    ## 在 "end" 的时候，因为下一个可能是 start - "next_start", end - "next_start", 
    ## 所以 prev_time = next_start = timestamp + 1
    def exclusiveTime(self, n: int, logs: list[str]) -> list[int]:
        stack = []
        res = [0] * n
        prev_time = 0
        
        for log in logs:
            func_id, status, timestamp = log.split(':')
            func_id = int(func_id)
            timestamp = int(timestamp)
            
            if status == 'start':
                # If there's a function running, accumulate its exclusive time
                if stack:
                    res[stack[-1]] += timestamp - prev_time
                
                # Push the current function id to the stack
                stack.append(func_id)
                prev_time = timestamp  # Update previous time to the current start time
                
            else:  # status == 'end'
                # Accumulate the time for the function that just finished
                res[stack[-1]] += timestamp - prev_time + 1
                stack.pop()  # Pop the function from the stack
                prev_time = timestamp + 1  # Update previous time to the next tick
        
        return res
```


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
