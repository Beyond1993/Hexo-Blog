---
title: 0846 Hand of Straights
date: 2020-05-16 10:13:24
categories: LeetCode
tags:
---


Alice has a hand of cards, given as an array of integers.

Now she wants to rearrange the cards into groups so that each group is size W, and consists of W consecutive cards.

Return true if and only if she can.

 

Example 1:

Input: hand = [1,2,3,6,2,3,4,7,8], W = 3
Output: true
Explanation: Alice's hand can be rearranged as [1,2,3],[2,3,4],[6,7,8].
Example 2:

Input: hand = [1,2,3,4,5], W = 4
Output: false
Explanation: Alice's hand can't be rearranged into groups of 4.

```java
class Solution {
    public boolean isNStraightHand(int[] hand, int W) {
        if (hand.length % W != 0) return false;
        TreeMap<Integer, Integer> map = new TreeMap<>();
        
        for (int i : hand) {
            map.put(i, map.getOrDefault(i,0) + 1);
        }
        
        int count = hand.length / W;
        
        while(count > 0) {
            int key = map.firstKey();
            int index = W;
            while(index > 0) {
                if (!map.containsKey(key)) return false;
                int v = map.get(key);
                v--;       
                if (v == 0) {
                   map.remove(key);
                } else {
                    map.put(key, v);
                }
                key++;
                index--;
            }
            count--;
        }
        return true;
    }
}
```
