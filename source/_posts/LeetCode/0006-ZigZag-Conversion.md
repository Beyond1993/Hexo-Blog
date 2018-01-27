---
title: 0006 ZigZag Conversion
date: 2017-12-30 21:44:49
categories: LeetCode
tags:
---


The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)

P   A   H   N
A P L S I I G
Y   I   R
And then read line by line: "PAHNAPLSIIGYIR"
Write the code that will take a string and make this conversion given a number of rows:

string convert(string text, int nRows);
convert("PAYPALISHIRING", 3) should return "PAHNAPLSIIGYIR".


```java
public String convert(String s, int numRows) {
    if(s.length() == 1 || s.length() == 0 ) return s;
    String[] rows = new String[numRows];
    Arrays.fill(rows,"");
    int index = 0;
    int increment = 1;
    for (int i = 0; i < s.length(); i++) {
        rows[index] = rows[index] + s.charAt(i);
        index += increment;
        if (index == numRows - 1) {
            increment = -1;
        } 
        if (index == 0) {
            increment = 1;
        }

        //if (index == numRows) {
          //  index = index - 1;
        //} 
        index = index % numRows; //only for numRows = 1 and any string
    }
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < rows.length; i++) {
        sb.append(rows[i].toString());
    }
    return sb.toString();
}
```

这题的思路就是一个变量按照顺序遍历，另一个变量是来回波动，类似题目有
[0314 Binary Tree Vertical Order Traversal](http://www.wayne.ink/2018/01/30/LeetCode/0314-Binary-Tree-Vertical-Order-Traversal/)
