---
title: 0953 Verifying an Alien Dictionary
date: 2019-05-18 19:06:40
categories:
tags:
---

```java
class Solution {
    public boolean isAlienSorted(String[] words, String order) {
        int[] index = new int[256];
        
        for (int i = 0; i < order.length(); i++) {
            index[order.charAt(i)] = i;
        }
        
        for (int i = 0; i < words.length - 1; i++) {
            if (!isValid(words[i], words[i+1], index)) {
                return false;
            }
        }
        
        return true;
    }
    
    private boolean isValid(String prev, String next, int[] index) {
        
        int i = 0;
        int j = 0;
        
        while(i < prev.length() && j < next.length()) {         
            
           // System.out.println(index[prev.charAt(i)] + " " + index[next.charAt(j)]);
            if (index[prev.charAt(i)] < index[next.charAt(j)]) {
                return true;
            }
            
            if (index[prev.charAt(i)] > index[next.charAt(j)]) {
                return false;
            }
            // put i++ j++ in the last step. otherwise other case will throw exception            
            if (index[prev.charAt(i)] == index[next.charAt(j)]) {
                i++;
                j++;
            }
        }
        
        if (i == j && i < prev.length() - 1) {
            return false;
        }
        return true;
    }
}
```
