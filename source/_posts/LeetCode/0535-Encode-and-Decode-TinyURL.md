---
title: 0535 Encode and Decode TinyURL
date: 2018-02-21 21:02:22
categories: LeetCode
tags:
---

由于推特 限制了140个字符，一个长链接占据了大量的空间。短链接应运而生。

TinyURL is a URL shortening service where you enter a URL such as https://leetcode.com/problems/design-tinyurl and it returns a short URL such as http://tinyurl.com/4e9iAk.

Design the encode and decode methods for the TinyURL service. There is no restriction on how your encode/decode algorithm should work. You just need to ensure that a URL can be encoded to a tiny URL and the tiny URL can be decoded to the original URL.


Tiny URL
Tiny URL 是系统设计中的hello word.
Scenario:
插入短链接，
查找长链接
Necessary:
月活跃用户，日活跃用户.

Daily active users
*1,000,000

Insert
Per day: 1,000,000 1% (function usage) 10(function frequency) = 1000,000
Per Year: 100,000 365 = 36,500,000
Per second: 100,000/86400 = 1.2
Lookup:
Per day: 1,000,000 100 % (function usage) * 3 (function frequency) = 3,000,000
Per second: 3,000,000/86400 = 35

一般请求数超过100 ／ 一秒， 就需要考虑分布式架构
但是35只是一个平均值，可能白天到达七八十， 高峰期过一百，就需要分布式了.


basic solution

```cpp
class Shortner {
    map<string, string> mLongToShort;
    map<string, string> mShortToLong;

    string insert(string longURL)
    {
        if (mLongToShort.Find(longURL) == NULL)
        {
            string shortURL = GenerateShortURL();
            mLongToShort[ longURL ] = shortURL;
            mShortToLong[ shortURL ] = longURl;

        }

        return mLongToShort[longURL];

     }

}
```

理论上可以直接把长链接 hash, 但是这个 hash 算法怎么设计，是一个cost 很大的事情

string GenerateShortURL() 
{
    return string(mLongToShort.size());
}

怕被攻击

|    | Before         | After 
|:---|:--------------|:---------|    
|Yearly URL| 36,500,000 | 36,500,500 |
|Usable characters |[0-9] = 10 | [0-9a-zA-Z] = 62 |
|Encoding length |Log10(36,500,000) = 7.6 = 8 | Log62(36,500,500) = 4.2 = 5 |
|Example |goo.gl/36500000 | goo.gl/2t9jG |

就是把10 进制编码成62进制

算法有了。解决数据问题。


Average size of longURL = 100 bytes
Average size of shortURL = 4 bytes(int)
State = 4 byte 链接超时 过期
Daily new URL = 100,000 * 108 = 10.8 MB
Yearly new URL = 10.8 * 365 = 4 GB

How to support random ?
    Random(0, range)
How to avoid confilcting ?
    Try agian
How to implement time-limited service ?
    Expir/state
How to cache ?
    pre-load lazy load
    Replacement, LRU, 99% LRU 最优
多个机器。机器编号前两位.

一个master 写， 多个 salve 读。



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





