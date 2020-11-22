---
title: 0981 Time Based Key-Value Store
date: 2020-11-23 03:40:19
categories:
tags:
---



```java
class TimeMap {

    Map<String, TreeMap<Integer, String> > map;
    
    /** Initialize your data structure here. */
    public TimeMap() {
        map = new HashMap<>();
    }
    
    public void set(String key, String value, int timestamp) {
        if (map.containsKey(key)) {
            TreeMap<Integer, String> treeMap = map.get(key);
            treeMap.put(timestamp, value);
        } else {
            TreeMap<Integer, String> treeMap = new TreeMap<>();
            treeMap.put(timestamp, value);
            map.put(key, treeMap);
        }
    }
    
    public String get(String key, int timestamp) {
        if (!map.containsKey(key)) {
            return "";
        }
        
        TreeMap<Integer, String> treeMap = map.get(key);
        
        Integer k = treeMap.floorKey(timestamp);
        
        return k == null ? "" : treeMap.get(k);
    }
}
```
