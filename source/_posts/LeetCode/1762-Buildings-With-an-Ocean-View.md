---
title: 1762-Buildings-With-an-Ocean-View
date: 2023-12-23 04:47:50
categories: LeetCode
tags:
---


There are n buildings in a line. You are given an integer array heights of size n that represents the heights of the buildings in the line.

The ocean is to the right of the buildings. A building has an ocean view if the building can see the ocean without obstructions. Formally, a building has an ocean view if all the buildings to its right have a smaller height.

Return a list of indices (0-indexed) of buildings that have an ocean view, sorted in increasing order.

 

Example 1:

Input: heights = [4,2,3,1]
Output: [0,2,3]
Explanation: Building 1 (0-indexed) does not have an ocean view because building 2 is taller.
Example 2:

Input: heights = [4,3,2,1]
Output: [0,1,2,3]
Explanation: All the buildings have an ocean view.
Example 3:

Input: heights = [1,3,2,4]
Output: [3]
Explanation: Only building 3 has an ocean view.


```java

class Solution {
        public int[] findBuildings(int[] heights) {
        ArrayList<Integer> result = new ArrayList<>();

		// Last building can always see the ocean
        int maxHeight = heights[heights.length-1];
        result.add(heights.length-1);
        
		// Start from 2nd last and keep track of tallest building
        for(int i = heights.length - 2; i >=0; i--) {
            if(heights[i] > maxHeight) result.add(i);
            
            maxHeight = Math.max(maxHeight, heights[i]);
        }
        
        Collections.reverse(result);
        
        return result.stream().mapToInt(i -> i).toArray();
    }
}
```

