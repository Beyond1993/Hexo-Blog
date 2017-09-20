---
title: Java-Regex
date: 2017-08-28 17:11:13
categories: Java
tags:
---

```java
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Regex {

  public static void main(String[] Args) {
    String str = "a,b,  c, d";
    Pattern pattern  = Pattern.compile(",\\s*");
    Matcher matcher = pattern.matcher(str);
    String result =  matcher.replaceAll(" ");
    System.out.println(result);
  }

}
```


## 将自己写过的正则记录下来，以备后用
^ $ 是针对每一行的，匹配一行的开头和结尾

1. "^$" 匹配一个空串, ""

2. 匹配某个单词，不需要用^$, 因为这是匹配一行的.

3. 去除逗号， 但是可能是 "a,b"  "a, b", "a,  b", 用 ",\\\s*"


