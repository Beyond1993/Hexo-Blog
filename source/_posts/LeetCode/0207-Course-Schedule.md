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

```python
class Solution:
    def canFinish(self, numCourses: int, prerequisites: List[List[int]]) -> bool:
        if len(prerequisites) <= 1: return True
        graph = defaultdict(list)
        indegree = {}
        for v in prerequisites:
            graph[v[0]].append(v[1])
            indegree[v[1]] = indegree.get(v[1], 0) + 1
        
        q = deque()

        for k in range(numCourses):
            if k not in indegree or indegree[k] == 0:
                q.append(k)
        count = 0
        while q:
            cur = q.popleft()
            count += 1
            for neighbor in graph[cur]:
                indegree[neighbor] -= 1
                if indegree[neighbor] == 0:
                    q.append(neighbor)
        
        return count == numCourses
```



```python
class Solution:
    def canFinish(self, numCourses: int, prerequisites: List[List[int]]) -> bool:
        # 构建图和入度表
        graph = defaultdict(list)
        indegree = {i: 0 for i in range(numCourses)}  # 初始化所有课程入度为 0
        
        for course, prereq in prerequisites:
            graph[prereq].append(course)  # 构建邻接表
            indegree[course] += 1         # 增加入度
        
        # 将所有入度为 0 的节点加入队列
        q = deque([node for node in indegree if indegree[node] == 0])
        count = 0

        # 拓扑排序 BFS
        while q:
            cur = q.popleft()
            count += 1  # 每遍历一个节点，表示完成一门课程
            for neighbor in graph[cur]:
                indegree[neighbor] -= 1  # 减少邻居节点的入度
                if indegree[neighbor] == 0:  # 入度为 0，加入队列
                    q.append(neighbor)
        
        # 如果完成的课程数量等于总课程数量，则返回 True
        return count == numCourses
```

