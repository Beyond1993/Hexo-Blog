---
title: 1481. Least Number of Unique Integers after K Removals
date: 2020-09-20 04:44:05
categories: LeetCode
tags:
---

Given an array of integers arr and an integer k. Find the least number of unique integers after removing exactly k elements.

 

Example 1:

Input: arr = [5,5,4], k = 1
Output: 1
Explanation: Remove the single 4, only 5 is left.
Example 2:
Input: arr = [4,3,1,1,3,3,2], k = 3
Output: 2
Explanation: Remove 4, 2 and either one of the two 1s or three 3s. 1 and 3 will be left.

Constraints:
- 1 <= arr.length <= 10^5
- 1 <= arr[i] <= 10^9
- 0 <= k <= arr.length

O(NlogN), O(N)

```java
class Solution {
    public int findLeastNumOfUniqueInts(int[] arr, int k) {
        
        Map<Integer, Integer> map = new HashMap<>();
        
        for (int i = 0; i < arr.length; i++) {
            map.put(arr[i], map.getOrDefault(arr[i], 0) + 1);
        }
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        
        for (int v : map.values()) {
            pq.add(v);    
        }
        
        while(k > 0) {
            int cur = pq.poll();
            k -= cur;
        }
        
        return  k == 0? pq.size() : pq.size() + 1; 
    }
}
```

利用桶排序:
1. Count the occurrences of each number using HashMap;
2. Using Array to count each occurrence, since max occurrence <= arr.length;
3. From small to big, for each unvisited least frequent element, deduct from k the multiplication with the number of elements of same occurrence, check if reaching 0, then deduct the correponding unique count remaining.

