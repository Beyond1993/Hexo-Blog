---
title: 0843 Guess the Word
date: 2019-09-01 20:53:10
categories: LeetCode
tags:
---


```java
/**
 * // This is the Master's API interface.
 * // You should not implement it, or speculate about its implementation
 * interface Master {
 *     public int guess(String word) {}
 * }
 */
class Solution {
    
    public void findSecretWord(String[] wordlist, Master master) {
        List<String> list = new ArrayList<>( Arrays.asList(wordlist));
      
        for (int i = 0; i < 10; i++) {
            int n = list.size();
            int index = new Random().nextInt(n);
            int guessNum = master.guess(list.get(index));
            List<String> w2 = new ArrayList<String>();
            for (int j = 0; j < n; j++) {
                if (compare(list.get(index), list.get(j)) == guessNum) {
                    w2.add(list.get(j));
                }
            }
            list = w2;
        }
        //dfs(list, master);
    }
    
    private void dfs(List<String> wordlist,  Master master) {
        if (wordlist.isEmpty()) return;
        int index = new Random().nextInt(wordlist.size());
        System.out.println(index);
        String str = wordlist.get(index);
        int num = master.guess(str);
        wordlist.remove(0);
        for (int i = 0; i < wordlist.size(); i++) {
            if (compare(str ,wordlist.get(i) )  != num) {
                wordlist.remove(i);
            } 
        }
        
        dfs(wordlist, master);
    }
    
    private int compare(String a, String b) {
        char[] ch1 = a.toCharArray();
        char[] ch2 = b.toCharArray();
        int count = 0;
        for (int i = 0; i < 6; i++) {
            if (ch1[i] == ch2[i]) {
                count++;
            }
        }
        return count;
    }
}
```
