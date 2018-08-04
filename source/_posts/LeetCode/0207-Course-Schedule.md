---
title: 0207 Course Schedule
date: 2017-12-26 06:16:31
categories: LeetCode
tags:
---

```java
public class Solution {
    public boolean canFinish(int numCourses, int[][] prerequisites) {
        int prevNum[] = new int[numCourses];
        
        ArrayList<ArrayList<Integer>>  adj = new ArrayList<ArrayList<Integer>>();
        
        for (int i = 0; i < numCourses; i++) {
            adj.add(new ArrayList<Integer>());
        }
        
        // 0 is preequisties
        for (int i = 0; i < prerequisites.length; i++) {
            adj.get(prerequisites[i][1]).add(prerequisites[i][0]);
            prevNum[prerequisites[i][0]]++; 
        }
        
        Queue<Integer> queue = new  LinkedList<Integer>();
        
        for (int i = 0 ; i < numCourses; i++) {
            
            if (prevNum[i] == 0) {
                queue.add(i);
            }
            
        }
        int count = 0;
        while(!queue.isEmpty()) {
            int i = queue.poll();
            for (Integer j : adj.get(i)) {
                prevNum[j]--;
                if (prevNum[j] == 0){
                    queue.add(j);
                }    
            }
            count++;
        }
        return count == numCourses;
    }
}
```

能否拓扑排序，就是一个判断是否有环的问题。 
```java
public class Solution {
    public boolean canFinish(int numCourses, int[][] prerequisites) {
        ArrayList[] graph = new ArrayList[numCourses];
        for(int i=0;i<numCourses;i++)
            graph[i] = new ArrayList();

        boolean[] visited = new boolean[numCourses];
        for(int i=0; i<prerequisites.length;i++){
            graph[prerequisites[i][1]].add(prerequisites[i][0]);
        }

        for(int i=0; i<numCourses; i++){
            if(!dfs(graph,visited,i))
                return false;
        }
        return true;
    }

    private boolean dfs(ArrayList[] graph, boolean[] visited, int course) {
        if(visited[course]) 
            return false; //

        visited[course] = true;;

        for(int i=0; i<graph[course].size();i++){
            if(!dfs(graph,visited,(int)graph[course].get(i)))
                return false; //
        }
        visited[course] = false;
        return true;
    }
}
```
Python code:

```python
class Solution:
    def canFinish(self, numCourses, prerequisites):
        """
        :type numCourses: int
        :type prerequisites: List[List[int]]
        :rtype: bool
        """
        graph = [-1] * numCourses

        for i in range(numCourses):
            graph[i] = []

        visited = [False] * numCourses
        
        for i in range(len(prerequisites)):
            graph[prerequisites[i][0]].append(prerequisites[i][1])

        for i in range(numCourses):
            if self.dfs(graph,visited,i) is False:
                return False

        return True

    def dfs(self, graph, visited, course):
        if visited[course]: 
            return False

        visited[course] = True

        for value in graph[course]:
            if self.dfs(graph, visited, value) is False:
                return False
            
        visited[course] = False
        return True
```
