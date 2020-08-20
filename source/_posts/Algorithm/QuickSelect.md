---
title: QuickSelect
date: 2017-12-14 06:47:00
categories: Algorithm
tags:
---

QuickSelect 的时间复杂度一般来说是 O(N)


```java
import java.util.Arrays;
public final class QuickSelect {
  public static int selectIterative(int[] array, int n) {
    return iterative(array, 0, array.length - 1, n);
  }
  
  private static int iterative(int[] array, int left, int right, int n) {
      if(left == right) {
        return array[left];
      }
      
      for(;;) {
        int pivotIndex = randomPivot(left, right);
        pivotIndex = partition(array, left, right, pivotIndex);
        
        if(n == pivotIndex) {
          return array[n];
        } else if(n < pivotIndex) {
          right = pivotIndex - 1;
        } else {
          left = pivotIndex + 1;
        }
      }
  }
  
  private static int partition(int[] array, int left, int right, int pivotIndex) {
    int pivotValue = array[pivotIndex];
    swap(array, pivotIndex, right); // move pivot to end
    int storeIndex = left; // storeIndex 存的是从左往右 第一个比 pivotValue 大的元素
    for(int i = left; i < right; i++) {
      if(array[i] < pivotValue) {
        swap(array, storeIndex, i);
        storeIndex++;
      }
    }
    swap(array, right, storeIndex); // Move pivot to its final place
    return storeIndex;
  }
  
  private static void swap(int[] array, int a, int b) {
    int tmp = array[a];
    array[a] = array[b];
    array[b] = tmp;
  }

  private static int randomPivot(int left, int right) {
    return left + (int) Math.floor(Math.random() * (right - left + 1));
  }  
    
  public static void main(String[] args) {
      int[] array = {9, 8, 7, 6, 5, 0, 1, 2, 3, 4};
      
      for(int i = 0; i < array.length; i++) {
        System.out.println(selectIterative(array, i));
      }
      
      for(int i = 0; i < array.length; i++) {
        System.out.println(selectRecursive(array, i));
      }
    }
}

```

递归版代码

```java
public static int selectRecursive(int[] array, int n) {
  return recursive(array, 0, array.length - 1, n);
}
private static int recursive(int[] array, int left, int right, int n) {
    if (left == right) { // If the list contains only one element,
      return array[left]; // return that element
    }
    
    // select a pivotIndex between left and right
    int pivotIndex = randomPivot(left, right); 
    pivotIndex = partition(array, left, right, pivotIndex);
    // The pivot is in its final sorted position
    if (n == pivotIndex) {
      return array[n];
    } else if (n < pivotIndex) {
      return recursive(array, left, pivotIndex - 1, n);
    } else {
      return recursive(array, pivotIndex + 1, right, n);
    }
}
```
