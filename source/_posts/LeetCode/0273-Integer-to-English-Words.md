---
title: 0273 Integer to English Words
date: 2017-12-21 19:16:05
categories: LeetCode
tags:
---

题目描述：

Convert a non-negative integer to its english words representation. Given input is guaranteed to be less than 2^31 - 1.

For example,
123 -> "One Hundred Twenty Three"
12345 -> "Twelve Thousand Three Hundred Forty Five"
1234567 -> "One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven"


2^31 = 2,147,483,648

两个billion

其实这道题的难点在于，英语的数字是怎么表示的。。

然后是倒着计算，因为倒着计算，只需要关注thousands这个层面。

其实这个问题拓展开来，就是自顶向下的方法，还是自底向上的方法。

[自顶向下vs自底向上](http://www.wayne.ink/2017/12/21/Algorithm/Top-to-Buttom-VS-Buttom-to-Top/)

按照我现在的编程思维来说，一般都是自顶向下的方法，因为这样更符合人的自然逻辑思维。比如这题，我第一反应就是先算出billion, 再算出 million, 最后 thousands。。往下。

对于这题来说，自顶向下的方法的困难就是，很难一开始就知道问题规模。

对于这题来说，你要是先算billion, million, thousands。 你就要先确定这个值是billion, milliion, thousands范围的。再做下一步操作。

但是如果只将问题缩小在 thousands的话，你就不用先判断再处理了.


```java
public class Solution {
    private final String[] LESS_THAN_20 = {"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"};
    private final String[] TENS = {"", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};
    private final String[] THOUSANDS = {"", "Thousand", "Million", "Billion"};
    
    public String numberToWords(int num) {
        if (num == 0) return "Zero";
    
        int i = 0;
        String words = "";
        
        while (num > 0) {
            // 先把１０００　以内的数算出来
            if (num % 1000 != 0) {
              words = helper(num % 1000) +THOUSANDS[i] + " " + words;
              System.out.println(words);
            }
          num /= 1000;
          i++;
        }
        
        return words.trim();
    }
    
    private String helper(int num) {
        if (num == 0)
            return "";
        else if (num < 20)
            return LESS_THAN_20[num] + " ";
        else if (num < 100)
            return TENS[num / 10] + " " + helper(num % 10);
        else
            return LESS_THAN_20[num / 100] + " Hundred " + helper(num % 100);
    }
}
```
