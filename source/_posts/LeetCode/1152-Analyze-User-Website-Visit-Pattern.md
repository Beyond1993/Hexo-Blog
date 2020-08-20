---
title: 1152 Analyze User Website Visit Pattern
date: 2020-06-14 20:56:17
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
    public List<String> mostVisitedPattern(String[] username, int[] timestamp, String[] website) {
        int n = username.length;

        //step 1: sort by time stamp
        String[][] sessions = new String[n][3];
        for (int i = 0; i < n; i++) {
            sessions[i][0] = username[i];
            sessions[i][1] = String.valueOf(timestamp[i]);
            sessions[i][2] = website[i];
        }
        Arrays.sort(sessions, (a, b) -> Integer.parseInt(a[1]) - Integer.parseInt(b[1]));

        // step 2: build Map<user, web sequence>
        Map<String, List<String>> visited = new HashMap<>();
        for (int i = 0; i < n; i++) {
            String user = sessions[i][0];
            String web = sessions[i][2];
            if (!visited.containsKey(user)) {
                visited.put(user, new ArrayList<>());
            }
            visited.get(user).add(web);
        }

        // step 3: build Map<3-seq, count>
        Map<String, Integer> seqMap = new HashMap<>();
        int maxCount = 0;
        String maxSeq = "";

        for (List<String> list : visited.values()) {
            if (list.size() < 3) continue;
            Set<String> subsequences = getAll3SubSequences(list);
            for (String subseq : subsequences) {
                seqMap.put(subseq, seqMap.getOrDefault(subseq, 0) + 1);
                if (seqMap.get(subseq) > maxCount) {
                    maxCount = seqMap.get(subseq);
                    maxSeq = subseq;
                } else if (seqMap.get(subseq) == maxCount && maxSeq.compareTo(subseq) > 0) {
                    maxSeq = subseq;
                }
            }
        }

        // step 4: build result list
        List<String> res = new ArrayList<>();
        String[] arr = maxSeq.split(",");
        for (String s : arr) res.add(s);

        return res;
    }

    public Set<String> getAll3SubSequences(List<String> list) {
        int n = list.size();
        String[] arr = new String[n];
        int idx = 0;
        for (String s : list) arr[idx++] = s;

        Set<String> set = new HashSet<>();
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                for (int k = j + 1; k < n; k++) {
                    String s = arr[i] + "," + arr[j] + "," + arr[k];
                    set.add(s);
                }
            }
        }
        return set;
    }
}
```
