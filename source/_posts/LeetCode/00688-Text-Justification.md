---
title: 00688 Text Justification
date: 2019-08-14 13:37:41
categories: LeetCode
tags:
---


```java
class Solution {
    public List<String> fullJustify(String[] words, int maxWidth) {
        List<String> result = new ArrayList<String>();
        if (words.length == 0) {
            return result; 
        }
        int curLen = 0;
        List<String> temp = new ArrayList<String>();
        for (int i = 0; i < words.length; i++) {
            curLen += words[i].length() + 1;
            if (curLen - 1 <= maxWidth ) {
                temp.add(words[i]);
                
            } else {               
               String line = helper(temp, maxWidth, false);
               result.add(line);
               temp.clear();
               temp.add(words[i]);
               curLen = 0;
               curLen = words[i].length() + 1;
            }
        }
       
        String s = helper(temp, maxWidth, true);
        result.add(s);
        
        return result;
    }

            int spaceLen = maxWidth - list.get(0).length();
            String space = "";
            for (int i = 0; i < spaceLen; i++) {
                space += " ";  
            }
          
            return list.get(0) + space;
        }
        //calculate number of space
        int len = 0;
        for (String w : list) {
            len += w.length();  
        }
      
        if (isLastLine) {
            int totalLen = len + list.size();
            int spaceLen = maxWidth - totalLen;
            String s = "";
            for (int i = 0; i <  list.size() - 1; i++) {
                s += list.get(i) + " ";
            }
            s += list.get(list.size() - 1);
            for (int i = 0; i <= spaceLen; i++) {
                s += " ";
            }
            return s;
        }
    
        int spaceLen = maxWidth - len;
        int n = spaceLen / (list.size() - 1);
        int remind = spaceLen % (list.size() - 1);
        StringBuilder sb = new StringBuilder();
        if (remind == 0) {
            
            for (int i = 0; i < list.size() - 1; i++) {
                String space = "";
                for (int j = 0; j < n; j++)
                {
                    space += " "; 
                }
                sb.append(list.get(i) + space);
            }
           
            sb.append(list.get(list.size() - 1)); 
            return sb.toString();
        } else {
            
            for (int i = 0; i < list.size() - 1; i++) {
                String space = "";
                for (int j = 0; j < n; j++)
                {   
                    if (remind > 0) {
                      space += " ";
                      remind--;
                    }
                    space += " "; 
                }
                sb.append(list.get(i) + space);
            }
           
            sb.append(list.get(list.size() - 1)); 
            return sb.toString();
        }     
  }
}
```
