---
title: LeetCode-138-Copy-List-with-Random-Pointer
date: 2017-09-16 21:41:53
categories: LeetCode
tags:
---

描述：A linked list is given such that each node contains an additional random pointer which could point to any node in the list or null.

Return a deep copy of the list.

思路： 这是亚马逊OA2的题，用一个Hashmap记录当前和和rondom里出现过的点，一旦有，就从这个Hashmap里拿，否则重新生成一个

任何一个问题，都是从最简单的模型，转变过来的。先考虑怎么copy一个 简单的单链表。

cur 指向 原链表
prev 指向新链表的当前节点，因为通过 cur new 出来的节点要插在这个节点的后面，所以起名prev

其实分别是两条链表 

这一题的主要思路就是加一个map.
```text
        --------------+      +------+
        |             |      |      |
        |             V      |      V
1 --->  2 ---> 3 ---> 4 ---> 5 ---> 6 
               ^      |
               |      |
               +------+
```
 
```java 
/**
 * Definition for singly-linked list with a random pointer.
 * class RandomListNode {
 *     int label;
 *     RandomListNode next, random;
 *     RandomListNode(int x) { this.label = x; }
 * };
 */
public class Solution {
    public RandomListNode copyRandomList(RandomListNode head) {
        if (head == null) {
            return null;
        }

        HashMap<RandomListNode, RandomListNode> map = new HashMap<RandomListNode, RandomListNode>();
        RandomListNode dummy = new RandomListNode(0);
        RandomListNode pre = dummy;
        RandomList  newNode;
        RandomListNode cur = head;
        while ( cur != null) {

            //get cur node
            if (map.containsKey(cur)) {
                newNode = map.get(cur);
            } else {
                newNode = new RandomListNode(cur.label);
                map.put(cur, newNode);
            }
            
            // assign random point 
            if (cur.random != null) {
                if (map.containsKey(cur.random)) {
                    newNode.random = map.get(cur.random);
                } else {
                    newNode.random = new RandomListNode(cur.random.label);
                    map.put(cur.random, newNode.random);
                }
            }

            // add to new list
            pre.next = newNode;
            pre = newNode;
            cur = cur.next;
        }

        return dummy.next;
    }
}
```
