---
title: Java-Static
date: 2018-02-24 20:26:38
categories: Java
tags:
---


```java
import java.io.*;

class MyCode {
  public static void main (String[] args) {
    System.out.println("Hello Java");
    f();
  }
  public static void f() {
    Point1 p1 = new Point1(3,4);
    Point1 p2 = new Point1();
    p2.p();
    System.out.println(p1.x);
    System.out.println(p2.x);
    System.out.println(Point2.x);
  }
  
  
  
  static class Point1 {
    public static int x, y;
    
    Point1() {
    
    }
    
    Point1(int x, int y) {
      this.x = x;
      this.y = y;
    }
    
    public void p() {
      System.out.println("I am the number one");
    }
    
  }
  
  static class Point2{
    public static int x = 1, y;
  }
  
  
}
```


