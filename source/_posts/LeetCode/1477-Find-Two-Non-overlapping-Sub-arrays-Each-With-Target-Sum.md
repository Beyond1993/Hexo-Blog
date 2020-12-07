---
title: 1477 Find Two Non-overlapping Sub-arrays Each With Target Sum
date: 2020-12-07 15:14:09
categories:
tags:
---

sum - target 向左看
sum + target 向右看

```java
class Solution {
    //3,1,1,1,5,1,2,1
    //0  3 4 5 6 11 12 14 15
    //-1 0 1 2 3 4.  5. 6  7
    public int minSumOfLengths(int[] arr, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        int result = Integer.MAX_VALUE;
        int lsize = Integer.MAX_VALUE;
        map.put(0, -1);
        int sum = 0;
        for (int i = 0; i < arr.length; i++) {
            sum += arr[i];
            map.put(sum, i);
        }
        
        sum = 0;
        
        for (int i = 0; i < arr.length; i++) {
            sum += arr[i];
            if (map.get(sum - target) != null) {
                System.out.println(i + " " + map.get(sum - target));
                lsize = Math.min(lsize, i - map.get(sum - target));
            }
            
            if (map.get(sum + target) != null && lsize < Integer.MAX_VALUE) {   
                result = Math.min(result, map.get(sum + target) - i + lsize);
            }
        }
        return result == Integer.MAX_VALUE ? -1 : result; 
    }
}
```


