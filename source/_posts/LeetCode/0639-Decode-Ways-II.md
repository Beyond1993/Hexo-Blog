---
title: 0639-Decode-Ways-II
date: 2019-05-12 17:35:09
categories: LeetCode
tags:
---

A message containing letters from A-Z is being encoded to numbers using the following mapping way:

'A' -> 1
'B' -> 2
...
'Z' -> 26
Beyond that, now the encoded string can also contain the character '*', which can be treated as one of the numbers from 1 to 9.

Given the encoded message containing digits and the character '*', return the total number of ways to decode it.

Also, since the answer may be very large, you should return the output mod 109 + 7.

Example 1:

Input: "*"
Output: 9
Explanation: The encoded message can be decoded to the string: "A", "B", "C", "D", "E", "F", "G", "H", "I".
Example 2:

Input: "1*"
Output: 9 + 9 = 18
Note:

The length of the input string will fit in range [1, 105].
The input string will only contain the character '*' and digits '0' - '9'.


part 1: current char is *


case 1.1:  123* 

dp[i+1] = 9 *  dp[i]

case 1.2:  121*

dp[i+1] = 9 * dp[i] + 9 * dp[i-1]; 

case 1.3:  122*

dp[i+1] = 9 * dp[i] + 6 * dp[i-1];

case 1.4:  12**

dp[i+1] = 9* dp[i] + 9 * dp[i-1] + 6 * dp[i-1] = 9 * dp[i] + 15 * dp[i-1]

the case 1.1 is the default case.

  
part 2: current char is not *

case 2.1 if char[i] == 0 && char[i-1] > 2, such as 1230
invalid

dp[i+1] = 0

case 2.2 if char[i][i-1] > 26 && char[i] != 0, such as 1227

dp[i+1] = dp[i]

case 2.3 if char[i-1] == 1 && char[i] = 0

dp[i+1] = dp[i]

case 2.4 if char[i-1] == 1 && char[i] != 0

dp[i+1] = dp[i] + dp[i-1]

case 2.5 if char[i-1] == * 

if char[i] < = 6
12*3

dp[i+1] = dp[i] + 2*dp[i-1]

else 
12*7

dp[i+1]  = dp[i] + dp[i-1]


init:

dp[0] = 1;
dp[1] = dp[1] = s.charAt(0) == '*' ? 9 : s.charAt(0) == '0' ? 0 : 1;








