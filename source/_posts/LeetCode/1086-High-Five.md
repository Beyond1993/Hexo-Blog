---
title: 1086 High Five
date: 2021-09-27 02:42:10
categories: LeetCode
tags:
---

```java
ass Solution {
    public int[][] highFive(int[][] items) {
        Map<Integer, List<Integer>> studentIdToScores = new HashMap<>();
        for(int[] item : items) { 
            int studentId = item[0];
            int score = item[1];
            if(studentIdToScores.get(studentId) == null) {
                List<Integer> scoreList = new ArrayList<>();
                scoreList.add(score);
                studentIdToScores.put(studentId, scoreList);
            }
            else {
                studentIdToScores.get(studentId).add(score);
            }
        }
        int[][] ans = new int[studentIdToScores.keySet().size()][];
        int count = 0;
        for(int studentId : studentIdToScores.keySet()) {
            int average = 0;
            List<Integer> scoresList = studentIdToScores.get(studentId);
            Collections.sort(scoresList);
            for(int i = scoresList.size() - 1; i > scoresList.size() - 6; i--) {
                average += scoresList.get(i);
            }
            average /= 5;
            ans[count++] = new int[] {studentId, average};
        }
        return ans;
    }
}

```
