---
title: Interview-Questions
date: 2019-06-03 00:09:47
categories: Interview
tags:
---

class CompactTreeBuilder<T> {
 
/**
* Given a root of a tree. The tree may be of any depth and width,
* i.e. each node may have any number of child nodes.
* This method should transform a tree in such a way
* that each node (except probably one) would either have N or 0 children
* (and one node may have a number of children between 0 and N).
*
* Algorithm may transform given tree in any way with only condition:
* if node A was an ascendant of node B in a source tree
* node B may not be an ascendant of a node A in a result tree (they may become siblings though).
*
* E.g.
*
* source: compact(A, 2) compact(A, 1) compact(A, 100)
*
* A A A A
* | | |_B |_B
* |_B |_B |_C |
* | | | |_D |_C
* | | |_D |_E |
* | | | |_F |_D
* |_C | |_E |_G |
* | |_D | |_H |_H |_E
* | |_F | |
* | |_C |_F
* |_E | |
* |_G |_F |_G
* | | |
* |_H |_G |_H
*
*
* in an example for compact(A,2) above node E is an exception node:
* it has 1 child while any other node has either 2 or 0 children
*/
Node<T> compact(Node<T> root, int n) {
}
 
class Node<T> {
 
private final T data;
 
private final List<Node<T>> children;
 
 
public Node(T data, List<Node<T>> children) {
this.data = data;
this.children = children;
}
 
public T getData() {
return data;
}
 
public List<Node<T>> getChildren() {
return children;
}
}


```java

// "static void main" must be defined in a public class.
// the node can not be visited by twice


  /*       
         0
        /| \
       2 |  1   
     /   2   \
    1--1------2
    \    |   /
      5  |  2
       \ | /
         3   
             
*/
             
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello World!");
        int[] res = getPickAndDropPoints(4);
        System.out.println(res[0] + "\t"+ res[1]);
    }
    // a < b


    public static int getTime(int a, int b) {
        if (a > b) 
            return getTime(b, a);
        
        if (a == 0 && b == 1) {
           return 99;   
        }
        
        if (a == 0 && b == 2) {
            return 1;
        }
        
        if (a == 0 && b == 3) {
            return 3;   
        }
        
        if ( a == 1 && b == 2) {
            return 1;
        }
        
        if ( a == 1 && b == 3) {
             return 5;
        }
        
        if (a == 2 && b == 3) {
            return 2;
        }
        return -1;
    }
    public static int[] getPickAndDropPoints(int N) {
        int gobalMinTime = Integer.MAX_VALUE;
        int pickPoint = 0;
        int dropPoint = 1;
        Set<Integer> visited = new HashSet<>();
        for (int i = 0; i < N; ++ i) {
            for (int j = i; j < N; ++ j) {
                visited.add(i);
                int minTime = getShortestTravelTime(i, j, N, visited);
                visited.remove(i);
                if (gobalMinTime > minTime) {
                    gobalMinTime = minTime;
                    pickPoint = i;
                    dropPoint = j;
                }
            }
        }
        return new int[] {pickPoint, dropPoint};
    }
    
    private static int getShortestTravelTime(int start, int end, int N, Set<Integer> visited) {
        if (start == end && visited.size() == N) return 0;
        if (start == end) return Integer.MAX_VALUE;
        
        int min = Integer.MAX_VALUE;
        for (int i = 0; i < N; ++ i) {
            if (visited.add(i)) {
                 int tmp = getShortestTravelTime(i, end, N, visited);
                 if (tmp != Integer.MAX_VALUE)
                    min = Math.min(min, getTime(start, i) + tmp);
                 visited.remove(i);
            }
        }
        
        return min;
    }
}
```
