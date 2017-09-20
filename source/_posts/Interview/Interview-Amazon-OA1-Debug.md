---
title: Interview-Amazon-OA1-Debug
date: 2017-09-06 06:17:33
categories: 面试
tags:
---
Debug 题只有七题。
总体原则(引用小土刀博客）http://wdxtub.com/interview/14520850399861.html
```text
OA1 - Debugging

一些可能的问题：

while循环缺少i++造成死循环
Print Pattern：for-loop里一共两句话但是没有用大括号，所以第二句没有被包含进去
insert sort descending order: <> 反了
selection sort: arr[min]>arr[x] 改成 arr[y].
reverse array: arr[len-1] 改成 arr[len-i-1], 循环结束前去掉 len+=1;
循环里要加上 i++， 否则死循环
曼切斯特如果arr[i-1],arr相等为0，否则为1，要注意不但==要改成!=，ret[0]也要加一下，不然有一个case过不了。
解题技巧

因为地里面经分散,大家又说很简单,多办懒得附上题目,在这里提供几个思路给大家:

排序类:这种题Compile & Run出来的结果,多半是Sort的顺序反了,稍微看一下找到关键的if statement把他反过来就成。我7题里遇到2题这种的。
TLE类:这种结果TLE的多半是while死循环了,有while的检查一下。
for loop类:有for loop的,检查一下大括号有没有加。
其他类:其他特别的bug,多半地里找一下都有,记一下就成。
```

1. ArraySum: 计算一个整数数组的和          
bug: sum = arr[i], should be sum += arr[i]

2. CountOccurence: 统计某数在整数数组中出现的次数
 bug: while loop    i++

3. CheckGrade:根据百分制分数计算 GPA
bug:判断条件 “||” should be “&&”

4. RemoveElement: 删除数组中特定位置元素，超出范围则返回原数组         
bug:第七行arr[i++] should be arr[i+1]
```java
// You can print the values to stdout for debugging
public class ShortArray {
  public static int[] removeElement(int arr[], int index) {
    int i, j, len = arr.length;
    if (index < len) {
        for (i = index; i < len - 1; i++) {
            arr[i] = arr[i++]; ====改成===> arr[i] = arr[i+1]
        }
        int rarr[] = new int[len - 1];
        for (i = 0; i < len - 1; i++) {
            rarr[i] = arr[i];
        }
        return rarr;
    } else
        return array;
  } 
}
```

5. DigitCount: 将一个整数除以它的位数取余数  num%len(num) == 0 or != 0
bug:错在最后返回的除法时保留原数就行 把num用另一个变量存起来就好 因为num最后变成了0
```java
public class Digits {
  public int find(int num) {
    int count = 0;
    // 加一行
    int number = num; 
    //
    while(num != 0) {
        num = num/10;
        count++;
    }
    return num % count; =改成=> return number % count;
  }
}
```

6. Sort Array 冒泡排序：< 改 > 或者 > 改 <
```jave
public static int[] sortArray(int[] arr) {
    int len = arr.length;
    int small, pos, i, j, temp;
    for (i = 0; i <= len - 1; i++) {
        for (j = i; j < len; j++) {
        temp = 0;
        if (arr[i] > arr[j]) { // > 改 <
             temp = arr[i];
             arr[i] = arr[j];
             arr[j] = temp;
         }
      }
    }
    return arr; 
}
```
7. Sort Array 2 ：选择排序  < 改 > 或者 > 改 <
```java
public static int[] sortArray2(int arr[]) {
    int i, max, location, j, temp, len = arr.length;
    for (i = 0; i < len; i++) {
        max = arr[i];
        location = i;
        for (j = i; j < len; j++) {
            if (max > arr[j]) {  //  > 改 <
                max = arr[j];
                location = j;
            }
        }
        temp = arr[i];
        arr[i] = arr[location];
        arr[location] = temp;
    }
    return arr; 
}
```
8. Selection sort 这题告诉我们排序问题也可能是下标出了问题。
bug: if 里面的判断它写的是 arr[min]> arr[x], 改成 arr[min]> arr[y] 
```java
for (x = 0; x < n; x++) {
    int index_of_min = x;
    for (y = x; y < n; y++) {
        if (arr[index_of_min] > arr[x]) {
     y = index_of_min;
        }
        int temp = arr[x];
        arr[x] = arr[index_of_min];
        arr[index_of_min] = temp;
} }
// selection sort in ascending order 升序  
for (int x = 0; x < n; x++) {
    int index_of_min = x;
    for (int y = x; y < n; y++) {
        if (arr[index_of_min] > arr[y]) {
     index_of_min = y;
        }
    }
    int temp = arr[x];
    arr[x] = arr[index_of_min];
    arr[index_of_min] = temp;
}
```
13. bubble sort < 改 > 或者 > 改 < 
```java
// bubble sort in descending order 降序    
for (int x = 0; x < n; x++) {
    for (int y = x; y < n; y++) {
        if (arr[x] < arr[y]) { // < 改成 > 或者 > 改成 <
            int temp = arr[x];
            arr[x] = arr[y];
            arr[y] = temp;
        }
} }

// 死循环，不懂面经中这段代码是什么意思。将选择排序和冒泡排序混在一起。
for (x = 0; x < n; x++) {
    int index_of_min = x;
    for (y = x; y < n; y++) {
    if (arr[index_of_min] <= arr[x]) {
        y = index_of_min;
        int temp = arr[x];
        arr[x] = arr[index_of_min];
        arr[index_of_min] = temp;
      } 
    }
}
```

13. insertion sort < 改 > 或者 > 改 <
```java
for (int i = 1; i < n; i++) {
    if (arr[i - 1] > arr[i]) { 
        int temp = arr[i];
        int j = i;
        while (j > 0 && arr[j - 1] > temp) {
            arr[j] = arr[j - 1];
            j--; 
        }
        arr[j] = temp;
    }
}
```

11. replace values 数组长度如果是偶数就把所有元素都改成1，奇数就都改成0
bug: for loop 里的  i<=len, j<=len  把  <= 改成 < 
```java
public static int[] replaceValues(int arr[]) {
    int i, j, len = arr.length;
    if (len % 2 == 0) {
        for (i = 0; i <= len; i++) {  ===> for (i = 0; i < len; i++) {
     arr[i] = 0; 
        }
    } else {
        for (j = 0; j <= len; j++) {  ===> for (j = 0; j < len; j++) {
     arr[j] = 1; 
        }
    }
    return arr; 
}
```
9. reverse array  
但class 的名字居然是 sort array
bug: arr[len-1] 改成 arr[len-i-1] for 循环里的 len +=1去掉   
```java
public static int[] reverseArray(int[] arr) {
    int i, temp, originalLen = arr.length;
    int len = originalLen;
        for (i = 0; i < originalLen / 2; i++) {
            temp = arr[len -1]; ===> temp = arr[len - i - 1];
            arr[len - i - 1] = arr[i];
            arr[i] = temp;
            len +=1; ===> //remove  len += 1;
    }
    return arr;
}
```
10. EvenOdd pattern 
for 循环缺大括号      
```java
public static void print4(int num) {
    int i, print = 0;
    if (num % 2 == 0) {
        print = 0;
        for (i = 0; i < num; i++) ====> for ( i = 0; i < num; i++) {
            System.out.print(print + " ");
        print += 2; 
        ===> }
    } else { 
        print = 1;
        for (i = 0; i < num; i++) ====> for ( i = 0; i < num; i++) {
            System.out.print(print + " ");
        print += 2;
        ====> }
    }
}
```
14. Manchester:输入一个01数组，输出manchester编码，假设第一个 elem前的数字是 0
bug:里面就一个判断语句，把判断语句的  == 改成 != (考虑 if (i == 0) ? ) 
result = (A[i] == A[i - 1]); // bug
output[i] = result ? 1 : 0

15. PrintPattern2 
a
ab
abc
bug: 错在它把char ch = ‘a’ 定义放在了for loop 前，移进来就好，同时删掉了没用的变量。
```java
public static void print2(int row) {
    for (int j = 0; j <=i; j++) {
        char ch = 'a';
        char print = ch;
        System.out.print((ch++));
    }
   System.out.println("");
}
```
改为
```java
public static void print2(int row) {
    char ch = 'a';
    char print = ch;
    for (int j = 0; j <=i; j++) {
        System.out.print((print++));
}
System.out.println(“”);
```
            
16. PrintPattern3
有一道题是要给一个 row number，输出相应的行数的pattern。比如：    
row number = 3 则，输出 
11
1111
111111

row number = 2 则输出：     
11
1111

bug: 第一层 for 循环少了大括号，导致最后那个System.out.println() 最后只执行一次       
```java
public static void print3(int row) {
    int x = 1;
    for (int i = 1; i <= row; i++) {
         for (int j = i; j > 0; j--) ====> for (int j = i; j > 0; j--) {
             System.out.print(x + "" + x);
         ====> }
         System.out.println();
    }
}
``` 
17. remove duplicates form unsorted array 循环下标要从 i + 1  开始 

18. Array 奇数偶数 for loop i+=2 改成 i++

