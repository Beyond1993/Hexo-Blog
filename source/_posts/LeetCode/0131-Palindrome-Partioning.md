---
title: 0131 Palindrome Partioning
date: 2018-03-10 22:58:04
categories: LeetCode
tags:
---

这题思路很简单，就是先找到一个 palindrome 加到结果集，然后dfs 剩下的palindrome


```python
class Solution:
    def partition(self, s: str) -> List[List[str]]:
        result = []
        self.dfs(s, [], result)
        return result

    def isPalindrome(self, s: str) -> bool:
        return s == s[::-1]

    def dfs(self, s: str, path: List[str], result: List[List[str]]):
        if not s:
            result.append(path.copy())
            return
        for i in range(1, len(s) + 1):
            if self.isPalindrome(s[:i]):
                # add current substring in the currentList
                path += [s[:i]]
                self.dfs(s[i:], path, result)
                path.pop()
                # backtrack and remove the current substring from currentList
```

简化版的:

将传引用变成传参数，每一层的参数都是新生成一个对象，这样就相当于隐式的 add , pop

```python
class Solution:
    def partition(self, s: str) -> List[List[str]]:
        result = []
        self.dfs(s, [], result)
        return result

    def isPalindrome(self, s: str) -> bool:
        return s == s[::-1]

    def dfs(self, s: str, path: List[str], result: List[List[str]]):
        if not s:
            result.append(path)
            return
        for i in range(1, len(s) + 1):
            if self.isPalindrome(s[:i]):
                # add current substring in the currentList
                self.dfs(s[i:], path + [s[:i]], result)
                # backtrack and remove the current substring from currentList
```

```java
public class Solution {
       
    public List<List<String>> partition(String s) {
        
        return  dfs(s, new HashMap<String, List<List<String>>>());
        
    }
    public List<List<String>> dfs(String s, Map<String, List<List<String>>> map ){
        //if (map.containsKey(s)) {
          //  return map.get(s);
        //}
        List<List<String>> res = new ArrayList<List<String>>();
        if (s.isEmpty()) {
            res.add(new ArrayList<String>());
            return res;
        }
        for (int i = 0; i < s.length(); i++) {
            if (isPalindrome(s.substring(0,i+1))) {
                
                List<List<String>> list = dfs(s.substring(i+1),map);
                for (List<String> v : list) {
                    if ( v != null) {
                        v.add(0,s.substring(0,i+1));
                    }
                    res.add(v);
                }
            }
        }
        //map.put(s,res);
        return res;
        
    }
    public boolean isPalindrome(String str){
        int l = 0, r = str.length() - 1;
        if(l==r) return true;
        while(l<r){
            if(str.charAt(l)!=str.charAt(r)) return false;
            l++;r--;
        }
        return true;
    }
}
```
