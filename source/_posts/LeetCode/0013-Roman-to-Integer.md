---
title: 0013 Roman to Integer
date: 2017-12-28 05:29:09
categories: LeetCode
tags:
---

Given a roman numeral, convert it to an integer.

Input is guaranteed to be within the range from 1 to 3999.

注意 上一篇讲的 9 90 98 99 这些数字

```java
public class Solution {
    public int romanToInt(String s) {
      char[] str = s.toCharArray();
      int res = toNum(str[0]);
      for(int i=1;i<str.length;i++){
        if(toNum(str[i]) > toNum(str[i-1]) ){
          res += toNum(str[i]) - 2 * toNum(str[i-1]); //for 9 90 900 ,it impossible to show "XCC" 
        }else{
          res += toNum(str[i]);
        }
      }
        return res;
    }
    
    public  int toNum(char ch){
      switch(ch){
          case 'I': return 1;
          case 'V': return 5;
          case 'X': return 10;
          case 'L': return 50;
          case 'C': return 100;
          case 'D': return 500;
          case 'M': return 1000;
        }
        return 0;
    }
}
```
两个两个比较. 如果比后一个小，就是负号, 如果比后面大，就是正号。
CMLXIV

better solution

```java
class Solution {
    public int romanToInt(String s) {
        int res = 0;
        for (int i = 0; i < s.length() - 1; i++) { 
            if (toNum(s.charAt(i)) < toNum(s.charAt(i + 1))) {
                res -= toNum(s.charAt(i));
            } else {
                res += toNum(s.charAt(i));
            }
        }
        res += toNum(s.charAt(s.length() - 1));
        return res;
    }
    
    public  int toNum(char ch){
        switch(ch) {
            case 'I': return 1;
            case 'V': return 5;
            case 'X': return 10;
            case 'L': return 50;
            case 'C': return 100;
            case 'D': return 500;
            case 'M': return 1000;
        }
        return 0;
    }
}
```
