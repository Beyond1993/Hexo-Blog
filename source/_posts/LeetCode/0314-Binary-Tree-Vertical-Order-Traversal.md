---
title: 0314-Binary-Tree-Vertical-Order-Traversal
date: 2018-01-30 03:24:09
categories: LeetCode
tags:
---

垂直便利二叉树。

题目描述:

Given a binary tree, return the vertical order traversal of its nodes' values. (ie, from top to bottom, column by column).

If two nodes are in the same row and column, the order should be from left to right.

Examples:

Given binary tree [3,9,20,null,null,15,7],
```text
   3
  /\
 /  \
 9  20
    /\
   /  \
  15   7
```
return its vertical order traversal as:
```text
[
  [9],
  [3,15],
  [20],
  [7]
]
```
Given binary tree [3,9,8,4,0,1,7],
```text
     3
    /\
   /  \
   9   8
  /\  /\
 /  \/  \
 4  01   7
```
return its vertical order traversal as:
```text
[
  [4],
  [9],
  [3,0,1],
  [8],
  [7]
]
```
Given binary tree [3,9,8,4,0,1,7,null,null,null,2,5]  (0's right child is 2 and 1's left child is 5),
```text  
     3
    /\
   /  \
   9   8
  /\  /\
 /  \/  \
 4  01   7
    /\
   /  \
   5   2
```
return its vertical order traversal as:
```text
[
  [4],
  [9,5],
  [3,0,1],
  [8,2],
  [7]
]
```

思路： 以根节点为index 0, 左边 -1, 右边 1, 本质还是层次遍历取对应下标.再将 index 作为map的key,node 作为value

其实这题有点像[ZigZag](http://www.wayne.ink/2017/12/30/LeetCode/0006-ZigZag-Conversion/)

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
public class Solution {
    public List<List<Integer>> verticalOrder(TreeNode root) {
        List<List<Integer>> res = new ArrayList<List<Integer>>();
        if (root == null) {
            return res;
        }
        
        Map<Integer, ArrayList<Integer>> map = new HashMap<Integer, ArrayList<Integer>>();
        Queue<TreeNode> q = new LinkedList<TreeNode>();
        Queue<Integer>  cols = new LinkedList<Integer>();
        
        q.add(root);
        cols.add(0);
        int min = 0;
        int max = 0;
        while(!q.isEmpty()) {
            TreeNode node = q.poll();
            Integer col = cols.poll();
            
            if (!map.containsKey(col)) {
                map.put(col,new ArrayList<Integer>());
            }
            
            map.get(col).add(node.val);
            
            if (node.left != null) {
                q.add(node.left);
                cols.add(col - 1);
                min = Math.min(min,col -1);
            }
            
            if (node.right != null) {
                q.add(node.right);
                cols.add(col + 1);
                max = Math.max(max, col + 1);
            }
        }
        
        for (int i = min; i <= max; i++) {          
            res.add(map.get(i));
        }
        
        return res;
    }
}
```

DFS 使用 priorityqueue size 作为second key,make sure FIFO
```java
class Solution {
    Map<Integer, PriorityQueue<int[]>> map = new TreeMap<>();
    public List<List<Integer>> verticalOrder(TreeNode root) { 
        dfs(root, 0, 0);
        List<List<Integer>> res = new ArrayList<>();
        for(Map.Entry<Integer, PriorityQueue<int[]>> entry : map.entrySet()) {
          Integer key = entry.getKey();
          PriorityQueue<int[]> values = entry.getValue();
          List<Integer> l = new ArrayList<>();
          while(!values.isEmpty()) {
              l.add(values.poll()[0]);
          }
          res.add(l);
        }
        return res;
    }
    
    private void dfs(TreeNode root, int index, int level) {
        if (root == null) {
            return;
        }
        if (map.containsKey(index)) {
            map.get(index).offer(new int[]{root.val, level, map.get(index).size()});
        } else {
            PriorityQueue<int[]> list = new PriorityQueue<>((a, b) -> {
                if (a[1] == b[1]) {
                    return a[2] - b[2];
                }
                return a[1] - b[1];
            });
            list.offer(new int[]{root.val, level, 1});
            map.put(index, list);
        } 
        dfs(root.left, index - 1,  level + 1);
        dfs(root.right, index + 1, level + 1);   
    }
}
```

这个写法比较简单，先通过dfs 找到最左最右两边的值，root 以0 开始，min 肯定是负数，max 是正数，然后bfs 的时候刚好 -min 就对应了root 在最后数组里的index

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {

    private int min = 0;
    private int max = 0;

    public List<List<Integer>> verticalOrder(TreeNode root) {
        List<List<Integer>> res = new ArrayList<>();
        if (root == null) {
            return res;
        }

        helper(root, 0);
        for (int i = min; i <= max; i++) {
            res.add(new ArrayList<>());
        }

        Queue<TreeNode> queue = new LinkedList<>();
        Queue<Integer> index = new LinkedList<>();
        index.offer(-min);
        queue.offer(root);

        while(!queue.isEmpty()) {
            TreeNode cur = queue.poll();
            int idx = index.poll();
            res.get(idx).add(cur.val);

            if (cur.left != null ) {
                queue.offer(cur.left);
                index.offer(idx - 1);
            }

            if (cur.right != null ) {
                queue.offer(cur.right);
                index.offer(idx + 1);
            }
        }

        return res;
    }

    private void helper(TreeNode root, int index) {
        if (root == null) return;
        min = Math.min(index, min);
        max = Math.max(index, max);
        helper(root.left, index - 1);
        helper(root.right, index + 1);
    }
}

```


python queue pop() 是取最后一个，pop(0) 才是第一个

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def verticalOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        if root is None:
            return []
        res = []
        indexMap = {}
        queue = []
        indice = []
        queue.append(root)
        indice.append(0)
        minId, maxId = 0, 0
        while queue:
            cur = queue.pop(0)
            index = indice.pop(0)

            # print(cur.val, index)

            if index not in indexMap:
                indexMap[index] = [cur.val]
            else:
                indexMap[index].append(cur.val)
            
            if cur.left is not None:
                queue.append(cur.left)
                indice.append(index - 1)
                minId = min(minId, index - 1)

            if cur.right is not None:
                queue.append(cur.right)
                indice.append(index + 1)
                maxId = max(maxId, index + 1)
            
        for i in range(minId, maxId + 1):
            res.append(indexMap[i])

        return res
```


```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def verticalOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        if not root : return []
        index_map = {}

        q = collections.deque()
        cur_index = 0
        min_left, max_right = 0, 0
        q.append((root, 0))

        while q:
            size = len(q)
            for i in range(size):
                cur_node, cur_index = q.popleft()
                min_left = min(min_left, cur_index)
                max_right = max(max_right, cur_index)
                
                if cur_index not in index_map:
                    index_map[cur_index] = [cur_node.val]
                else:
                    index_map[cur_index].append(cur_node.val)
                
                if cur_node.left:
                    q.append((cur_node.left, cur_index - 1))

                if cur_node.right:
                    q.append((cur_node.right, cur_index + 1))

        res = []
        for i in range(min_left, max_right + 1):
            res.append(index_map[i])

        return res
```
