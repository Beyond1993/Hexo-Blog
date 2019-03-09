---
title: CMU-08722-Data-Structures-Lecture-15-BST
date: 2017-12-12 05:13:23
categories: CMU
tags:
---

Major operations we want to have in our binary search tree are:
• Searching
• Insertion
• Deletion
• Traversal

Interface for BST
```java
//  Binary  Search  Tree  interface
public interface BSTInterface  {
        /**
          *  Searches  for  an  element  with  key in  the  tree.
          *  @param key  key  value  to  search
          *  @return boolean  value  indicating success  or  failure
          */
        boolean find(int key);
        /**
          *  Inserts a  new  element  into  the  tree.
          *  @param key  key of  the  element
          *  @param value value  of  the  element
          */
        void insert(int key,  double value);
        /**
          *  Deletes an  element from  the  tree.
          *  @param key  key of  the  element  to  be  deleted
          */
        void delete(int key);
        /**
          *  Traverses and  prints  key  and  value  pairs  in  the  tree.
          */
        void traverse();
}
```

BST class

BST 删除节点是最复杂的
• CASE 1: The node is not in the tree.
• CASE 2: The node is a leaf.
• CASE 3: The node has one child.
• CASE 4: The node has two children.

其中case2, case3 是需要 记录被删除的节点是否是左子树的，因为关系到 parent.left, parent.right

Case 3 就是相当于删除一个单链表

Case4 比较有意思。一个父亲节点给退休了，但是他有两个儿子，谁来顶替父亲的职位呢？
两种等价的方法，1.取右子树的最小值，2. 取左子树的最大值 作为successor, 

本文中用右子树的最小值，作为successor, 

sucessor 选好了，那么问题来了，这个successor的左右继承人又是谁？

