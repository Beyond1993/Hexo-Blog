---
title: 0653 Two Sum IV - Input is a BST
date: 2018-05-08 02:53:21
categories: LeetCode
tags:
---

Given a Binary Search Tree and a target number, return true if there exist two elements in the BST such that their sum is equal to the given target.

Example 1:
Input:
```text 
    5
   / \
  3   6
 / \   \
2   4   7
```
Target = 9

Output: True
Example 2:
Input: 
```text
    5
   / \
  3   6
 / \   \
2   4   7
```
Target = 28

Output: False

解法一:

```java
public boolean findTarget(TreeNode root, int k) {
        if (root == null) return false;
        Set<Integer> set = new HashSet<Integer>();
        return find(root,k,set);
    }
    
    boolean find(TreeNode root, int k, Set<Integer> set) {
        if (root == null) return false;
        if (set.contains(k - root.val)) {
            return true;
        }
        
        set.add(root.val);
        return find(root.left, k, set) || find(root.right, k, set);
        
    }
```



解法四:

```java
public boolean findTarget(TreeNode root, int target) {
        if (root == null) return false;
        
        Deque<TreeNode> minStack = new LinkedList<>();
        Deque<TreeNode> maxStack = new LinkedList<>();
        
        helper(root, minStack, true);
        helper(root, maxStack, false);
        
        while (!minStack.isEmpty() && !maxStack.isEmpty()) {
           int min = minStack.peek().val;
           int max = maxStack.peek().val;

           // deduplicate 

         if(min == maxStack.peekLast().val || max == minStack.peekLast().val) {
           if(min == maxStack.peekLast().val) maxStack.pollLast();
           else minStack.pollLast();
           continue;
         }

         int sum = minStack.peek().val + maxStack.peek().val;
         if(sum == target) return true;
         if(sum < target) {
             helper(minStack.poll().right, minStack, true);
         } else {
           helper(maxStack.poll().left, maxStack, false);
         }
       }
       return false;
    }

    public void helper(TreeNode root, Deque<TreeNode> stack, boolean isLeft) {
        if(root == null) return;
        stack.push(root);
        if(isLeft) helper(root.left, stack, true);
        else helper(root.right, stack, false);
    }
```

