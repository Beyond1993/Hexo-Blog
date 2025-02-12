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

```python
class Solution:
    def nextGreaterElement(self, n: int) -> int:
        # Convert the integer to a list of characters (digits)
        a = list(str(n))
        
        # Find the first decreasing element from the right
        i = len(a) - 2
        while i >= 0 and a[i + 1] <= a[i]:
            i -= 1
        
        # If no such element is found, return -1 (no greater number possible)
        if i < 0:
            return -1
        
        # Find the element to swap with (just greater than a[i])
        j = len(a) - 1
        while a[j] <= a[i]:
            j -= 1
        
        # Swap the two elements
        a[i], a[j] = a[j], a[i]
        
        # Reverse the portion of the list after i
        a = a[:i+1] + a[i+1:][::-1]
        
        # Convert the list back to an integer
        result = int(''.join(a))
        
        # If the result is out of the 32-bit integer range, return -1
        if result > 2**31 - 1 or result < -2**31:
            return -1
        
        return result
```


follow 如果考虑负数，找下一个大的组合：
```python

# Online Python - IDE, Editor, Compiler, Interpreter
class Solution:
    # 处理正数的下一个更大的数字
    def nextGreaterElement(self, n: int) -> int:
        # 如果是负数，先将其转为正数，调用nextSmallerElement，最后再转回负数
        if n < 0:
            res = self.nextSmallerElement(-n)  # 负数处理：调用nextSmallerElement并变回负数
            if res == -1: return res
            return -res

        nums = list(str(n))
        i = len(nums) - 2
        
        # 寻找第一个小于右边数字的元素
        while i >= 0 and nums[i] >= nums[i + 1]:
            i -= 1
        
        if i == -1:  # 如果没有找到
            return -1

        # 寻找比nums[i]大的最小数字
        j = len(nums) - 1
        while nums[j] <= nums[i]:
            j -= 1
        nums[i], nums[j] = nums[j], nums[i]

        # 反转i后面的部分
        nums[i + 1:] = reversed(nums[i + 1:])

        res = int(''.join(nums))

        # 检查是否超出32位整数范围
        if res > 2**31 - 1:
            return -1

        return res

    def nextSmallerElement(self, n: int) -> int:
        nums = list(str(n))
        i = len(nums) - 2
        
        # Find the first digit that is greater than its next digit (from right to left)
        while i >= 0 and nums[i] <= nums[i + 1]:
            i -= 1
        
        if i == -1:  # If no such digit is found, there's no smaller permutation
            return -1

        # Find the largest digit to the right of nums[i] that is smaller than nums[i]
        j = len(nums) - 1
        while nums[j] >= nums[i]:
            j -= 1
        
        # Swap nums[i] and nums[j]
        nums[i], nums[j] = nums[j], nums[i]

        # Sort the digits after index i in descending order to get the next smaller number
        nums[i + 1:] = sorted(nums[i + 1:], reverse=True)

        res = int(''.join(nums))

	if res > 2**31 - 1 or res < -2**31:
            return -1

        # If the result has a leading zero (e.g., 102 → 021), return -1
        if res < 10**(len(nums) - 1):
            return -1

        return res

def test_next_greater_element():
    solution = Solution()
    
    # Test positive numbers
    assert solution.nextGreaterElement(12) == 21
    assert solution.nextGreaterElement(21) == -1
    assert solution.nextGreaterElement(1234) == 1243
    assert solution.nextGreaterElement(4321) == -1
    assert solution.nextGreaterElement(199) == 919
    assert solution.nextGreaterElement(230241) == 230412

    # Test negative numbers
    assert solution.nextGreaterElement(-12) == -1
    assert solution.nextGreaterElement(-21) == -12
    assert solution.nextGreaterElement(-4321) == -4312
    assert solution.nextGreaterElement(-199) == -1
    assert solution.nextGreaterElement(-321) == -312

    # Test edge case
    assert solution.nextGreaterElement(2147483647) == -1  # Exceeds 32-bit integer limit
    assert solution.nextGreaterElement(-21474836477) == -1 # Exceeds 32-bit integer limit

# Run tests
test_next_greater_element()
print("All test cases passed!")
```
