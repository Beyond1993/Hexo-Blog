---
title: Interview-Mobstaz
date: 2018-01-09 23:39:37
categories: Interview
tags:
---



```java
public class SmartCollection {
    List<Integer> nums;
    
    public SmartCollection() {
      nums = new ArrayList<Integer>();
    }
    // add a num to the collection
    public void add(int num) {
      if (nums == null || nums.size() == 0 || num <= nums.get(0)) {
          nums.add(num, 0);
      }
      for (int i = 0; i < nums.size(); i++) {
        if ((num > nums.get(i) && num < nums.get(i+1)) || i == nums.size() ) {
           nums.add(num, i + 1);
        } 
      } 
    }
    
    // return the max number in the collection which is smaller than or euqal to the input target.
    // return Integer.MAX_VALUE if not exists
    public int query(int target) {
      int begin = 0;
      int end = nums.size() - 1;
      
      while(begin + 1 < end) {
        int mid = begin + (end - begin) / 2; 
        
        if (nums[mid] == target) {
            return target;
        }
        
        if (nums[mid] > target) {
            end = mid;
        } else { // nums[i] < target
            begin = mid;
        }
      }
      
      target nums[begin] nusm[end];
      
      if (target >=nums[end]) {
          return nums[end];
      }
      
      if (target >= nums[begin]) {
          return nums[begin];
      }
      
      return -1;
    }
}

1,3,4,6,7

5

1, 4

7, 50, 20

query: 50 -> 50
query: 30 -> 20
query: 6 -> MAX_VALUE
```

