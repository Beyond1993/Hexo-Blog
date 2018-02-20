---
title: Interview Amazon 社招 OA
date: 2018-02-17 23:15:51
categories: Interview
tags:
---

在window size 为 K 的window, 找k个不同character


```java
public static List<String> kDist(String s, int k) {
    // corner case
    // TODO
    
    int[] map = new int[256];
    int count = 0;
    Set<String> res = new HashSet<>();
    
    // init k
    for (int i = 0; i < k; ++ i) {
      if (map[s.charAt(i)] ++ == 0) {
        ++ count;
      }
    }
    if (count == k) {
      res.add(s.substring(0, k));
    } 
    
    for (int i = k; i < s.length(); ++ i) {
      if (map[s.charAt(i)] ++ == 0) {
        ++ count;
      }
      if (map[s.charAt(i - k)]-- == 1) {
        -- count;
      }
      if (count == k) {
        res.add(s.substring(i - k + 1, i + 1));
      }
    }
    return new ArrayList<String>(res);
  }
```


The maze 
```java
import java.util.*;

class MyCode {
//   public static void main (String[] args) {
//     System.out.println("Hello Java");
//   }
  public static void main(String[] args) {
//     int[][] maze = new int[4][5];
    int[][] maze = {
      {0,0,0,1,0},
      {0,1,0,1,0},
      {0,1,0,1,0},
      {0,0,0,0,0}
    };
    int[] start = {0,0};
    int[] desti = {3,1};
    int res = shortestPathII(maze, start, desti);
    System.out.println(res);
 
  }
  public static int shortestPathII(int[][] matrix, int[] start, int[] end) {
    // concer case
    if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
      return -1;
    }
//     
    int m = matrix.length;
    int n = matrix[0].length;
    boolean[][] visited = new boolean[m][n];

    // bfs
    Deque<int[]> q = new ArrayDeque<>();
    q.offerLast(start);
    int step = 0;

    int[] dx = {0,0,-1,1};
    int[] dy = {-1,1,0,0};
    
    while(!q.isEmpty()) {
      int size = q.size();
      for (int i = 0; i < size; ++ i) {
        int[] cur = q.pollFirst();

        int x = cur[0];
        int y = cur[1];
        System.out.println("step:" + step + "("+ x +"," + y + ")");
        
        
        if (x == end[0] && y == end[1])
          return step;
        visited[x][y] = true;
        for (int k = 0; k < 4; ++ k) {
          int nx = x + dx[k];
          int ny = y + dy[k];
          if (isValid(m, n, nx, ny) && matrix[nx][ny] == 0 && !visited[nx][ny]) {
            q.offerLast(new int[]{nx, ny});
          }
        }  
      }
      
      ++ step;
    }  

     return -1;

  }
  
  public static boolean isValid(int m, int n, int x, int y) {
    return x >= 0 && x < m && y >= 0 && y < n;
  }
}
```


```java
// package whatever; // don't place package name!

import java.io.*;
import java.util.*;

class MyCode {
  public static void main (String[] args) {
    System.out.println("Hello Java");
//     String s = "abacbadeec";
//     int k = 4;
//     List<String> res = kDist(s, k);
//     for (String e : res) {
//       System.out.println(e);
//     }
    
    String[] t = {"2abc","bcd","cab"};
    String[] a = {"dbc", "aef", "2abc", "cab", "xyz","bcd", "bcd"};
    List<String> T = new ArrayList<>();
    for (String e : t) {
      T.add(e);
    }
    
    List<String> A = new ArrayList<>();
    for (String e : a) {
      A.add(e);
    }
    

    List<Integer> res = subSequenceTags(T, A);
    System.out.println(res.toString());
  }
  
  public static List<String> kDist(String s, int k) {
    // corner case
    // TODO
    
    int[] map = new int[256];
    int count = 0;
    Set<String> res = new HashSet<>();
    
    // init k
    for (int i = 0; i < k; ++ i) {
      if (map[s.charAt(i)] ++ == 0) {
        ++ count;
      }
    }
    if (count == k) {
      res.add(s.substring(0, k));
    } 
    
    for (int i = k; i < s.length(); ++ i) {
      if (map[s.charAt(i)] ++ == 0) {
        ++ count;
      }
      if (map[s.charAt(i - k)]-- == 1) {
        -- count;
      }
      if (count == k) {
        res.add(s.substring(i - k + 1, i + 1));
      }
    }
    return new ArrayList<String>(res);
  }
  
  public  static List<Integer> subSequenceTags(List<String> T,
                                               List<String> A) {
    Map<String, Integer> map = new HashMap<>();
    // init targetList
    for (String e : T) {
      int val = map.getOrDefault(e, 0);
      map.put(e, val + 1);
    }
    int count = map.size();
    int minLen = Integer.MAX_VALUE;
    int L = 0;
//     System.out.println(count);
    
    int left, right = 0;
    for(left = 0; left < A.size(); ++ left) {
        while(right < A.size() && count > 0) {
          String rightVal = A.get(right);
          if (map.containsKey(rightVal)) {
            int rightCount = map.getOrDefault(rightVal, 0);
            if (rightCount == 1) {
              count --;
            }
            map.put(rightVal, rightCount - 1);  
            
          }
          right ++;
        }
        if (count == 0 && right - left < minLen) {
          minLen = right - left;
          L = left;
//           System.out.println();
          
        }
                
        String leftVal = A.get(left);
        if (map.containsKey(leftVal)) {
          int leftCount = map.get(leftVal);
          if (leftCount == 0)
            count ++;
          map.put(leftVal, leftCount + 1);
          
        }
    }
    
    List<Integer> res = new ArrayList<>();
    if (minLen != 0x7fffffff) {
      res.add(L);
      res.add(L + minLen - 1); 
    }
    return res;
  }
}
```
