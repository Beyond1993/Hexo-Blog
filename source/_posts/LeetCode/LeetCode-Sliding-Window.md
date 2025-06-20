---
title: LeetCode-Sliding-Window
date: 2017-11-05 02:38:23
categories: LeetCode-Index
tags:
---

Sliding Window 几乎是必考题

https://leetcode.com/problems/longest-substring-with-at-most-two-distinct-characters/discuss/

最长不重复字串
https://leetcode.com/problems/longest-substring-without-repeating-characters/description/

Sliding Window 的模版

```java
public class Solution {
    public List<Integer> slidingWindowTemplateByHarryChaoyangHe(String s, String t) {
        //init a collection or int value to save the result according the question.
        List<Integer> result = new LinkedList<>();
        if(t.length()> s.length()) return result;
        
        //create a hashmap to save the Characters of the target substring.
        //(K, V) = (Character, Frequence of the Characters)
        Map<Character, Integer> map = new HashMap<>();
        for(char c : t.toCharArray()){
            map.put(c, map.getOrDefault(c, 0) + 1);
        }
        //maintain a counter to check whether match the target string.
        int counter = map.size();//must be the map size, NOT the string size because the char may be duplicate.
        
        //Two Pointers: begin - left pointer of the window; end - right pointer of the window
        int begin = 0, end = 0;
        
        //the length of the substring which match the target string.
        int len = Integer.MAX_VALUE; 
        
        //loop at the begining of the source string
        while(end < s.length()){
            
            char c = s.charAt(end);//get a character
            
            if( map.containsKey(c) ){
                map.put(c, map.get(c)-1);// plus or minus one
                if(map.get(c) == 0) counter--;//modify the counter according the requirement(different condition).
            }
            end++;
            
            //increase begin pointer to make it invalid/valid again
            while(counter == 0 /* counter condition. different question may have different condition */){
                
                char tempc = s.charAt(begin);//***be careful here: choose the char at begin pointer, NOT the end pointer
                if(map.containsKey(tempc)){
                    map.put(tempc, map.get(tempc) + 1);//plus or minus one
                    if(map.get(tempc) > 0) counter++;//modify the counter according the requirement(different condition).
                }
                
                /* save / update(min/max) the result if find a target*/
                // result collections or result int value
                
                begin++;
            }
        }
        return result;
    }
}
```
滑动窗口型的两指针，有点像二分法，难点在条件的判断上.

**滑动窗口的四要素：map, counter, index, 两指针**


Map <Character, Integer>  = <char,count>

input is stream:
Map&lt;Character,Integer> = &lt;char,index&gt;



similar question:
[3 Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/)

[30 Substring with Concatenation of All Words](https://leetcode.com/problems/substring-with-concatenation-of-all-words/)

[76 Minimum Window Substring](https://leetcode.com/problems/minimum-window-substring/)

[159 Longest Substring with At Most Two Distinct Characters](https://leetcode.com/problems/longest-substring-with-at-most-two-distinct-characters/)

[438 Fina All Anagrams in a String](https://leetcode.com/problems/find-all-anagrams-in-a-string/)

http://www.wayne.ink/2018/02/17/Interview/Interview-Amazon-%E7%A4%BE%E6%8B%9B-OA/

sliding window 优先考虑右指针 能 
