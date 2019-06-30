---
title: 0698 Partition to K Equal Sum Subsets
date: 2019-06-30 02:12:05
categories: LeetCode
tags:
---

```java
class Solution {
    public boolean search(int[] groups, int row, int[] nums, int target) {
        if (row < 0) return true;
        int v = nums[row--];
        for (int i = 0; i < groups.length; i++) {
            if (groups[i] + v <= target) {
                groups[i] += v;
                if (search(groups, row, nums, target)) return true;
                groups[i] -= v;
            }
            /*
            [2,2,2,2,3,4,5]
            4
            
            如果没有这个 break。 在尝试 4, 3, 0 之后 会尝试 4, 0 ,3 这样子是没有任何意义的.
            */
            if (groups[i] == 0) {
                break;
            }
        }
        return false;
    }

    public boolean canPartitionKSubsets(int[] nums, int k) {
        int sum = Arrays.stream(nums).sum();
        if (sum % k > 0) return false;
        int target = sum / k;

        Arrays.sort(nums);
        int row = nums.length - 1;
        if (nums[row] > target) return false;
        while (row >= 0 && nums[row] == target) {
            row--;
            k--;
        }
        return search(new int[k], row, nums, target);
    }
}
```


```java
class Solution {
    public boolean canPartitionKSubsets(int[] nums, int k) {
        
        if(k > nums.length)
             return false;
        
        int sum = 0;
        for(int i = 0; i < nums.length; i++){
            sum += nums[i];
        }
        
        if(sum % k != 0)
             return false;
        
        Arrays.sort(nums);
        return dfs(nums, 0, nums.length - 1, new boolean[nums.length], sum / k, k);
        
    }
    
    public boolean dfs(int[] nums, int sum, int len, boolean[] visited, int target,int level){
        
        if(level == 0)
             return true;
        if(sum == target && dfs(nums, 0, nums.length - 1,visited, target, level - 1))
             return true;
        
        for(int i = len; i >= 0; i--){
            if(!visited[i] && sum + nums[i] <= target){
                 visited[i] = true;
                if(dfs(nums, sum + nums[i],i - 1,visited,target,level))
                    return true;
                visited[i] = false;
            }
        }
          return false;
    }
}
```
