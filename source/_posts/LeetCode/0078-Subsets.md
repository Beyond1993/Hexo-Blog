---
title: 0078 Subsets
date: 2017-12-23 23:16:48
categories: LeetCode
tags:
---

题目描述：

Given a set of distinct integers, nums, return all possible subsets (the power set).

Note: The solution set must not contain duplicate subsets.

For example,
If nums = [1,2,3], a solution is:

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


```java
public class Solution {
    List<List<Integer>> ans = new ArrayList<List<Integer>>();
    List<Integer> tmp = new ArrayList<Integer>();
    private void dfs(int[] nums, int pos) {
        ArrayList temp = new ArrayList<Integer>(tmp);    
        ans.add(temp);
        for (int i = pos; i < nums.length; i++) {
            tmp.add(nums[i]);
            dfs(nums, i + 1);
            tmp.remove(tmp.size() - 1);
        }
    }
    public List<List<Integer>> subsets(int[] nums) {
        dfs(nums, 0);
        return ans;
    }
}
```

因为排列是有顺序的，所以 每次递归里的循环必须从头来。但是组合则不然，选中一个，只能再余下里的选。那有些人可能会问了，求排列的的时候也是这样子的啊。先学院一个，再选下一个，问题就在于[1,2] 我排列可以[1,2], [2,1], 是可以往回选的。组合则不行。所以在排列中 i = 0, 组合中 i = pos.


1. 方法1:
左放，右不放

```text
              {}
            /   \
          a      {}
         / \     /  \   
        ab a{}  a     {}
       / \     / \    / \
     abc ab{} ab  ac ac a  bc 
```

