---
title: Subset Three Solution
date: 2019-03-30 20:50:43
categories: LeetCode
tags:
---

```java
// package whatever; // don't place package name!

/*
Input: nums = [1,2,3]
Output:
[
  [3],
  [1],
  [2],
  [1,2,3],
  [1,3],
  [2,3],
  [1,2],
  []
]
*/

import java.io.*;
import java.util.*;

class MyCode {
	public static void main (String[] args) {
		System.out.println("Hello Java");
    //System.out.println(subset1_2(new int[]{1,2,3}));

    //System.out.println(subsets(new int[]{1,2,3})); 

    System.out.println(subset21(new int[]{1,2,3}));
	}

  
  public static List<List<Integer>> subsets(int[] nums) {
      List<Integer> list = new ArrayList<Integer>();
      List<List<Integer>> res = new ArrayList<>();
      subsetHelper(list, res, 0, nums);
      return res;
  }
  
  private static void subsetHelper(List<Integer> list, List<List<Integer>> res, int index, int[] nums)
  {   System.out.println(index);
      if (index == nums.length)
      {
        System.out.println(list);
        res.add(new ArrayList<Integer>(list));
        return;
      }
      
      list.add(nums[index]);
 
      subsetHelper(list, res, index + 1, nums);

      list.remove(list.size() - 1);

      subsetHelper(list, res, index + 1, nums);      
      
  }



    public static List<List<Integer>> subset1_2(int[] nums){
        List<List<Integer>> ans = new ArrayList<>();
        if( nums==null|| nums.length==0) return ans;
        helper(ans, new ArrayList<Integer>(), 0, nums);
        return ans;
    }

    public static void helper(List<List<Integer>> ans, ArrayList<Integer> temp, int index, int[] nums){
        if(index==nums.length){
            
            ans.add(new ArrayList<Integer>(temp));
            return;
        }
        temp.add(nums[index]);
        helper(ans, temp, index+1, nums);
        temp.remove(temp.size()-1);
        helper(ans, temp, index+1, nums);
    }

    public static List<List<Integer>> subset21(int[] nums)
    {
        List<List<Integer>> res = new ArrayList<>();
        List<Integer> list = new ArrayList<>();
        subset2_1Helper(list, res, 0, nums);
        return res;

    }

    public static void subset2_1Helper(List<Integer> list, List<List<Integer>> res, int index, int[] nums)
    {
      res.add(new ArrayList<Integer>(list));// 
      if (index == nums.length) 
      {
        return;
      }
    //   //index : 2 nums[2] = 3
      for (int i = index; i < nums.length; i++)
      {
        list.add(nums[i]); // [1, 3]
        subset2_1Helper(list, res, i + 1, nums);
        list.remove(list.size() - 1);
      }

    }
}
/*
{a,b,c}

{a}, {b}, {c}, {ab} {ac} {bc} {abc}

{} 

左边放 右边不放

           {}
a        /   \
       a      {}
      /  \     / \
b   ab    a    b    {}
   /  \   /\  / \  / \
c abc ab ac a bc b c {}
*/

/*
                {} 
            /    |    \ 
 0       a(bc)  b(c)   c 
        / \     | 
 1    ab  ac   bc 
      /   / \
 2  abc     acc

 3  
*/ 

/* bfs
a  {}{a} 
b  {}{a}{b}{ab} 
c  {}{a}{b}{ab}{c}{ac}{bc}{abc} 
*/

/*
a,

a, {b, ab}

a, b, ab, {c, ac, bc, abc}

*/

public List<String> subsetII(String str) { 
       List<String> result = new LinkedList<>(); 
       if(str == null) return result; 
 
       result.add(""); 
       for(int i = 0; i < str.length(); ++i) { 
           int size = result.size(); 
           for(int index = 0; index < size; ++index) { 
               String temp = result.get(index); 
               result.add(temp + str.charAt(i)); 
           } 
       } 
 
       return result; 
   } 
```
