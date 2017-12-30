---
title: 0014 Longest Common Prefix
date: 2017-12-28 05:29:35
categories: LeetCode
tags:
---

```java
public class Solution {
    public String longestCommonPrefix(String[] strs) {
    if(strs == null || strs.length == 0)    return "";
    String pre = strs[0];
    int i = 1;
    while(i < strs.length){
        while(strs[i].indexOf(pre) != 0)
            pre = pre.substring(0,pre.length()-1);
        i++;
    }
    return pre;
    }
}
```


```cpp
/*this problem is simple, step1, calculate the common prefix of strs[0] and strs[1]
step2: use this prefix compare to other elements, the newPre <= prefix !!

这题用prefix += str1[i];用prefix.append(str1[i])会出错，因为paramter is const char *
必须要用prefix.append(&str1[i])

使用prefix.append(&str1[i]);时
Memory Limit Exceeded！！！

改用：prefix += str1[i];

*/
class Solution {
public:
    string prefix(string str1, string str2){
        string  prefix ="";
        for(int i=0;i<str1.length()&&i<str2.length();i++){
            if(str1[i] == str2[i]){
                prefix += str1[i];
                //prefix.append(&str1[i]);
            }else break;
        }
        return prefix;
    }
    string longestCommonPrefix(vector<string>& strs) {
        if(strs.empty()) return "";
        if(strs.size()==1) return strs[0];
        string commonPrefix = prefix(strs[0],strs[1]);
        for(int i=2;i<strs.size();i++){
            commonPrefix = prefix(commonPrefix,strs[i]);
        }
        return commonPrefix;
    }
};
```
C++ 

string (1) string& operator+= (const string& str);
c-string (2) string& operator+= (const char* s);
character (3) string& operator+= (char c);
initializer list (4) string& operator+= (initializer_list<char> il);

string (1) string& append (const string& str);
substring (2) string& append (const string& str, size_t subpos, size_t sublen);
c-string (3) string& append (const char* s);
buffer (4) string& append (const char* s, size_t n);
fill (5) string& append (size_t n, char c);
range (6) template &lt;class InputIterator&gt; string& append (InputIterator first, InputIterator last);
initializer list(7) string& append (initializer_list&lt;char&gt; il);
