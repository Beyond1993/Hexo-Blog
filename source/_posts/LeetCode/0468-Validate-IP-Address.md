---
title: 0468 Validate IP Address
date: 2019-07-31 01:36:23
categories: LeetCode
tags:
---

```java
class Solution {
    public String validIPAddress(String IP) {
        if (IP == null || IP.isEmpty()) {
           return "Neither"; 
        }
        boolean isIPv4 = true;
        boolean isIPv6 = true;
        String[] temp1 = IP.split("\\.", -1);
        String[] temp2 = IP.split(":", -1);
        
        if (temp1.length != 4 && temp2.length != 8) {
            return "Neither";
        } else if (temp1.length == 4) {
            for (int i = 0; i < 4; i ++) {
                String cur = temp1[i];
                if (!isTen(cur)) {
                    isIPv4 = false;
                    break;
                }
            }
            if (isIPv4) {
                return "IPv4";
            }
            
        } else if (temp2.length == 8) {
            for (int i = 0; i < temp2.length; i++) {
                String cur = temp2[i];
               // System.out.println(cur);
                if (!isHex(cur)) {
                    isIPv6 = false;
                    break;
                }
            }
             if (isIPv6) {
                return "IPv6";
             }
        }
        
        return "Neither";
    }
    
    private boolean isHex(String number) {
        if (number == null || number.isEmpty() || number.length() > 4) {
            return false;
        }
        
        for (int i = 0; i < number.length(); i++) {
            char c = number.charAt(i);
            if (!((c >= '0' && c <= '9' ) || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F') )) return false; 
            
        }
        
        return true;
    }
    
    private boolean isTen(String number) {
        if (number == null || number.isEmpty()) {
            return false;
        }
        
        if (number.charAt(0) == '0' && number.length() > 1) {
            return false;
        }
        int sum = 0;
        for (int i = 0; i < number.length(); i++) {
            char c = number.charAt(i);
            if (!(c >= '0' && c <= '9' ) ) return false;
            sum +=  (c - '0') * Math.pow(10, number.length() - 1 - i); 
        }
        if (sum > 255) {
            return false;
        }
        return true;
    }
}
```
