---
title: 1152 Analyze User Website Visit Pattern
date: 2021-03-27 14:49:05
categories: LeetCode
tags:
---

We are given some website visits: the user with name username[i] visited the website website[i] at time timestamp[i].

A 3-sequence is a list of websites of length 3 sorted in ascending order by the time of their visits.  (The websites in a 3-sequence are not necessarily distinct.)

Find the 3-sequence visited by the largest number of users. If there is more than one solution, return the lexicographically smallest such 3-sequence.

 

Example 1:

Input: username = ["joe","joe","joe","james","james","james","james","mary","mary","mary"], timestamp = [1,2,3,4,5,6,7,8,9,10], website = ["home","about","career","home","cart","maps","home","home","about","career"]
Output: ["home","about","career"]
Explanation: 
The tuples in this example are:
["joe", 1, "home"]
["joe", 2, "about"]
["joe", 3, "career"]
["james", 4, "home"]
["james", 5, "cart"]
["james", 6, "maps"]
["james", 7, "home"]
["mary", 8, "home"]
["mary", 9, "about"]
["mary", 10, "career"]
The 3-sequence ("home", "about", "career") was visited at least once by 2 users.
The 3-sequence ("home", "cart", "maps") was visited at least once by 1 user.
The 3-sequence ("home", "cart", "home") was visited at least once by 1 user.
The 3-sequence ("home", "maps", "home") was visited at least once by 1 user.
The 3-sequence ("cart", "maps", "home") was visited at least once by 1 user.



```java
class Solution {
    class Visit {
        String username;
        int timestamp;
        String website;
        public Visit(String username, int timestamp, String website) {
            this.username = username;
            this.timestamp = timestamp;
            this.website = website;
        }
        
        public String toString() {
            return username+" "+timestamp+" "+website;
        }
        
    }
    
    Set<List<String>> generate3(List<String> history) {
        Set<List<String>> output = new HashSet<>();
        for(int i = 0; i < history.size(); i++) {
            for(int j = i + 1; j < history.size(); j++) {
                for(int k = j + 1; k < history.size(); k++) {
                    List<String> l = new ArrayList<>();
                    l.add(history.get(i));
                    l.add(history.get(j));
                    l.add(history.get(k));
                    output.add(l);
                }
            }
        }
        return output;
    }
    
    public List<String> mostVisitedPattern(String[] username, int[] timestamp, String[] website) {
        Visit[] visits = new Visit[username.length];
        for(int i = 0; i < username.length; i++) {
            visits[i] = new Visit(username[i], timestamp[i], website[i]);
        }
        
        Arrays.sort(visits, (v1, v2) -> {
            return v1.timestamp - v2.timestamp;
        });
        HashMap<String, List<String>> userJourney = new HashMap<>();
        for(Visit v : visits) {
            userJourney.putIfAbsent(v.username, new ArrayList<>());
            userJourney.get(v.username).add(v.website);
        }
        HashMap<List<String>, Integer> candidateOutput = new HashMap<>();
        for(List<String> history : userJourney.values()) {
            Set<List<String>> history3Comb = generate3(history); // generate all combination with respecting the time order
            for(List<String> h : history3Comb) {
                candidateOutput.putIfAbsent(h, 0);
                candidateOutput.put(h, candidateOutput.get(h) + 1);
            }
        }
        
        List<List<String>> maxCandidate = new ArrayList<>();
        int max = 0;
        for(Map.Entry<List<String>, Integer> entry : candidateOutput.entrySet()) {
            if(max < entry.getValue()) {
                maxCandidate.clear();
                max = entry.getValue();
                maxCandidate.add(entry.getKey());
            } else if(max == entry.getValue()) {
                maxCandidate.add(entry.getKey());
            }
        }
        System.out.println(maxCandidate);
        List<String> output = null; 
        String o = null;
        
        for(List<String> c : maxCandidate) {
            StringBuilder sb = new StringBuilder();
            for(String s : c) sb.append(s+" "); // the space is to make comparison on X[0]-Y[0] then X[1]-Y[1], space as a separator because of its index value
            if(o == null || o.compareTo(sb.toString()) > 0) {
                o = sb.toString();
                output = c;
            }
        }
        
        return output;
    }
    
}
```
