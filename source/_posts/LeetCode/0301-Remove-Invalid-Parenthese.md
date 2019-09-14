---
title: 0301 Remove Invalid Parenthese
date: 2018-02-23 21:28:55
categories: LeetCode
tags:
---


```java
public class Solution {
    public List<String> removeInvalidParentheses(String s) {
      List<String> res = new ArrayList<>();
      
      // sanity check
      if (s == null) return res;
      
      Set<String> visited = new HashSet<>();
      Queue<String> queue = new LinkedList<>();
      
      // initialize
      queue.add(s);
      visited.add(s);
      
      boolean found = false;
      
      while (!queue.isEmpty()) {
        s = queue.poll();
        
        if (isValid(s)) {
          // found an answer, add to the result
          res.add(s);
          found = true;
        }
      
        if (found) continue;
      
        // generate all possible states
        for (int i = 0; i < s.length(); i++) {
          // we only try to remove left or right paren
          if (s.charAt(i) != '(' && s.charAt(i) != ')') continue;
        
          String t = s.substring(0, i) + s.substring(i + 1);
        
          if (!visited.contains(t)) {
            // for each state, if it's not visited, add it to the queue
            queue.add(t);
            visited.add(t);
          }
        }
      }
      
      return res;
    }
    
    // helper function checks if string s contains valid parantheses
    boolean isValid(String s) {
      int count = 0;
    
      for (int i = 0; i < s.length(); i++) {
        char c = s.charAt(i);
        if (c == '(') count++;
        if (c == ')' && count-- == 0) return false;
      }
    
      return count == 0;
    }
}
```

```java
class Solution {
    public List<String> removeInvalidParentheses(String s) {
        List<String> result = new ArrayList<>();     
        Set<String> set = new HashSet<String>();     
        remove(s,set,0,new char[]{'(',')'});
        for (String str : set) {
            result.add(str);
        }
        return result;
    }
    // last_j remove duolication
    public void remove(String s, Set<String> set,int last_i,char[] store ) {
        
        for(int i = last_i, stack=0; i<s.length(); i++) {
            if (s.charAt(i) == store[0]) {
                stack++;
            } else if (s.charAt(i) == store[1]) {
                stack--;
            }
            if (stack >= 0) {
                continue;
            }
            for (int j = 0; j <= i; j++) {
                if (s.charAt(j) == store[1] && (j == 0 || s.charAt(j - 1) != store[1])) {
                    remove(s.substring(0, j) + s.substring(j + 1), set, i, store);
                }
            }
            return; // 只要有一个invalid, i 就不往后走了，直接返回上一层. 保证加入 set 里的是合法.
        }
        if (store[0]=='(') {
            String reversed = (new StringBuilder(s)).reverse().toString();
            remove(reversed, set,0, new char[]{')','('});
        } else {
            String reversed = (new StringBuilder(s)).reverse().toString();
            set.add(reversed);  
        }
    }
}
```

```java
class Solution {
      public List<String> removeInvalidParentheses(String s) {
        List<String > result=new ArrayList<>();
        remove(s,result,0,0,new char[]{'(',')'});
       return result;
    }
    public void remove(String s,List<String> result,int last_i,int last_j,char[] store ){
        for(int i=last_i, stack=0; i<s.length(); i++) {
            if (s.charAt(i) == store[0]) {
                stack++;
            } else if (s.charAt(i) == store[1]) {
                stack--;
            }
            if (stack >= 0) {
                continue;
            }
            for (int j = last_j; j <= i; j++) {
                if (s.charAt(j) == store[1] && (j == last_j || s.charAt(j - 1) != store[1])) {
                    remove(s.substring(0, j) + s.substring(j + 1), result, i, j, store);
                }
            }
            return;
        }
            String reversed = (new StringBuilder(s)).reverse().toString();
            if (store[0]=='(') {
                remove(reversed,result,0,0,new char[]{')','('});
            } else {
                result.add(reversed);
            }

    }
}
```
