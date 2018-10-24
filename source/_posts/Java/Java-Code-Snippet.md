---
title: Java-Code-Snippet
date: 2018-10-24 00:14:50
categories: Java
tags:
---

### 用浏览器打开链接

```java
import java.awt.Desktop;
import java.net.URL;
public class OpenURL {

public static void main(String[] args) {

    Desktop desktop = Desktop.isDesktopSupported() ? Desktop.getDesktop() : null;
    if (desktop != null && desktop.isSupported(Desktop.Action.BROWSE)) {
    try {
    URL url = new URL("http://www.sina.com");
    desktop.browse(url.toURI());
    } catch (Exception e) {
        e.printStackTrace();
    }
    }
  }
}
```
