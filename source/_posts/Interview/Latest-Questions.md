---
title: Latest Questions
date: 2019-04-25 02:15:52
categories: Interview
tags:
---

```java
class MyCode {
    public static void main (String[] args) {
        System.out.println("Hello Java");
        MyCode mycode = new MyCode();
        boolean zero = false;
        boolean one = true;
        mycode.canDividBy3(zero);  // 0
        mycode.canDividBy3(one);    // 1
        mycode.canDividBy3(one);    // 11
        mycode.canDividBy3(zero);   // 110
        mycode.canDividBy3(zero);   // 110
        mycode.canDividBy3(zero);   // 11
        mycode.canDividBy3(one);
        mycode.canDividBy3(zero);


    }

    int prev = 0;
    public void canDividBy3(boolean input){
        // f1 = 1, f2 =2
        if(!input){
            if(prev==0){
                prev = 0;
                System.out.println( true);
            }else if(prev==1){
                prev = 1;
                System.out.println( false);
            }else if(prev==2){
                prev = 2;
                System.out.println( false);
            }
        }else{
            if(prev==0){
                // System.out.println(prev);
                prev = 2;
                System.out.println( false);
            }else if(prev==1){
                System.out.println(prev);
                prev = 2;
                System.out.println( true);
            }else if(prev==2){
                prev = 0;
                System.out.println( true);
            }
        }
        // return false;
    }
}
```