因为是右子树的最小值，所以这个successor 一定是最左的孩子，那么这一小家族里自然没有比他更小的了，所以他的左孩子是NULL, 那么右孩子呢? 理论上说任何一个比这个successor 大的都可以当右孩子，那么在被删除节点的右子树上的所有其他节点都可以当作这个successor的右孩子，如果选最大的，或者倒数第二小的（最小的是successor), 显然我要找一个中间点，尽量保持这棵树的平衡.
```java
/**
 * 08722 Data Structures for Application Programmers.
 * Lecture 15 Binary Trees, mainly Binary Search Trees
 *
 * A very simple Binary Search Tree implementation
 * No duplicate keys allowed
 *
 * Note: This is only to help your understanding of the concepts
 *
 * @author Terry Lee
 */
public class BST implements BSTInterface {
    /**
     * reference to root node.
     */
    private Node root;

    /**
     * Constructs an empty BST.
     */
    public BST() {
        root = null;
    }

    /**
     * Searches for the specified key in the tree.
     * @param key key of the element to search
     * @return boolean value indication of success or failure
     */
    @Override
    public boolean find(int key) {
        // tree is empty
        if (root == null) {
            return false;
        }

        Node curr = root;
        // while not found
        while (curr.key != key) {
            if (curr.key < key) {
                // go right
                curr = curr.right;
            } else {
                // go left
                curr = curr.left;
            }

            // not found
            if (curr == null) {
                return false;
            }
        }
        return true; // found
    }

    /**
     * Inserts a new element into the tree.
     * @param key key of the element
     * @param value value of the element
     */
    @Override
    public void insert(int key, double value) {
        Node newNode = new Node(key, value);
        // empty tree
        if (root == null) {
            root = newNode;
            return;
        }

        Node parent = root; // keep track of parent
        Node curr = root;
        while (true) {
            // no duplicate keys allowed
            // simply keep the existing one here
            if (curr.key == key) {
                return;
            }

            parent = curr; // update parent
            if (curr.key < key) {
                // go right
                curr = curr.right;
                if (curr == null) {
                    // found a spot
                    parent.right = newNode;
                    return;
                }
            } else {
                // go left
                curr = curr.left;
                if (curr == null) {
                    // found a spot
                    parent.left = newNode;
                    return;
                }
            } // end of if-else to go right or left
        } // end of while
    } // end of insert method

    /**
     * Deletes an element from the tree using the specified key.
     * @param key key of the element to delete
     */
    @Override
    public void delete(int key) {
        // empty tree
        if (root == null) {
            return;
        }

        Node parent = root;
        Node curr = root;
        /*
         * flag to check left child
         * use this flag during actual deletion process
         * which happens after the while loop
         */
        boolean isLeftChild = true;

        while (curr.key != key) {
            parent = curr; // update parent first
            if (curr.key < key) { // go right
                isLeftChild = false;
                curr = curr.right;
            } else { // go left
                isLeftChild = true;
                curr = curr.left;
            }

            // case 1: not found
            if (curr == null) {
                return;
            }
        }

        if (curr.left == null && curr.right == null) {
            // case 2: leaf
            if (curr == root) {
                root = null;
            } else if (isLeftChild) {
                parent.left = null;
            } else {
                parent.right = null;
            }
        } else if (curr.right == null) {
            // case 3: one child (no right child)
            if (curr == root) {
                root = curr.left;
            } else if (isLeftChild) {
                parent.left = curr.left;
            } else {
                parent.right = curr.left;
            }
        } else if (curr.left == null) {
            // case 3: one child (no left child)
            if (curr == root) {
                root = curr.right;
            } else if (isLeftChild) {
                parent.left = curr.right;
            } else {
                parent.right = curr.right;
            }
        } else {
            // case 4: two children
            // here we use successor but using predecessor is also an option
            Node successor = getSuccessor(curr);

            if(curr == root) {
                root = successor;
            } else if(isLeftChild) {
                parent.left = successor;
            } else {
                parent.right = successor;
            }
            successor.left = curr.left;
        }
    }

    /**
     * Helper method to find the successor of the toDelete node.
     * This tries to find the smallest value of the right subtree
     * of the toDelete node by going down to the left most node in the subtree
     * @param toDelete node to delete
     * @return the successor of the toDelete node
     */
    private Node getSuccessor(Node toDelete) {
        Node successorParent = toDelete;
        Node successor = toDelete;
        // start the search from the root of the right subtree
        Node curr = toDelete.right;

        // move down to left as far as possible in the right subtree
        // successor's left child must be null
        while (curr != null) {
            successorParent = successor;
            successor = curr;
            curr = curr.left;
        }

        /*
         * If successor is NOT the right child of the node to delete, then
         * need to take care of two connections in the right subtree
         */
        if (successor != toDelete.right) {
            successorParent.left = successor.right;
            successor.right = toDelete.right;
        }

        return successor;
    }

    /**
     * Traverses and prints values of the tree in ascending order based on key.
     */
    @Override
    public void traverse() {
        inOrderHelper(root);
        System.out.println();
    }

    private void inOrderHelper(Node toVisit) {
        if (toVisit != null) {
            inOrderHelper(toVisit.left);
            System.out.print(toVisit);
            inOrderHelper(toVisit.right);
        }
    }

    /**
     * static nested Node class for Node.
     */
    private static class Node {
        /**
         * Key integer.
         */
        private int key;
        /**
         * double value mapped to the key.
         */
        private double value;
        /**
         * references to left and right children nodes.
         */
        private Node left, right;

        /**
         * Constructs a new node with key and value.
         * @param k integer key
         * @param v double value
         */
        Node(int k, double v) {
            key = k;
            value = v;
            left = null;
            right = null;
        }
        
        @Override
        public String toString() {
            StringBuilder sb = new StringBuilder();
            sb.append("[").append(key).append(",").append(value).append("]");
            return sb.toString();
        }
    }

    /**
     * A few simple test cases.
     * @param args arguments
     */
    public static void main(String[] args) {
        BST theBST = new BST();

        theBST.traverse();
        System.out.println("Searching for 45: " + theBST.find(45));
        theBST.delete(45);

        theBST.insert(50, 0.5);
        theBST.insert(69, 0.4);
        theBST.insert(45, 1.4);
        theBST.insert(72, 3.4);
        theBST.insert(46, 3.3);
        theBST.insert(46, 3.4);

        theBST.traverse();
        System.out.println("Searching for 45: " + theBST.find(45));
        System.out.println("Deleting element of the key 45");
        theBST.delete(45);
        System.out.println("Searching for 45: " + theBST.find(45));
        System.out.println("Deleting element of the key 40");
        theBST.delete(40);
        theBST.traverse();
    }

}
```
