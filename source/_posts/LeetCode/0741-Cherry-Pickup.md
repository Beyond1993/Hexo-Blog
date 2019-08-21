---
title: 0741 Cherry Pickup
date: 2019-08-21 02:01:32
categories: LeetCode
tags:
---


```text
[
 [0, 1, -1],
 [1, 0, -1], 
 [1, 1,  1]
]

           (2,2,2,2) 

        / -1    |
    (1,2,1,2)  (2,1,2,1)
                / a        |b        | c          \ d
             (1,1,1,1) (2,0,2,0) (1,1,2,0) (2,0,1,1)
            /        |  | \
    (0, 1,0, 1) 1
         /  -1      | 0        | -1            \ -1
(-1, 1, -1, 1)  (0, 0, 0, 0) (0, 0, -1, 1) (-1,1,1,-1)
            

x1 =  2, y1 = 2, x2 = 2, y2 = 2
    
dp(x1 - 1, y1, x2 - 1), person2 top, person1 top  x1 -1, y1, x2 - 1 ==> y2 same
    
dp(x1, y1 - 1, x2)), person1 left, person2 left x1, y1 - 1, x2,  ==> y2 - 1

dp(x1, y1 - 1, x2 - 1), person2 top, person1 left x1, y1 - 1, x2 -1 ==> y2 same

dp(x1 - 1, y1, x2))), person1 top,  person2 left x1 - 1, y1, x2 ==> y2 - 1
```


```java
```

