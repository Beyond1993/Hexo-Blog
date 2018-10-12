---
title: Interview-Facebook
date: 2017-10-31 07:11:07
categories: Interview
tags:
---


刚面完fb的phone interviewlc 301 remove invalid parentheses 的变形，remove最少的parentheses使它valid，只返回一个解即可。 比如：“(a))” -> “(a)” “((()” -> “()” 开始用的BFS，follow up是要linear time, 用了两个for loop解，再follow up是只用一个for loop。最后一个follow up没想出来，求地里有大神给个solution

链接: https://instant.1point3acres.com/thread/291115
来源: 一亩三分地

动态规划优化到O(n)

一维动态规划，对于每一个 括弧，算出一个[x,y]， x表示需要删除的左括弧的数量，y 表示需要删除的右括弧的数量. 

如果当前是 ( , Xi = X(i-1), Yi = Y(i-1) == 0 ? 0 : Y(i-1) -1 

穷举所有可能的 password

word search II 时间复杂度分析


https://github.com/tongzhang1994/Facebook-Interview-Coding

```java
import java.util.*;

public class GFG {
  public static void main (String[] args) {
    String s = removeInvalidParentheses(")))(((())(((");
    System.out.println(s);
  }

  public static String removeInvalidParentheses(String s) {
    String r = remove(s, new char[]{'(', ')'});
    String tmp = remove(new StringBuilder(r).reverse().toString(), new char[]{')', '('});
    return new StringBuilder(tmp).reverse().toString();
    }

    public static String remove(String s, char[] p) {
      StringBuilder sb = new StringBuilder();
    int stack = 0;
    for (int i = 0; i < s.length(); i++) {

    if (s.charAt(i) == p[0]) {
        stack++;
    }

    if (s.charAt(i) == p[1]) {
        stack--;
    }

    if (stack < 0) {
      stack = 0;
      continue;
    }
    sb.append(s.charAt(i));
  }
  return sb.toString();
    }

}
```

