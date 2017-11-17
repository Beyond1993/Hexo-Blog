---
title: Java-Regex
date: 2017-08-28 17:11:13
categories: Java
tags:
---
https://regex101.com/

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

4. 去掉hive 里的 tab comma, space, regexp_replace(regexp_replace(b.unstemmed_keyword, '[,\\s*]', ' '), '\\s+', ' ')
* 零次或多次匹配前面的字符或子表达式。例如，zo* 匹配"z"和"zoo"。* 等效于 {0,}。+ 一次或多次匹配前面的字符或子表达式。例如，"zo+"与"zo"和"zoo"匹配，但与"z"不匹配。+ 等效于 {1,}。

5. 正则前瞻
\|(?=[-+]) 匹配 |+ 或者 |- 里的 |
