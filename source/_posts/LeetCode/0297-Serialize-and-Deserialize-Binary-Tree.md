---
title: 0297 Serialize and Deserialize Binary Tree
date: 2019-08-14 18:21:25
categories: LeetCode
tags:
---

这题要用前序遍历来序列化和反序列化。

因为前序遍历的性质决定了 一个节点的后面节点肯定是这个节点的子树。

### DFS
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
public class Codec {

    // Encodes a tree to a single string.
    public String serialize(TreeNode root) {
        StringBuilder sb = new StringBuilder();
        buildTree(root, sb);
        return sb.toString();
    }
    
    private void buildTree(TreeNode root, StringBuilder sb) {
        if (root == null) {
            sb.append('X').append(',');
            return;
        } else {
            sb.append(root.val).append(',');
        }
        
        buildTree(root.left, sb);
        buildTree(root.right, sb);
    }

    // Decodes your encoded data to tree.
    public TreeNode deserialize(String data) {
        int[] index = new int[1];
        String[] datas = data.split(",");
        return deserializeTree(datas, index);
    }
    
    private TreeNode deserializeTree(String[] datas, int[] index) {
        if (index[0] >= datas.length) return null;
        if (datas[index[0]].equals("X") ) {
            index[0]++;
            return null;
        }
        
        TreeNode node = new TreeNode(Integer.parseInt(datas[index[0]]));
        index[0]++;
        node.left = deserializeTree(datas, index);
        //index[0]++; 如果加上这个就是 bfs 了
        node.right = deserializeTree(datas, index);
        return node;
    }
    
}

// Your Codec object will be instantiated and called as such:
// Codec codec = new Codec();
// codec.deserialize(codec.serialize(root));
```


```python
# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Codec:

    def serialize(self, root):
        """Encodes a tree to a single string.
        
        :type root: TreeNode
        :rtype: str
        """
        def dfs(node):
            if not node :
                vals.append("#")
                return
            vals.append(str(node.val))
            dfs(node.left)
            dfs(node.right)
        
        vals = []
        dfs(root)
        return ",".join(vals)
        

    def deserialize(self, data):
        """Decodes your encoded data to tree.
        
        :type data: str
        :rtype: TreeNode
        """
        def buildTree():
            val = next(vals)
            if val == "#":
                return None
            node = TreeNode(int(val))
            node.left = buildTree()
            node.right = buildTree()
            return node
        vals = iter(data.split(","))
        return buildTree()

        

# Your Codec object will be instantiated and called as such:
# ser = Codec()
# deser = Codec()
# ans = deser.deserialize(ser.serialize(root))
```
