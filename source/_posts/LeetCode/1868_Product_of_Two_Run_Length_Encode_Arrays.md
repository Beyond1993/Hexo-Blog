---
title: 1868-Product-of-Two-Run-Length-Encoded-Arrays
date: 2024-09-18 08:30:59
categories: LeetCode
tags:
---

这题题目非常有意思，就是给出两个压缩数组，先拓展，再乘，再压缩。

压缩的方式就是count and say, 

比如 [1,1,1, 2,2,2,2,2], 就是三个1， 五个2， [1, 3], [2, 5].

暴力解 肯定就是先拓展，再算乘积，再压缩，但是肯定TLE.

一个比较朴素的想法就是，判断每个 touple 里freq 的值，也就是 encode[i][1]

如果个数相同，比如

[2, 3], [3, 3],

也就是[2,2,2] * [3,3,3] = [6, 6, 6], 这种情况就是 [value1 * value2, freq1]

如果freq 不一样，比如， [2, 1], [3, 3],
[2] * [3, 3, 3] 可以拆分成 [2] * [3], [3, 3] 把后两个3, 再插入回去

之前算过的元素就是visited 过了。

```python
class Solution:
    def findRLEArray(
        self, encoded1: List[List[int]], encoded2: List[List[int]]
    ) -> List[List[int]]:
        res = []

        i = 0

        while encoded1 and encoded2:
            value1 = encoded1.pop(0)
            value2 = encoded2.pop(0)

            if value1[1] == value2[1]:
                res.append([value1[0] * value2[0], value1[1]])
            elif value1[1] < value2[1]:
                diff = value2[1] - value1[1]
                encoded2.insert(0, [value2[0], diff])
                res.append([value1[0] * value2[0], value1[1]])
            else:
                diff = value1[1] - value2[1]
                encoded1.insert(0, [value1[0], diff])
                res.append([value1[0] * value2[0], value2[1]])

        return res
```

但是这个解法，只能过47/52 cases, 下面这个就过不了。
Input
encoded1 =
[[1,3],[2,3]]
encoded2 =
[[6,3],[3,3]]

Output
[[6,3],[6,3]]
Expected
[[6,6]]

因为在[6, 3], [6, 3] 之后还是能再合并一次变成 [6, 6]


this is accept solution, but not the best:
```python
class Solution:
    def findRLEArray(self, encoded1: List[List[int]], encoded2: List[List[int]]) -> List[List[int]]:
        res = []

        i = 0 

        while encoded1 and encoded2:
            value1 = encoded1.pop(0)
            value2 = encoded2.pop(0)

            if value1[1] == value2[1]:
                res.append([value1[0] * value2[0], value1[1]])
            elif value1[1] < value2[1]:
                diff = value2[1] - value1[1]
                encoded2.insert(0, [value2[0] , diff])
                res.append([value1[0] * value2[0], value1[1]])
            else:
                diff = value1[1] - value2[1]
                encoded1.insert(0, [value1[0] , diff])
                res.append([value1[0] * value2[0], value2[1]])     
        #if len(res) == 1:
        #    return res
        prev_v, prev_f = res[0][0], res[0][1]
        result = []
        
        for i in range(1, len(res)):
            ##print(res[i][0], res[i][1])
            if res[i][0] == prev_v:
                prev_f = prev_f + res[i][1]
            else:
                result.append([prev_v, prev_f])
                prev_v, prev_f = res[i][0], res[i][1]
        result.append([prev_v, prev_f])
        return result       
```

这里的处理有点像merge interval  的题目，将当前的元素 和 之前结果集里的最后一个元素不停做比较
solution:
```python
class Solution:
    def findRLEArray(self, encoded1: List[List[int]], encoded2: List[List[int]]) -> List[List[int]]:
        p1, p2 = 0, 0
        res = []
        
        while p1 < len(encoded1) and p2 < len(encoded2):
            # Get the current values and lengths from both encoded arrays
            val1, len1 = encoded1[p1]
            val2, len2 = encoded2[p2]
            
            # Find the minimum length for the current pair
            length = min(len1, len2)
            
            # Calculate the product of the current values
            product = val1 * val2
            
            # If the result list is not empty and the last product is the same, add to the last element
            if res and res[-1][0] == product:
                res[-1][1] += length
            else:
                res.append([product, length])
            
            # Decrease the lengths in both arrays
            encoded1[p1][1] -= length
            encoded2[p2][1] -= length
            
            # Move to the next element in encoded1 or encoded2 if the current run is finished
            if encoded1[p1][1] == 0:
                p1 += 1
            if encoded2[p2][1] == 0:
                p2 += 1

        return res
```

better one:
```python
class Solution:
    def findRLEArray(self, encoded1: List[List[int]], encoded2: List[List[int]]) -> List[List[int]]:
        p1, p2 = 0, 0
        res = []
        
        while p1 < len(encoded1):
            # Find the minimum length between the current runs in encoded1 and encoded2
            length = min(encoded1[p1][1], encoded2[p2][1])
            
            # Multiply the values of the two current runs
            product = encoded1[p1][0] * encoded2[p2][0]
            
            # If the result list has a previous run with the same product, update the length
            if res and res[-1][0] == product:
                res[-1][1] += length
            else:
                res.append([product, length])
            
            # Decrease the run lengths
            encoded1[p1][1] -= length
            encoded2[p2][1] -= length
            
            # If the current run in encoded1 is finished, move to the next run
            if encoded1[p1][1] == 0:
                p1 += 1
            
            # If the current run in encoded2 is finished, move to the next run
            if encoded2[p2][1] == 0:
                p2 += 1
        
        return res
```
