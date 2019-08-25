---
title: Mininum Copies
date: 2019-08-25 15:29:26
categories: LeetCode
tags:
---

给２个ｓｔｒｉｎｇ A B， 求最少操作数能让A变成B的ｓｕｆｆｉｘ。操作指从B里拿一个ｓｕｂｓｔｒｉｎｇ的ｃｏｐｙ放到后面，保证可以完成。 比如 A： “ａｂｃｄ” B： “ｄｂｃｆｄａ” 答案就是２， B最后变成“ｄｂｃｆｄａｂｃｄ”。 解释： “ａ”可以重用。 ｃｏｐｙ字串“ｂｃ”， 然后ｃｏｐｙ字串“ｄ”。 完成。 ｃｏｐｙ ２ 次。


```java
class MyCode {
    static Map<String, Integer> map = new HashMap<String, Integer>();
  
  public static void main (String[] args) {
        //String A = "abcd";
    //String B = "dbcfda";
    String A = "abdc";
    String B = "dbcfda";
    
    int n = A.length();
    for (int i = n; i > 0; i--) {
      String sufix = B.substring(B.length() - i);
     
      if (A.startsWith(sufix)) {
        A = A.substring(i);
        B = B.substring(0, B.length() - i);
        
        break;
      }
    }
    
    System.out.println(search(A, B));
    
    }
  
  private static int search(String A, String B) {
    if (map.containsKey(A)) {
      return map.get(A);
    }
    if (B.contains(A) || A.length() == 1) {
      map.put(A, 1);
      return 1;
    }
    
    int res = Integer.MAX_VALUE;
    for (int i = 1; i < A.length(); i++) {
      res = Math.min(res, search(A.substring(0,i), B) + search(A.substring(i), B));
    }
    map.put(A, res);
    
    return res;
  }
}
```
