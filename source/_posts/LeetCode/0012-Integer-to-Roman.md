---
title: 0012 Integer to Roman
date: 2017-12-28 05:28:52
categories: LeetCode
tags:
---

Given an integer, convert it to a roman numeral.

Input is guaranteed to be within the range from 1 to 3999.

个人感觉这道题主要是要知道罗马数字是怎么表示的，没什么实际编程技巧。

惟一需要注意的就是, 左减时不可跨越一个位值。比如，99不可以用IC（ {\displaystyle 100-1} 100-1）表示，而是用XCIX（ {\displaystyle [100-10]+[10-1]} [100-10]+[10-1]）表示。（等同于阿拉伯数字每位数字分别表示。

9 --> IX
98 --> XCVIII
99 --> XCIX

```java
public class Solution {
    public String intToRoman(int num) {
        String M[] = {"", "M", "MM", "MMM"};
        String C[] = {"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"};
        String X[] = {"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"};
        String I[] = {"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"};
        return M[num/1000] + C[(num%1000)/100] + X[(num%100)/10] + I[num%10];
    }
}
```

这种类型的还有[273 Integer to English Words](http://www.wayne.ink/2017/12/21/LeetCode/0273-Integer-to-English-Words/)

这种题型，我个人将其归类为线性映射问题。

从一个Integer, Bit array ==> 映射到 一个word or string, or object
在机器学习的经典算法word2vec中，我们是将一个单词 映射到 一个向量，从离散数学集合论的角度出发，就是一个空间到另一个空间的映射。

不管是 Integer to Roman，Roman to Integer，Integer to English Words, English Words to Integer, 这种映射关系，无处不在，我们要做的就是将这种映射关系用代码描述出来。

对种题型，最重要的是要构造好一个解空间。比如这题里的M, C, X, I, 这里的技巧就是将index 0 的位置设置为 ""。

这样子我按照 num/1000 也好， num / 100 也好，最终的效果，就是不够1000， 只返回一个空置.

这种dummy node 的技巧在DP, 链表中非常常见，这是第一次应用在映射问题上。
