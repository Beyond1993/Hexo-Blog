---
title: 1152 Analyze User Website Visit Pattern
date: 2021-03-01 00:45:13
categories:
tags:
---

We are given some website visits: the user with name username[i] visited the website website[i] at time timestamp[i].

A 3-sequence is a list of websites of length 3 sorted in ascending order by the time of their visits.  (The websites in a 3-sequence are not necessarily distinct.)

Find the 3-sequence visited by the largest number of users. If there is more than one solution, return the lexicographically smallest such 3-sequence.


```java
class Solution {
    public List<String> mostVisitedPattern(String[] username, int[] timestamp, String[] website) {
        
        HashMap<String, TreeMap<Integer, String>> utwRecords = new HashMap<>();
        for (int i = 0; i < username.length; i++) {
            if (!utwRecords.containsKey(username[i])) {
                utwRecords.put(username[i], new TreeMap<Integer, String>());
            }
            utwRecords.get(username[i]).put(timestamp[i], website[i]);
        }

    
        HashMap<String, ArrayList<String>> uwRecords = new HashMap<>();
        for (String name : utwRecords.keySet()) {
            uwRecords.put(name, new ArrayList<String>());
            for (Integer time : utwRecords.get(name).keySet()) {
                uwRecords.get(name).add(utwRecords.get(name).get(time));
            }
        }

        
        HashMap<String, Integer> cntWP = new HashMap<>();
        
        int maxCnt = 0;
        
        String res = new String();
        for (String name : uwRecords.keySet()) {
            
            int len = uwRecords.get(name).size();
            
            HashSet<String> single = new HashSet<>();
            for (int i = 0; i < len-2; i++) {
                for (int j = i+1; j < len-1; j++) {
                    for (int k = j+1; k < len; k++) {
                       
                        String cur = (new StringBuilder()).append(uwRecords.get(name).get(i))
                        .append("->")
                        .append(uwRecords.get(name).get(j))
                        .append("->")
                        .append(uwRecords.get(name).get(k)).toString();
                        single.add(cur);
                    }
                }
            }

            for (String str : single) {
                if (!cntWP.containsKey(str)) {
                    cntWP.put(str, 0);
                }
                cntWP.put(str, cntWP.get(str)+1);

                int curCnt = cntWP.get(str);
                
                if (curCnt > maxCnt | (curCnt == maxCnt && str.compareTo(res) < 0)) {
                    maxCnt = curCnt;
                    res = str;
                }
            }
        }

        
        ArrayList<String> ans = new ArrayList<>();
        for (String str : res.split("->")) {
            ans.add(str);
        }

        return ans;
    }
}
```
