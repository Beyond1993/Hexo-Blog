---
title: 0804 Unique Morse Code Words
date: 2020-02-21 08:25:54
categories: LeetCode
tags:
---

```java
import java.io.*;
import java.util.*;

/*
 * To execute Java, please define "static void main" on a class
 * named Solution.
 *
 * If you need more classes, simply define them inline.
 */

/*
case1 : -...-.-...-

case2: 

*/

class Solution {

  static String[] letter = new String[]{".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."};

  
  static List<String> ans = new ArrayList<>();
  static Map<String, Character> map = new HashMap<>();

  // "..--..-" i "asc" i 
  public static void backtrack(String s, int i, String curr){
    // System.out.println(i + " " + curr);
    if(i == s.length()){
      // System.out.println("result: " + curr);
      ans.add(curr);
      return;
    }
    for(int j = 0; j < 4 && i + j < s.length(); j++){
      String c = s.substring(i, i + j + 1);
      // System.out.println(c);
      if(!map.containsKey(c)){
        continue;
      }
      
      backtrack(s, i + j + 1, curr + map.get(c));
      
      // curr = curr.substring(0, curr.length());
    }
  }
  public static void decode(String s){
    for(int i = 0; i < 26; i++){
      map.put(letter[i], (char)('a' + i));
    }
    
    backtrack(s, 0, "");
  }

    
  
    
    public static List<String> decode2(String s) {
        Map<String, Character> map = new HashMap<>();
        List<String> res = new ArrayList<String>();
        for (int i = 0; i < letter.length; i++) {
            map.put(letter[i], (char)(i + 'a'));
        }
        helper(s, "", res, map);
        return res;
    }

    public static void helper(String s, String list, List<String> res, 
                       Map<String, Character> map) {
     
     if(s.isEmpty()) {
          res.add(list);
          return;
      }
        
      for (int i = 1; i < s.length(); i++) {
          String preFix =  s.substring(0, i);
          if (map.containsKey(preFix)) {
              helper(s.substring(i), list + map.get(preFix), res, map);
          }
      }
    }
  
  
  
  public static void main(String[] args) {
    
    decode("-...-.-...-");
    for(String s: ans){
      System.out.print("\"" + s + "\",");
    }
    System.out.println(ans.size());
    List<String> res = decode2("-...-.-...-");
    System.out.println(res.size());
    
  }
}
```

