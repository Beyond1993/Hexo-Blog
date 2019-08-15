---
title: 0428 Serilize and Deserilize N-ary Tree
date: 2019-08-15 01:58:07
categories: LeetCode
tags:
---

```java

class Codec {

    // Encodes a tree to a single string.
    public String serialize(Node root) {
        StringBuilder sb = new StringBuilder();
        buildString(root, sb);
       // System.out.println(sb.toString());
        return sb.toString();
    }
    
    private void buildString(Node root, StringBuilder sb) {
        if (root == null) {
            sb.append("X").append(",");
        } else {
            sb.append(root.val).append(",");
            for (Node node : root.children) {
                buildString(node, sb);
            }
            buildString(null, sb);
        }
    }
    
    // Decodes your encoded data to tree.
    public Node deserialize(String data) {
        String[] list = data.split(",");
        int[] index = new int[1];
        return buildTree(list, index);
    }
    // 1,3,5,X,6,X,X,2,X,4,X,X
    private Node buildTree(String[] list, int[] index) {
        String val = list[index[0]++];
        //System.out.println(val);
        if (val.equals("X")) {
           return null;  
        } else {
            Node node = new Node(Integer.valueOf(val), new ArrayList<>());
            while(!list[index[0]].equals("X")) {
                node.children.add(buildTree(list, index));
                // index[0]++;
            }
            index[0]++;
            return node;
        }
    }
}
```