```text
    ""
    "" | "a"
    "" "a" | "b" "ab"
    "" "a" "b" "ab" | "c" "bc" "abc"
```


 
```java
/** 
* given a string, find all unique subsets except empty 
* example: abc -> {a}, {b}, {c}, 
*              -> {a, b}, {a, c}, {b, c} 
*              -> {a, b, c} 
*/ 
public class ​Q03_Subsets { 
 
  // solution 1: 穷举法，根据元素生成subset 
  // solution 2: insert，根据长度生成subset 
  // solution 3: delete，根据长度生成subset 
  // solution 4: BFS生成subset 
  // solution 5: backtracking的迭代写法 
 
  // solution 6: sort，穷举法的去重 
  // solution 7: sort，根据长度去重 
  // solution 8: local set的去重 
  // solution 9: global set的去重 
 
   // solution 1: brute force enum 
   //   depth: elements of input data, the ith level present the ith element in input data 
   // branch: for each expanding node,  status of current processing element are becoming branches 
   ​/**                       {} 
    *                  /           \ 
    * a             a             {} 
    *           /      \            /  \ 
    * b     ab        a       b    {} 
    *        /   \      /\      / \     /\ 
    * c  abc ab ac a bc  b c {} 
    */ 
   ​public ​List<String> subset1(String str) { 
       ​if ​(str == ​null​) ​return new ​LinkedList<>(); 
       List<String> result = ​new ​LinkedList<>(); 
       dfs1(result, str, ​0​, ​new ​StringBuilder()); 
       ​return ​result; 
   } 
 
   ​private void ​dfs1(List<String> result, String str, ​int ​level, StringBuilder temp) { 
       ​if​(level == str.length()) { 
           result.add(temp.toString()); 
           ​return​; 
       } 
       ​char ​c = str.charAt(level); 
       dfs1(result, str, level + ​1​, temp.append(c)); 
       temp.deleteCharAt(temp.length() - ​1​); 
 
       dfs1(result, str, level + ​1​, temp); 
   } 
 
// solution 2: insert   → 2 ^ n, compare to brute force, it save half time 
     depth: length of subset 
   branch: un-visited elements of expanding nodes. 
      ​/**                  {} 
    *             /         |        \ 
    * 1       a(bc)   b(c)      c 
    *         / \           | 
    * 2    ab ac      bc 
    *      / 
    * 3  abc 
    */ 
   ​public ​List<String> subset2(String str) { 
       ​if ​(str == ​null​) ​return new ​LinkedList<>(); 
       List<String> result = ​new ​LinkedList<>(); 
       dfs2(result, str, ​0​, ​new ​StringBuilder()); 
       ​return ​result; 
   } 
 
   ​public void ​dfs2(List<String> result, String str, ​int ​level, StringBuilder temp) { 
       result.add(temp.toString()); 
       ​if​(level == str.length()) ​return​; 
       ​for​(​int ​i = level; i < str.length(); i++) { 
           temp.append(str.charAt(i)); 
           dfs2(result, str, i + ​1​, temp); 
           temp.deleteCharAt(temp.length() - ​1​);    // O(1) 
       } 
   } 
 
// solution 2: delete char   → 2 ^ n, compare to brute force, it save half time 
  depth: number of characters needs to be delete. 
branch: how many characters could be delete at expanding node. 
   ​/**              abc 
    *             /    |  \ 
    * 1       bc  ac  ab 
    *          / \    | 
    * 2     c  b   a 
    *       / 
    * 3  {} 
    */ 
   ​public ​List<String> subset3(String str) { 
       ​if ​(str == ​null​) ​return new ​LinkedList<>(); 
       List<String> result = ​new ​LinkedList<>(); 
       dfs3(result, ​0​, ​new ​StringBuilder(str)); 
       ​return ​result; 
   } 
 
   ​public void ​dfs3(List<String> result, ​int ​level, StringBuilder temp) { 
       ​if​(temp.length() == ​0​) ​return​; 
       result.add(temp.toString()); 
 
       ​for​(​int ​i = level; i < temp.length(); i++) { 
           ​char ​c = temp.charAt(i); 
           temp.deleteCharAt(i);   ​// operator: O(n) 
           ​dfs3(result, i, temp); 
           temp.insert(i, c); 
       } 
   } 
 
   ​// BFS solution:   → T: 2 ^n  S: 2 ^ n 
a  {}{a} 
b  {}{a}{b}{ab} 
c  ​{}{a}{b}{ab}{c}{ac}{bc}{abc} 
 // BFS VS DFS:  
BFS cost more memory     →  search best path →   dp 
DFS limit of depth, 10000  → less space → search all result   →  easy implement and easy to understand 
   ​public ​List<String> subsetII(String str) { 
       List<String> result = ​new ​LinkedList<>(); 
       ​if​(str == ​null​) ​return ​result; 
 
       result.add(​""​); 
       ​for​(​int ​i = ​0​; i < str.length(); ++i) { 
           ​int ​size = result.size(); 
           ​for​(​int ​index = ​0​; index < size; ++index) { 
               String temp = result.get(index); 
               result.add(temp + str.charAt(i)); 
           } 
       } 
 
       ​return ​result; 
   } 
 
   ​// convert recursion to iteration. 
   /**                      {} 
    *                 /      |    \  
    * 1           a       b    c  
    *           /    \      | 
    * 2     ab  ac    bc  
    *       / \  
    * 3  abc  
    * 
    * the key is to know the index of last character of the poll string. 
    */ 
   ​public ​List<String> subsetII2(String str) { 
       List<String> result = ​new ​LinkedList<>(); 
       ​if​(str == ​null​) ​return ​result; 
 
       Queue<String> queue = ​new ​LinkedList<>(); 
       queue.offer(​""​); 
       ​while ​(!queue.isEmpty()) { 
           String node = queue.poll(); 
           ​int ​start = node.length() > ​0 ​? node.charAt(node.length() - ​1​) - ​'a' ​: -​1​; 
           ​for ​(​int ​offset = start + ​1​; offset < str.length(); ++offset) { 
               queue.offer(node + str.charAt(offset)); 
           } 
           result.add(node); 
       } 
 
       ​return ​result; 
   } 
 
// follow up: what if duplicates exist? 
/**                   {} 
*                 /        \ 
* a           {}           a 
*            /  \         /    \ 
* b      {}    b      a      ab 
*        / \   / \     / \        / \ 
* a  {}  a b ba a  aa ab aba 
*/ 
public ​List<String> subset6(String input) { 
   List<String> result = ​new ​ArrayList<String>(); 
   ​if ​(input == ​null​) ​return ​result; 
   ​char​[] chars = input.toCharArray(); 
   ​// Make sure the multi-set is sorted so that we can dedup. 
   ​Arrays.​sort​(chars); 
   helper(chars, ​new ​StringBuilder(), ​0​, result); 
   ​return ​result; 
} 
 
// index: at current level, determine if the element at "index" should be 
// included in the subset or not. 
private void ​helper(​char​[] chars, StringBuilder tempRes, ​int ​index, List<String> result) { 
   ​if ​(index == chars.​length​) { 
       result.add(tempRes.toString()); 
       ​return​; 
   } 
   helper(chars, tempRes.append(chars[index]), index + ​1​, result); 
   tempRes.deleteCharAt(tempRes.length() - ​1​); 
   ​// skip all the consecutive and duplicate elements. 
   ​while ​(index < chars.​length ​- ​1 ​&& chars[index] == chars[index + ​1​]) { 
       index++; 
   } 
   helper(chars, tempRes, index + ​1​, result); 
} 
 
//  
public ​List<String> subset7(String input) { 
   List<String> result = ​new ​ArrayList<>(); 
   ​if ​(input == ​null​) ​return ​result; 
 
   ​char​[] chars = input.toCharArray(); 
   Arrays.​sort​(chars); 
 
   helperII(chars, ​new ​StringBuilder(), ​0​, result); 
   ​return ​result; 
} 
 
// index: We pick the element by ascending order, "index" is the smallest 
// index we can pick for the subset. 
private void ​helperII(​char​[] chars, StringBuilder tempRes, ​int ​index, List<String> result) { 
   result.add(tempRes.toString()); 
   ​// For the consecutive duplicate elements, we only pick the first one. 
   ​for ​(​int ​i = index; i < chars.​length​; i++) { 
       ​if ​(i == index || chars[i] != chars[i - ​1​]) { 
           tempRes.append(chars[i]); 
           helperII(chars, tempRes, i + ​1​, result); 
           tempRes.deleteCharAt(tempRes.length() - ​1​); 
       } 
   } 
} 
 
// follow up: what if duplicate exists? 
/**             {} 
*            /  | \ 
* 1       a   b  a 
*        / \  | 
* 2    ab  aa ba 
*      / 
* 3  aba 
*/ 
public void ​dfs8(List<String> result, String str, ​int ​level, StringBuilder temp) { 
   result.add(temp.toString()); 
   ​if​(level == str.length()) ​return​;      ​//  显性约束 
 
   ​Set<Character> set = ​new ​HashSet<>(); 
   ​for​(​int ​i = level; i < str.length(); i++) { 
       ​//隐形约束 
       ​if​(!set.add(str.charAt(i)))  ​continue​;    ​// cut branch 
 
       ​temp.append(str.charAt(i)); 
       ​dfs8(result, str, i + ​1​, temp);  
       ​temp.deleteCharAt(temp.length() - ​1​); 
   ​} 
} 
 
// optimization: put the set to the argument 
public void ​dfs9(List<String> result, String str, ​int ​level, StringBuilder temp, Set<Character> set) { 
   result.add(temp.toString()); 
   ​if​(level == str.length()) ​return​;      ​//  显性约束 
 
   ​for​(​int ​i = level; i < str.length(); i++) { 
       ​//隐形约束 
       ​if​(!set.add(str.charAt(i)))  ​continue​;    ​// cut branch 
 
       ​temp.append(str.charAt(i));     ​// 
       ​dfs8(result, str, i + ​1​, temp);    ​//  next level /// 
       ​temp.deleteCharAt(temp.length() - ​1​);    ​// 
 
       ​set.remove(str.charAt(i)); ​// reset the set to init status 
   ​} 
} 
```
