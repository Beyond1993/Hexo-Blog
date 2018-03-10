---
title: Java-HashCode
date: 2018-02-28 20:00:31
categories: Java
tags:
---

HashCode: 

31 is primer
31 = 2^5 - 1 ==> i << 5 -1  

```java
public int hashCode() {
  int h = hash;
  if (h == 0) {
    int off = offset;
    char val[] = value;
    int len = count;
    for (int i = 0; i < len; i++) {
       h = 31*h + val[off++];
    }
    hash = h;
  }
 return h;
}
```

https://people.eecs.berkeley.edu/~jrs/61b/lec/22
