---
title: 0535 Encode and Decode TinyURL
date: 2018-02-21 21:02:22
categories: LeetCode
tags:
---

TinyURL is a URL shortening service where you enter a URL such as https://leetcode.com/problems/design-tinyurl and it returns a short URL such as http://tinyurl.com/4e9iAk.

Design the encode and decode methods for the TinyURL service. There is no restriction on how your encode/decode algorithm should work. You just need to ensure that a URL can be encoded to a tiny URL and the tiny URL can be decoded to the original URL.


```java
public class Codec {

  // Encodes a URL to a shortend URL.
  public String encode(String longUrl) {

  }

  //Decodes a shortened URL to its original URL
  public String decode(String shortUrl) {

  }
}
```


方法一: 简单计数
```java
public class Codec {
  Map<Integer, String> map = new HashMap<>();
  int i = 0;

  public String encode(String longUrl) {
    map.put(i, longUrl);
    return "http://tinyurl.com/" + i ++;
  }

    return map.get(Integer.parseInt(shortUrl.replace("http://tinyurl.com/", "")));
  }

}
```

这样URL 的范围就取决于int 范围。

一旦 URL 的数量超过了最大的范围，integer overflow 将要 overwrite previous URL.

这种情况下tinyURL 不一定比 longURL 长

这个问题就是很容易预测出下一个 URL.


方法二:

我们用可变长度去encode URL, 

```
public class Codec {

    String chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    HashMap<String, String> map = new HashMap<>();
    int count = 1;

    public String getString() {
        int c = count;
        StringBuilder sb = new StringBuilder();
        while (c > 0) {
            c--;
            sb.append(chars.charAt(c % 62));
            c /= 62;
        }
        return sb.toString();
    }

    public String encode(String longUrl) {
        String key = getString();
        map.put(key, longUrl);
        return "http://tinyurl.com/" + key;
        count++;
    }

    public String decode(String shortUrl) {
        return map.get(shortUrl.replace("http://tinyurl.com/", ""));
    }
}
```

这次我们用 0~9 a~z A~Z 62个字母 组成tinyURL.

最终生成的tinyURL 和 count 有关.

```
public String getString() {
  int c = count;
  StringBuilder sb = new StringBuilder();
  while( c > 0) {
    c--;
    sb.append(chars.charAt(c % 62));
    c /= 62;
  }

  return sb.toString();

}
```

确保了tinyURL 和  longURL 的一一对应关系.

最后用一个map 存 &lt;key, longUrl&gt;





