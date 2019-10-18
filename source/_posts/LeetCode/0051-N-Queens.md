---
title: 0051 N-Queens
date: 2019-10-18 00:38:50
categories: LeetCode
tags:
---



```java
public class Solution {
    List<List<String>> ans = new LinkedList<List<String>>();
    private void search(List<Integer> cols, int n) {
        if (cols.size() == n) {
            //List<String> tmp = draw(cols);
            ans.add(draw(cols));
            return;
        }
        
        for (int colIndex = 0; colIndex < n; colIndex++) {
            if (!isValid(cols, colIndex)) continue;
            cols.add(colIndex);
            search(cols, n);
            cols.remove(cols.size() - 1);
        }
    }
    
    private boolean isValid(List<Integer> cols, int col) {
        int row = cols.size();
        for (int i = 0; i < row; i++) {
            if (cols.get(i) == col) return false;
            if (i + cols.get(i) == row + col) return false;
            if (i - cols.get(i) == row - col) return false;
        }
        return true;
    }
    
    private List<String> draw(List<Integer> cols) {
        List<String> list = new LinkedList<String>();
        int n = cols.size();
       
        for (int i = 0; i < n; i++) {
            StringBuilder sb = new StringBuilder();
            for (int j = 0; j < n; j++) {
                if (j == cols.get(i)) {
                    sb.append("Q");
                } else {
                    sb.append(".");
                }
            }
            list.add(sb.toString());
        }
        
        return list;
    }
    
    public List<List<String>> solveNQueens(int n) {
        
        if (n <= 0) return ans;
        List<Integer> cols = new LinkedList<Integer>();
        search(cols, n);
        return ans;
    }
}
```
