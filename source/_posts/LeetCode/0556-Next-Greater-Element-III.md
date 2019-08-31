---
title: 0556. Next Greater Element III
date: 2019-08-31 19:01:06
categories: LeetCode
tags:
---



错误思路

```java
class Solution {
    public int nextGreaterElement(int n) {
        List<Integer> num = new ArrayList<>();
    //3 / 10 = 0 ..3
    int r = 0;
    //
    while(n != 0) { //2
      r = n % 10; //2
      num.add(0, r); //[3,1,2,2,0,3,4]
      n = n /10; //312043
    }
    // 11  2 1
     //        i
    // 3,1,2,0,4,3,2     0 3 4 
    //find postion
    int smallest = 10;
    int smallestIndex = -1;
    int i = num.size() - 1; // 6
    
    while( i > 0) {
      if (num.get(i) <= smallest) { //2
        smallestIndex = i; //2
        smallest = num.get(i);//6
      }
      //i = 4
      // i - 1
      if (num.get(i-1) < num.get(i)) {
        break;
      }
      i--;
    }
    
    if (i == 0) {
      return -1;
    }
    // i = 4
    int temp = num.get(i - 1); // 0
    
    if (smallest <= temp) {
        
        List<Integer> buffer = new ArrayList<Integer>();
        for (int j = smallestIndex - 1; j < num.size(); j++) {
            buffer.add(num.get(j));
        }
        //buffer.add(num.get(i-1));
        
        List<Integer> b2 = new ArrayList<Integer>();
        
        for (int l = i - 1; l < smallestIndex - 1; l++) {
            b2.add(num.get(l));
        }
        
        Collections.sort(b2);
        int index = i-1;
        for (int k = 0; k < buffer.size(); k++) {
            System.out.println(index + " " + buffer.get(k));
            num.set(index, buffer.get(k));
            index++;
        }
        
        for (int k = 0; k < b2.size(); k++) {
            num.set(index, b2.get(k));
            index++;
        }
        
    } else { 
        int count = 1;
        // j = 5, 3
        for (int j = i; j < num.size() - 1; j++) {
          num.set(num.size() - count, num.get(j));
          count++;
        }

        num.set(i, temp);
        //System.out.println(smallest + " " + i );
        num.set(i - 1, smallest);
    }
    
    //System.out.println(num);
    int result = 0;
    
    for (int k = 0; k < num.size(); k++) {
      result = result * 10; 
      result += num.get(k);
      //System.out.println(result);
    }
    
    return result;
    }
}
```


交换 实现两个目标,

1. 保证了 新生成 的数比原来大
2. 保证后半部分有序

交换之后，后半部分肯定是 递减有序的，

reverse 保证了在交换之后的数 最小

举个例子:

312 2 4331


```txt
  ^
4 |         * 
3 | *         * *
2 |     * * 
1 |   *           *
0 +------------------> index 
    0 1 2 3 4 5 6 7
```






```java
class Solution {
    public int nextGreaterElement(int n) {
        char[] nums = String.valueOf(n).toCharArray();
        int i = nums.length - 1;
        while(i > 0) {
            if (nums[i-1] < nums[i]) { break; }
            i--;
        }
        if (i == 0) return -1;
        int j = nums.length - 1;
        
        while(nums[j] <= nums[i - 1]) { j--; }
        
        swap(nums, i - 1, j);
        reverse(nums, i);
        try {
            return Integer.valueOf(String.valueOf(nums));
        } catch (Exception e) {
            return -1;
        }   
    }
    private void swap(char[] nums, int i, int j) {
        char temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }
    
    private void reverse(char[] nums, int i) {
        int j = nums.length - 1;
        while(i < j) {
            swap(nums, i, j);
            i++;
            j--;
        }
    }
    
}
```
